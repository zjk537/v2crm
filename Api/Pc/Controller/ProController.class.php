<?php

/**
 *      产品管理控制器
 *
 *      @author zjk
 *
 */

namespace Pc\Controller;

use Think\Controller;

class ProController extends CommonController
{

    public function _initialize()
    {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }

    public function thumbImg(){
        $data            = $this->postData;
        $dir = C('UPLOAD_SAVEPATH').$data['dir'];
        $dir_list = scandir($dir);
        $i = 0; $start = $data['page'] * $data['size']; $end = $start + $data['size'];
        foreach($dir_list as $file){

            if($file == '..' || $file == '.' || $file == '.DS_Store'){
                continue;
            }
            $i++;
            if($i > $end){
                break;
            }
            if($i > $start){
                // 直接压缩
                thumb_img('./'.$dir.'/'.$file);  
            }
        }
        $res = array(
            'page' => $data['page'], 
            'size' => $data['size'], 
            'current' => $i,
            'total' => count($dir_list),
        );
        $this->mtReturn('操作成功',200, $res);
    }

    public function _filter(&$map)
    {
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['`' . C('DB_PREFIX') . 'pro`.`depid`'] = array('EQ', getdepid());
        }
        if (!empty($this->postData['stime']) && !empty($this->postData['etime'])) {
            $stime = date("Y-m-d 00:00:00",strtotime($this->postData['stime']));
            $etime = date("Y-m-d 24:00:00",strtotime($this->postData['etime']));

            $map['`' . C('DB_PREFIX') . 'pro`.`updatetime`'] = array(array('egt', $stime), array('elt', $etime));
        }
        if (!empty($this->postData['ostime']) && !empty($this->postData['oetime'])) {
            $ostime = date("Y-m-d 00:00:00",strtotime($this->postData['ostime']));
            $oetime = date("Y-m-d 24:00:00",strtotime($this->postData['oetime']));
            $map['`' . C('DB_PREFIX') . 'pro`.`outtime`'] = array(array('egt', $ostime), array('elt', $oetime));
        }
        if (empty($this->postData['keys'])) {
            return;
        }
        $keys = strtolower($this->postData['keys']);

        switch ($keys) {
            case 'jsbaojing': // 寄售报警
                unset($map['_complex']);
                $map['`' . C('DB_PREFIX') . 'pro`.`code`']   = array('eq', '寄售');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`'] = array('eq', '在库');
                $map['_string']                              = 'datediff(`' . C('DB_PREFIX') . 'pro`.`endtime`,NOW()) <= ' . C('PRO_JS_WARN');
                break;
            case 'kcbaojing': // 寄售报警
                unset($map['_complex']);
                $map['`' . C('DB_PREFIX') . 'pro`.`status`']    = array('eq', '售出');
                $map['`' . C('DB_PREFIX') . 'pro`.`paystatus`'] = array('eq', '未打款');
                $map['_string']                                 = 'datediff(`' . C('DB_PREFIX') . 'pro`.`outtime`,NOW()) <= ' . C('PRO_SC_WARN');
                break;
            case 'jsweidakuan': // 寄售已售出未打款
                unset($map['_complex']);
                //`type` = '寄售' AND `status` = '售出' AND `paystatus` = '未打款'
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']      = array('eq', '寄售');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`']    = array('eq', '售出');
                $map['`' . C('DB_PREFIX') . 'pro`.`paystatus`'] = array('eq', '未打款');
                break;
            case 'jschaoqi': // 寄售超期
                unset($map['_complex']);
                //`type` = '寄售' AND `status` = '在库' AND  `endtime` < NOW()
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']    = array('eq', '寄售');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`']  = array('eq', '在库');
                $map['`' . C('DB_PREFIX') . 'pro`.`endtime`'] = array('lt', gettime());
                break;
            case 'jskucun': // 寄售库存
                unset($map['_complex']);
                //`type` = '寄售' AND `status` = '在库'
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']   = array('eq', '寄售');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`'] = array('eq', '在库');
                break;
            case 'jhweidakuan': // 进货商品已售出未打款
                unset($map['_complex']);
                // `type` = '' AND `status`  = '售出' AND `paystatus` = '未打款'
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']      = array('eq', '进货');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`']    = array('eq', '售出');
                $map['`' . C('DB_PREFIX') . 'pro`.`paystatus`'] = array('eq', '未打款');
                break;
            case 'jhchaoqi': // 自有商品 超时 默认 180天
                unset($map['_complex']);
                // `type` = '进货' AND `status` = '在库' AND  DATEDIFF(`updatetime`,NOW()) > %s
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']   = array('eq', '进货');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`'] = array('eq', '在库');
                // $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`updatetime`,NOW()) <= '.C('PRO_SC_WARN');
                $map['_string'] = 'DATEDIFF(`' . C('DB_PREFIX') . 'pro`.`updatetime`,NOW()) > 180';
                break;
            case 'jhkucun': // 自有商品 未售出库存
                unset($map['_complex']);
                //`type` = '进货' AND `status` = '在库'
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']   = array('eq', '进货');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`'] = array('neq', '在库');
                break;
            default:
                # code...
                break;
        }
    }

    public function _after_list($data)
    {

    }

    private function fieldMap($prefix, $array)
    {
        $tmpArr = array();
        foreach ($array as $value) {
            $asName = $prefix.$value;
            $newValue = '`' . C('DB_PREFIX') . $prefix . '`.`' . $value . '` as `' . $asName . '`';
            $authField = MODULE_NAME . '/'. $prefix . '/dbfields'; // 功能列表中配置的 商品属性 客户属性
            if(in_array($asName, C('AUTH_FIELDS')) && !authcheck($authField, $this->curUser['uid'])){
                $newValue = "NULL as `". $asName ."`";
            } 
            array_push($tmpArr, $newValue);
        }
        return $tmpArr;
    }

    public function _complex_field()
    {
        $proFields    = $this->fieldMap('pro', M('pro')->getDbFields());
        $proinFields  = $this->fieldMap('proin', M('proin')->getDbFields());
        $prooutFields = $this->fieldMap('proout', M('proout')->getDbFields());
        $custFields   = $this->fieldMap('cust', M('cust')->getDbFields());
        $depFields = array();
        array_push($depFields, '`' . C('DB_PREFIX') . 'auth_group`.`name` as `prodepname`');
        array_push($depFields, '`' . C('DB_PREFIX') . 'auth_group`.`phone` as `prodepphone`');

        // 超管 店长可查看进价
        // $posArrName = array('超管', '店长');
        // if (!in_array($this->curUser['uid'], C('ADMINISTRATOR')) && !in_array(trim($this->curUser['posname']), $posArrName))
        // {
        //     $key = array_search('`' . C('DB_PREFIX') .'pro`.`jiage` as `projiage`', $proFields);
        //     unset($proFields[$key]);
        // }

        $field        = implode(',', $proFields) . ','
        . implode(',', $depFields) . ','
        . implode(',', $proinFields) . ','
        . implode(',', $prooutFields) . ','
        . implode(',', $custFields);
        return $field;
    }
    public function _complex_join()
    {
        // $join = sprintf('LEFT JOIN `%1$sproin` ON `%1$spro`.`id` = `%1$sproin`.`jpid`
        //     LEFT JOIN `%1$sauth_group` on `%1$spro`.`depid` = `%1$sauth_group`.`id`
        //     LEFT JOIN (SELECT a.* FROM `%1$sproout` as a INNER JOIN (SELECT max(`id`) as id FROM `%1$sproout` group by `jpid`) as b on a.id = b.id) as `%1$sproout` on `%1$spro`.`id` = `%1$sproout`.`jpid`
        //     LEFT JOIN `%1$scust` on `%1$spro`.`cid` = `%1$scust`.`id`', C('DB_PREFIX'));

        $join = sprintf('LEFT JOIN `%1$sproin` ON `%1$spro`.`id` = `%1$sproin`.`jpid`
            LEFT JOIN `%1$sauth_group` on `%1$spro`.`depid` = `%1$sauth_group`.`id`
            LEFT JOIN `%1$sproout` on `%1$sproout`.`jpid` = `%1$spro`.`id`
            LEFT JOIN `%1$sproout` tmp_out on tmp_out.`jpid` = `%1$sproout`.`jpid` and tmp_out.`id` > `%1$sproout`.`id`
            LEFT JOIN `%1$scust` on `%1$spro`.`cid` = `%1$scust`.`id`', C('DB_PREFIX'));
        return $join;
    }
    public function _after_count(&$map){
        $map['`tmp_out`.`id`'] = array('exp', 'is null'); // tmp_out 在_complex_join 为 v2_proout 起的别名
    }

    public function _befor_add()
    {
        

    }

    public function _after_add($id)
    {
        // 更新进货记录
        $data            = $this->postData;
        $data['jpid']    = (int) $id;
        $data['jpname']  = $data['name'];
        $data['jpjiage'] = $data['jiage'];
        $data['remark']  = '';
        $proin           = A('Proin');
        $proin->autoAdd($data);

        // 保存图片
        $this->saveImages($id);

        $model = D($this->dbname);
        $map = array();
        $map['`' . C('DB_PREFIX') . 'pro`.`id`'] = array('EQ', $id);
        $join = $this->_complex_join();
        $field = $this->_complex_field();
        $voList = $model->join($join)->where($map)->field($field)->select();
        return $voList;
    }

    public function _befor_insert($data)
    {
        $code = 'ZY';
        if ($data['type'] == '寄售') {
            $code              = 'JS';
            $data['starttime'] = gettime();
            $data['endtime']   = empty($data['endtime']) ? null : $data['endtime'];
        } else {
            $code = 'ZY';
            unset($data['endtime']);
        }
        $model           = D($this->dbname);
        $count           = $model->where('date(addtime) = CURDATE() AND depid='.getdepid())->count('id');
        $data['code']    = $code . date("Ymd", time()) . str_pad($count + 1, 3, '0', STR_PAD_LEFT);
        $data['addtime'] = gettime();

        // 更新供应商
        $custData           = $this->postData['cust'];
        $custData['juid']   = $this->postData['juid'];
        $custData['juname'] = $this->postData['juname'];
        $cust               = A('cust');
        $custid             = $cust->autoUpdate($custData);

        $data['cid']   = $custid;
        $data['cname'] = $custData['name'];
        return $data;
    }

    public function _befor_edit()
    {
        // $model = D($this->dbname);
        // $info  = $model->find(I('get.id'));
        // $attid = $info['attid'];
        // $this->assign('attid', $attid);
    }

    public function _befor_update($data)
    {
        // 已售出的不能重复售出
        $data = $this->postData;
        $data['jpid']    = (int) $data['id'];
        $data['jpname']  = $data['name'];
        // 更新进货记录
        if($data['status'] === '在库'){
            
            // // 超管 店长可查看进价
            // $posArrName = array('超管', '店长');
            // if (!in_array($this->curUser['uid'], C('ADMINISTRATOR')) && !in_array(trim($this->curUser['posname']), $posArrName))
            // {
            //     unset($data['jpjiage']);
            //     unset($data['jiage']);
            // }

            $proin           = A('Proin');
            $proin->autoAdd($data);
        } elseif ($data['status'] === '预订' || $data['status'] === '售出'){
            // 更新出库记录
            $data['jpsjiage'] = $data['sjiage'];
            $data['beizhu'] = $data['remark'];
            $proout = A('proout');
            $proout->autoAdd($data);
        }

        // 更新供应商
        $custData           = $data['cust'];
        $custData['juid']   = $data['juid'];
        $custData['juname'] = $data['juname'];
        $cust               = A('cust');
        $custid             = $cust->autoUpdate($custData);

        // 更新商品信息
        if ($data['type'] == '寄售') {
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
            $model           = D($this->dbname);
            $info            = $model->getById($data['id']);
            if (empty($info['starttime'])) {
                $data['starttime'] = gettime();
            }
        } else {
            unset($data['endtime']);
            $data['starttime'] = null;
        }
        $data['cname'] = $custData['name'];
        $data['cid'] = $custid;

        // 过滤受权限控制的字段 无权限字段不能更新
        $authField = MODULE_NAME . '/pro/dbfields';
        if(!authcheck($authField, $this->curUser['uid'])){
            foreach(C('AUTH_FIELDS') as $value){ 
                $fieldName = str_replace('pro', '', $value);// projiage --> jiage
                unset($data[$fieldName]);
            }
        }
        return $data;
    }

    public function _after_edit($id)
    {   
        // 更新图片信息
        $this->saveImages($id);

        $model = D($this->dbname);
        $map = array();
        $map['`' . C('DB_PREFIX') . 'pro`.`id`'] = array('EQ', $id);
        $join = $this->_complex_join();
        $field = $this->_complex_field();
        $voList = $model->join($join)->where($map)->field($field)->select();
        return $voList;
    }

    public function _befor_del($id)
    {

    }

    public function outxls()
    {
        $model = D($this->dbname);
        $map   = $this->_search();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        $list     = $model->where($map)->field('id,name,fenlei,jiage,sjiage,type,uname,addtime,updatetime')->select();
        $headArr  = array('商品编码', '商品名称', '商品分类', '进价', '售价', '计量单位', '添加人', '添加时间', '更新时间');
        $filename = '商品信息';
        $this->xlsout($filename, $headArr, $list);
    }

    // 寄售商品未售出 可取回
    public function quhui()
    {

        $model = D($this->dbname);
        $ids   = $this->postData['ids'];
        if (empty($ids)) {
            $this->mtReturn("取回商品不能为空！");
        }
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']       = array('in', implode(',', $ids));
        $map['type']   = array('eq', '寄售');
        $where['status'] = array('neq', '售出');
        $where['status'] = array('neq', '预订');
        $where['_logic'] = 'or';
        $map['_complex'] = $where;
        $tmpCount        = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn('【寄售】商品【未售出】【未预订】时可取回');
        }
        $data['id']     = array('in', implode(',', $ids));
        $data['status'] = '取回';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn($model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname . ' 取回成功! proid:' . implode('|', $ids), 200);
    }

    // 售出商品可退货
    public function tuihuo()
    {
        $model = D($this->dbname);
        $ids   = $this->postData['ids'];
        if (empty($ids)) {
            $this->mtReturn("退货商品不能为空！");
        }
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']     = array('in', implode(',', $ids));
        $map['status'] = array('neq', '售出');
        $tmpCount      = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn('只有售出的商品才可退货');
        }
        $data['id']     = array('in', implode(',', $ids));
        $data['sjiage'] = 0;
        $data['yufu'] = 0;
        $data['zhekou'] = 0;
        $data['outtime'] = null;
        $data['status'] = '在库';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn($model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname . ' 退货成功! proid:' . implode('|', $ids), 200);
    }

    // 寄售商品 售出但未打款 可打款
    public function dakuan()
    {
        $model = D($this->dbname);
        $ids   = $this->postData['ids'];
        if (empty($ids)) {
            $this->mtReturn("需打款商品不能为空！");
        }

        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']          = array('in', implode(',', $ids));
        $where['type']        = array('neq', '寄售');
        $where['status']    = array('neq', '售出');
        $where['paystatus'] = array('neq', '未打款');
        $where['_logic']    = 'or';
        $map['_complex']    = $where;
        $tmpCount           = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn('【寄售】商品【售出】但【未打款】才需打款');
        }
        $data['id']        = array('in', implode(',', $ids));
        $data['paystatus'] = '已打款';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn($model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname . ' 打款成功! proid:' . implode('|', $ids), 200);
    }

    public function gettypes()
    {
        $model = D($this->dbname);
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $resData = array();
        $types   = $model->distinct(true)->where($map)->field('pinpai')->select();
        foreach ($types as $type) {
            array_push($resData, $type['pinpai']);
        }

        $this->mtReturn('Success', 200, $resData);
    }

    // 商品售出后，自动更新商品售价信息等
    public function autoUpdate($data)
    {
        $model = D('pro');
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn($model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn($model->getError());
        }
    }

    public function baojing()
    {
        // 寄售 到期前7天预警   售出2天后还未付款预警
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $mapJS['depid'] = array('EQ', getdepid());
            $mapSC['depid'] = array('EQ', getdepid());
        }
        $model            = D($this->dbname);
        $mapJS['type']    = array('eq', '寄售');
        $mapJS['status']  = array('eq', '在库');
        $mapJS['_string'] = 'datediff(`endtime`,NOW()) < ' . C('PRO_JS_WARN');
        $resData['jsdue'] = $model->where($mapJS)->count();

        $mapSC['status']    = array('eq', '售出');
        $mapSC['paystatus'] = array('eq', '未打款');
        $mapSC['_string']   = 'datediff(`outtime`,NOW()) <= ' . C('PRO_SC_WARN');
        $resData['paydue']  = $model->where($mapSC)->count();
        $this->mtReturn("Success", 200, $resData);
    }

    public function tongji()
    {
        $model   = M();
        $dayspan = (int) $this->postData['dayspan'] ? 180 : (int) $this->postData['dayspan'];
        $sql     = sprintf("SELECT
                SUM(CASE WHEN `type` = '寄售' AND `status` = '售出' AND `paystatus` = '未打款' THEN 1 ELSE 0 END) AS JSWeiDaKuan, -- 寄售 已售 未打款 数
                SUM(CASE WHEN `type` = '寄售' AND `status` = '在库' AND  `endtime` < NOW() THEN 1 ELSE 0 END) AS JSChaoQi, -- 寄售到期
                SUM(CASE WHEN `type` = '寄售' AND `status` = '在库' THEN 1 ELSE 0 END) AS JSKuCun, -- 寄售未售出数
                SUM(CASE WHEN `type` = '进货' AND `status`  = '售出' AND `paystatus` = '未打款' THEN 1 ELSE 0 END) AS JHWeiDaKuan, -- 自有 已售 未打款 数
                SUM(CASE WHEN `type` = '进货' AND `status` = '在库' AND  DATEDIFF(`updatetime`,NOW()) > %s THEN 1 ELSE 0 END) AS JHChaoQi, -- 自有超过180天没有数据更新
                SUM(CASE WHEN `type` = '进货' AND `status` = '在库' THEN 1 ELSE 0 END) AS JHKuCun, -- 自有未售出数
                COUNT(`addtime`) AS JinHuoLiang, -- 进货量 包含寄售 自有
                SUM(CASE WHEN `status` = '预订' OR `status` = '售出' then 1 ELSE 0 end) AS XiaoShouLiang -- 销售量
            FROM `v2_pro` WHERE 1 = 1", $dayspan);

        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $sql .= ' AND depid = ' . getdepid();
        }
        if (!empty($this->postData['stime']) && !empty($this->postData['etime'])) {
            $sql .= " AND `updatetime` BETWEEN " . $this->postData['stime'] . " AND " . $this->postData['etime'];
        }
        $resData = $model->query($sql);

        $this->mtReturn('Success', 200, $resData[0]);

    }

    public function getimages()
    {
        $attid = $this->postData['attid'];
        $resData = array();
        $files = M('files')->where('attid='.$attid)->select();
        foreach ($files as $file) {
            $str = file_get_contents($file['filename']);
            $base64Str = 'data:image/'.$file['filetype'].';base64,'.base64_encode($str);
            array_push($resData,$base64Str);
        }
        $this->mtReturn('Success',200,$resData);
    }

    private function saveImages($id)
    {
        $images = $this->postData['images'];
        // 为空表示没有更新图片
        if(empty($images)){
            return;
        }
        $model = M('files');

        //清空所有数据 传一个空字符串
        $map['attid'] = array('eq',$id);
        $files = $model->where($map)->select();
        if($files){
            foreach ($files as $file) {
                @unlink($file['filename']);
            }
        }
        $model->where($map)->delete();

        foreach ($images as $imgData) {
            $result = saveBase64Image($imgData);
            if($result['code'] === 0){ // 0 保存成功  1 图片数据为空  >1 其他错误
                $data['attid'] = (int)$id;
                $data['filename'] = $result['filename'];
                $data['filetype'] = $result['filetype'];
                $data['uid'] = getuserid();
                $data['uname'] = gettruename();
                $data['addtime'] = gettime();
                $model->data($data)->add();
            } elseif ($result['code'] > 1) { 
                // 图片保存失败 多个图片时，错误是怎么提示
            }
        }
    }
}
