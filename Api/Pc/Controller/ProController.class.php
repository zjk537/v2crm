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
        //if(!in_array(session('uid'),C('ADMINISTRATOR'))){
        //$map['id'] = array('EQ', session("uid"));
        //}
        if(!empty($this->postData['stime']) && !empty($this->postData['etime'])){
            $map['`'.C('DB_PREFIX').'pro`.`addtime`'] = array(array('egt',$this->postData['stime']),array('elt',$this->postData['etime'])) ;
        }
        if(empty($this->postData['keys'])){
            return;
        }
        $keys = strtolower($this->postData['keys']);
        
        switch ($keys) {
            case 'jsbaojing':// 寄售报警
                unset($map['_complex']);
                $map['`'.C('DB_PREFIX').'pro`.`code`'] = array('eq', '寄售');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
                $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`endtime`,NOW()) <= '.C('PRO_JS_WARN');
                break;
            case 'kcbaojing': // 寄售报警
                unset($map['_complex']);
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('eq','售出');
                $map['`'.C('DB_PREFIX').'pro`.`paystatus`'] = array('eq','未打款');
                $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`outtime`,NOW()) <= '.C('PRO_SC_WARN');
                break;
            case 'jsweidakuan': // 寄售已售出未打款
                unset($map['_complex']);
                //`type` = '寄售' AND `status` = '售出' AND `paystatus` = '未打款' 
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','寄售');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('eq','售出');
                $map['`'.C('DB_PREFIX').'pro`.`paystatus`'] = array('eq','未打款');
                break;
            case 'jschaoqi': // 寄售超期
                unset($map['_complex']);
                //`type` = '寄售' AND `status` != '售出' AND  `endtime` < NOW() 
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','寄售');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
                $map['`'.C('DB_PREFIX').'pro`.`endtime`'] = array('lt',gettime());
                break;
            case 'jskucun': // 寄售库存
                unset($map['_complex']);
                //`type` = '寄售' AND `status` != '售出' 
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','寄售');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
                break;
            case 'jhweidakuan': // 进货商品已售出未打款
                unset($map['_complex']);
                // `type` = '' AND `status`  = '售出' AND `paystatus` = '未打款'
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','进货自有');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('eq','售出');
                $map['`'.C('DB_PREFIX').'pro`.`paystatus`'] = array('eq','未打款');
                break;
            case 'jhchaoqi': // 自有商品 超时 默认 180天
                unset($map['_complex']);
                // `type` = '进货自有' AND `status` != '售出' AND  DATEDIFF(`updatetime`,NOW()) > %s 
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','进货自有');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
                // $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`updatetime`,NOW()) <= '.C('PRO_SC_WARN');
                $map['_string'] = 'DATEDIFF(`'.C('DB_PREFIX').'pro`.`updatetime`,NOW()) > 180';
                break;
            case 'jhkucun': // 自有商品 未售出库存
                unset($map['_complex']);
                //`type` = '进货自有' AND `status` != '售出'
                $map['`'.C('DB_PREFIX').'pro`.`type`'] = array('eq','进货自有');
                $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
                break;
            default:
                # code...
                break;
        }
    }

    public function _after_list($data)
    {
        
    }

    private function fieldMap($prefix,$array)
    {
        $tmpArr = array();
        foreach ($array as $value) {
            $newValue = '`'.C('DB_PREFIX').$prefix.'`.`'.$value.'` as `'.$prefix.$value.'`';
            array_push($tmpArr, $newValue);
        }
        return $tmpArr;
    }

    public function _complex_field()
    {
        $proFields = $this->fieldMap('pro',M('pro')->getDbFields());
        $proinFields = $this->fieldMap('proin',M('proin')->getDbFields());
        $prooutFields = $this->fieldMap('proout',M('proout')->getDbFields());
        $custFields = $this->fieldMap('cust',M('cust')->getDbFields());
        $field = implode(',', $proFields).','
                .implode(',', $proinFields).','
                .implode(',', $prooutFields).','
                .implode(',', $custFields);
        return $field;
    }
    public function _complex_join()
    {
        $join = sprintf('LEFT JOIN `%1$sproin` ON `%1$spro`.`id` = `%1$sproin`.`jpid` 
            LEFT JOIN `%1$sproout` on `%1$spro`.`id` = `%1$sproout`.`jpid`
            LEFT JOIN `%1$scust` on `%1$spro`.`cid` = `%1$scust`.`id`',C('DB_PREFIX'));
        return $join;
    }

    public function _befor_add()
    {
        $attid = time();
        $this->assign('attid', $attid);

    }

    public function _after_add($id)
    {
      // 更新进货记录
      $data = $this->postData;
      $data['jpid'] = (int)$id;
      $data['jpname'] = $data['name'];
      $data['jpjiage'] = $data['jiage'];
      $data['remark'] = '';
      $proin = A('Proin');
      $proin->autoAdd($data);
    }

    public function _befor_insert($data)
    {
        $code = 'ZY';
        if ($data['type'] == '寄售') {
            $code              = 'JS';
            $data['starttime'] = gettime();
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
        } else {
            $code = 'ZY';
            unset($data['endtime']);
        }
        $model           = D($this->dbname);
        $count           = $model->where('date(addtime) = CURDATE()')->count('id');
        $data['code']    = $code . date("Ymd", time()) . str_pad($count + 1, 3, '0', STR_PAD_LEFT);
        $data['addtime'] = gettime();

        // 更新供应商
        $custData = $this->postData['cust'];
        $custData['juid'] = $data['juid'];
        $custData['juname'] = $data['juname'];
        $cust = A('cust');
        $custid = $cust->autoUpdate($custData);

        $data['cid'] = $custid;
        $data['cname'] = $custData['name'];
        return $data;
    }

    public function _befor_edit()
    {
        $model = D($this->dbname);
        $info  = $model->find(I('get.id'));
        $attid = $info['attid'];
        $this->assign('attid', $attid);
    }

    public function _befor_update($data)
    {
        if ($data['type'] == '寄售') {
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
            $model = D($this->dbname);
            $info = $model->getById($data['id']);
            if(empty($info['starttime'])){
                $data['starttime'] = gettime();
            }
        } else {
            unset($data['endtime']);
            $data['starttime'] = null;
        }
        return $data;
    }

    public function _after_edit($id)
    {
      // $postData = I('post.');
      // $data['jpid'] = $postData['id'];
      // $data['jpname'] = $postData['name'];
      // $data['jpjiage'] = $postData['jiage'];
      // $data['remark'] = '[系统] 更新商品信息';
      // $proin = A('Proin');
      // $proin->autoUpdate($data);
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
        $ids = $this->postData['ids'];
        if(empty($ids)){
            $this->mtReturn("取回商品不能为空！");
        }
        $map['id'] = array('in',implode(',', $ids));
        $where['type'] = array('neq','寄售');
        $where['status'] = array('eq','售出');
        $where['_logic'] = 'or';
        $map['_complex'] = $where;
        $tmpCount = $model->where($map)->count();
        if($tmpCount > 0){
            $this->mtReturn('寄售商品未售出时可取回');
        }
        // $data['id'] = $this->postData['id'];
        // $tmpPro = $model->where(array('id' => $data['id']))->select();
        // if($tmpPro[0]['status'] != '售出'){
        //     $this->mtReturn('售出的商品才能取回');
        // }
        $data['id'] = array('in',implode(',', $ids));
        $data['status'] = '取回';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn($model->getError());
        }
        if(!$model->save($data)){
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname.' 取回成功! proid:'.implode('|', $ids),200);
    }

    // 售出商品可退货
    public function tuihuo()
    {
        $model = D($this->dbname);
        $ids = $this->postData['ids'];
        if(empty($ids)){
            $this->mtReturn("退货商品不能为空！");
        }
        $map['id'] = array('in',implode(',', $ids));
        //$where['type'] = array('neq','寄售');
        // $where['status'] = array('eq','售出');
        // $where['_logic'] = 'or';
        $map['status'] = array('neq','售出');
        $tmpCount = $model->where($map)->count();
        if($tmpCount > 0){
            $this->mtReturn('售出的商品可退货');
        }
        $data['id'] = array('in',implode(',', $ids));
        $data['status'] = '在库';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn($model->getError());
        }
        if(!$model->save($data)){
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname.' 退货成功! proid:'.implode('|', $ids),200);
    }

    // 寄售商品 售出但未打款 可打款
    public function dakuan()
    {
        $model = D($this->dbname);
        $ids = $this->postData['ids'];
        if(empty($ids)){
            $this->mtReturn("退货商品不能为空！");
        }
        $map['id'] = array('in',implode(',', $ids));
        $map['type'] = array('neq','寄售');
        $where['status'] = array('neq','售出');
        $where['paystatus'] = array('neq','未打款');
        $where['_logic'] = 'or';
        $map['_complex'] = $where;
        $tmpCount = $model->where($map)->count();
        if($tmpCount > 0){
            $this->mtReturn('寄售商品售出但未打款商品可打款');
        }
        $data['id'] = array('in',implode(',', $ids));
        $data['paystatus'] = '已打款';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn($model->getError());
        }
        if(!$model->save($data)){
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname.' 打款成功! proid:'.implode('|', $ids),200);
    }

    public function gettypes()
    {
        $model = D($this->dbname);
        $resData = array();        
        $types =  $model->distinct(true)->field('fenlei')->select();
        foreach ($types as  $type) {

            array_push($resData, $type['fenlei']);
        }

        $this->mtReturn('Success',200,$resData);
    }

    public function autoUpdate($data)
    {
        $model = D('pro');
        if (false === $data = $model->create($data,$model::MODEL_UPDATE)) {
            $this->mtReturn($model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn($model->getError());
        }
    }

    public function baojing()
    {
        // 寄售 到期前7天预警   售出2天后还未付款预警
        $model = D($this->dbname);
        $mapJS['type'] = array('eq', '寄售');
        $mapJS['status'] = array('neq','售出');
        $mapJS['_string'] = 'datediff(`endtime`,NOW()) < '.C('PRO_JS_WARN');
        $resData['jsdue'] = $model->where($mapJS)->count();
        
        $mapSC['status'] = array('eq','售出');
        $mapSC['paystatus'] = array('eq','未打款');
        $mapSC['_string'] = 'datediff(`outtime`,NOW()) <= '.C('PRO_SC_WARN');
        $resData['paydue'] = $model->where($mapSC)->count();
        $this->mtReturn("Success",200,$resData);
    }

    // public function bjlists()
    // {
    //     // 寄售 到期前7天预警   售出2天后还未付款预警
    //     $model = D($this->dbname);
    //     $map = array();
    //     if(strtoupper($this->postData['keys']) == 'JS'){
    //         $map['`'.C('DB_PREFIX').'pro`.`code`'] = array('eq', '寄售');
    //         $map['`'.C('DB_PREFIX').'pro`.`status`'] = array('neq','售出');
    //         $map['_string'] = 'datediff(`'.C('DB_PREFIX').'pro`.`endtime`,NOW()) <= '.C('PRO_JS_WARN');
    //     } else {
            
    //     }

    //     //排序字段 默认为主键名
    //     $order = '';
    //     if (!empty($this->postData['order'])) {
    //         $order = $this->postData['order'];
    //     } else {
    //         $order = $model->getPk();
    //     }

    //     //排序方式默认按照倒序排列
    //     //接受 sost参数 0 表示倒序 非0都 表示正序
    //     $sort = $asc ? 'asc' : 'desc';
    //     if (!empty($this->postData['sort'])) {
    //         $sort = $this->postData['sort'];
    //     }

    //     $pageIndex = 1;
    //     if (!empty($this->postData['pageIndex'])) {
    //         $pageIndex = $this->postData['pageIndex'];
    //     }

    //     $join = $this->_complex_join();

    //     //取得满足条件的记录数
    //     $count = $model->join($join)->where($map)->count();
    //     $resData = array();        
    //     $pageSize = C('PERPAGE');
    //     if ($count > 0) {

    //         $field = $this->_complex_field();
    //         $voList = $model->join($join)->where($map)->field($field)->order("`" . $order . "` " . $sort)->limit($pageSize)->page($pageIndex . ',' . $pageSize . '')->select();
    //         $resData['list'] = $voList;
    //     }
    //     $resData['totalCount'] = (int)$count; //数据总数
    //     $resData['pageIndex'] = $pageIndex; //当前的页数，默认为1
    //     $resData['pageSize'] = (int)$pageSize; //每页显示多少条
    //     $this->mtReturn("Success",200,$resData);
    // }

    public function tongji()
    {
        $model = M();
        $dayspan = (int)$this->postData['dayspan'] ? 180 : (int)$this->postData['dayspan'];
        $sql = sprintf("SELECT 
                SUM(CASE WHEN `type` = '寄售' AND `status` = '售出' AND `paystatus` = '未打款' THEN 1 ELSE 0 END) AS JSWeiDaKuan, -- 寄售 已售 未打款 数
                SUM(CASE WHEN `type` = '寄售' AND `status` != '售出' AND  `endtime` < NOW() THEN 1 ELSE 0 END) AS JSChaoQi, -- 寄售到期
                SUM(CASE WHEN `type` = '寄售' AND `status` != '售出' THEN 1 ELSE 0 END) AS JSKuCun, -- 寄售未售出数
                SUM(CASE WHEN `type` = '进货自有' AND `status`  = '售出' AND `paystatus` = '未打款' THEN 1 ELSE 0 END) AS JHWeiDaKuan, -- 自有 已售 未打款 数
                SUM(CASE WHEN `type` = '进货自有' AND `status` != '售出' AND  DATEDIFF(`updatetime`,NOW()) > %s THEN 1 ELSE 0 END) AS JHChaoQi, -- 自有超过180天没有数据更新
                SUM(CASE WHEN `type` = '进货自有' AND `status` != '售出' THEN 1 ELSE 0 END) AS JHKuCun, -- 自有未售出数
                COUNT(`addtime`) AS JinHuoLiang, -- 进货量 包含寄售 自有
                SUM(CASE WHEN ISNULL(`outtime`) then 0 ELSE 1 end) AS XiaoShouLiang -- 销售量
            FROM `v2_pro`", $dayspan);
        if(!empty($this->postData['stime']) && !empty($this->postData['etime'])){
            $sql .= "WHERE `addtime` BETWEEN ".$this->postData['stime']." AND ".$this->postData['etime'];
        }
        $resData = $model->query($sql);
        
        $this->mtReturn('Success',200,$resData[0]);

    }
}
