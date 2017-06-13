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

    public function _filter(&$map)
    {
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        if (!empty($this->postData['stime']) && !empty($this->postData['etime'])) {
            $map['`' . C('DB_PREFIX') . 'pro`.`addtime`'] = array(array('egt', $this->postData['stime']), array('elt', $this->postData['etime']));
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
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']      = array('eq', '进货自有');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`']    = array('eq', '售出');
                $map['`' . C('DB_PREFIX') . 'pro`.`paystatus`'] = array('eq', '未打款');
                break;
            case 'jhchaoqi': // 自有商品 超时 默认 180天
                unset($map['_complex']);
                // `type` = '进货自有' AND `status` = '在库' AND  DATEDIFF(`updatetime`,NOW()) > %s
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']   = array('eq', '进货自有');
                $map['`' . C('DB_PREFIX') . 'pro`.`status`'] = array('eq', '在库');
                // $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`updatetime`,NOW()) <= '.C('PRO_SC_WARN');
                $map['_string'] = 'DATEDIFF(`' . C('DB_PREFIX') . 'pro`.`updatetime`,NOW()) > 180';
                break;
            case 'jhkucun': // 自有商品 未售出库存
                unset($map['_complex']);
                //`type` = '进货自有' AND `status` = '在库'
                $map['`' . C('DB_PREFIX') . 'pro`.`type`']   = array('eq', '进货自有');
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
            $newValue = '`' . C('DB_PREFIX') . $prefix . '`.`' . $value . '` as `' . $prefix . $value . '`';
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
        $field        = implode(',', $proFields) . ','
        . implode(',', $proinFields) . ','
        . implode(',', $prooutFields) . ','
        . implode(',', $custFields);
        return $field;
    }
    public function _complex_join()
    {
        $join = sprintf('LEFT JOIN `%1$sproin` ON `%1$spro`.`id` = `%1$sproin`.`jpid`
            LEFT JOIN `%1$sproout` on `%1$spro`.`id` = `%1$sproout`.`jpid`
            LEFT JOIN `%1$scust` on `%1$spro`.`cid` = `%1$scust`.`id`', C('DB_PREFIX'));
        return $join;
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
        $count           = $model->where('date(addtime) = CURDATE()')->count('id');
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
            $data['jpjiage'] = $data['jiage'];
            //$data['remark']  = '';
            $proin           = A('Proin');
            $proin->autoAdd($data);
        } elseif ($data['status'] === '预定' || $data['status'] === '售出'){
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
        return $data;
    }

    public function _after_edit($id)
    {
        // 更新图片信息
        $this->saveImages($id);
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
        $where['type']   = array('neq', '寄售');
        $where['status'] = array('eq', '售出');
        $where['_logic'] = 'or';
        $map['_complex'] = $where;
        $tmpCount        = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn('寄售商品未售出时可取回');
        }
        // $data['id'] = $this->postData['id'];
        // $tmpPro = $model->where(array('id' => $data['id']))->select();
        // if($tmpPro[0]['status'] != '售出'){
        //     $this->mtReturn('售出的商品才能取回');
        // }
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
        $map['type']        = array('neq', '寄售');
        $where['status']    = array('neq', '售出');
        $where['paystatus'] = array('neq', '未打款');
        $where['_logic']    = 'or';
        $map['_complex']    = $where;
        $tmpCount           = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn('寄售商品售出但未打款才需打款');
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
        $types   = $model->distinct(true)->where($map)->field('fenlei')->select();
        foreach ($types as $type) {
            array_push($resData, $type['fenlei']);
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
                SUM(CASE WHEN `type` = '进货自有' AND `status`  = '售出' AND `paystatus` = '未打款' THEN 1 ELSE 0 END) AS JHWeiDaKuan, -- 自有 已售 未打款 数
                SUM(CASE WHEN `type` = '进货自有' AND `status` = '在库' AND  DATEDIFF(`updatetime`,NOW()) > %s THEN 1 ELSE 0 END) AS JHChaoQi, -- 自有超过180天没有数据更新
                SUM(CASE WHEN `type` = '进货自有' AND `status` = '在库' THEN 1 ELSE 0 END) AS JHKuCun, -- 自有未售出数
                COUNT(`addtime`) AS JinHuoLiang, -- 进货量 包含寄售 自有
                SUM(CASE WHEN ISNULL(`outtime`) then 0 ELSE 1 end) AS XiaoShouLiang -- 销售量
            FROM `v2_pro` WHERE 1 = 1", $dayspan);

        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $sql .= ' AND depid = ' . getdepid();
        }
        if (!empty($this->postData['stime']) && !empty($this->postData['etime'])) {
            $sql .= " AND `addtime` BETWEEN " . $this->postData['stime'] . " AND " . $this->postData['etime'];
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
