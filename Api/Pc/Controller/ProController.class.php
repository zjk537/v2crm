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
        if(IS_POST && $this->postData['stime'] != '' && $this->postData['etime'] != ''){
            $map['`'.C('DB_PREFIX').'pro`.`addtime`'] = array(array('egt',$this->postData['stime']),array('elt',$this->postData['etime'])) ;
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
    
    public function getback()
    {
        $model = D($this->dbname);
        $data['id'] = $this->postData['id'];
        $tmpPro = $model->where(array('id' => $data['id']))->select();
        if($tmpPro[0]['status'] != '售出'){
            $this->mtReturn('售出的商品才能取回');
        }
        $data['status'] = '取回';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn($model->getError());
        }
        if(!$model->save($data)){
            $this->mtReturn($model->getError());
        }
        $this->mtReturn($this->dbname.' 取回成功! proid:'.$data["id"],200);
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
        $mapJS['code'] = array('like', 'JS%');
        $mapJS['status'] = array('neq','售出');
        $mapJS['_string'] = 'datediff(`endtime`,NOW()) < '.C('PRO_JS_WARN');
        $resData['jsdue'] = $model->where($mapJS)->count();
        
        $mapSC['status'] = array('eq','售出');
        $mapSC['paystatus'] = array('eq','未打款');
        $mapSC['_string'] = 'datediff(`outtime`,NOW()) <= '.C('PRO_ZY_WARN');
        $resData['paydue'] = $model->where($mapSC)->count();
        $this->mtReturn("Success",200,$resData);
    }

    public function bjlists()
    {
        // 寄售 到期前7天预警   售出2天后还未付款预警
        $model = D($this->dbname);
        $map = array();
        if(strtoupper($this->postData['keys']) == 'JS'){
            $map['code'] = array('like', 'JS%');
            $map['status'] = array('neq','售出');
            $map['_string'] = 'datediff(`endtime`,NOW()) <= '.C('PRO_JS_WARN');
        } else {
            $map['status'] = array('eq','售出');
            $map['paystatus'] = array('eq','未打款');
            $map['_string'] = 'datediff(`outtime`,NOW()) <= '.C('PRO_ZY_WARN');
        }

        //排序字段 默认为主键名
        $order = '';
        if (!empty($this->postData['order'])) {
            $order = $this->postData['order'];
        } else {
            $order = $model->getPk();
        }

        //排序方式默认按照倒序排列
        //接受 sost参数 0 表示倒序 非0都 表示正序
        $sort = $asc ? 'asc' : 'desc';
        if (!empty($this->postData['sort'])) {
            $sort = $this->postData['sort'];
        }

        $pageIndex = 1;
        if (!empty($this->postData['pageIndex'])) {
            $pageIndex = $this->postData['pageIndex'];
        }


        $resData['jscount'] = $model->where($mapJS)->count();

        $mapSC['status'] = array('eq','售出');
        $mapSC['paystatus'] = array('eq','未打款');
        $mapSC['_string'] = 'datediff(`outtime`,NOW()) <= '.C('PRO_ZY_WARN');
        $resData['zycount'] = $model->where($mapSC)->count();
        $this->mtReturn("Success",200,$resData);
    }
}
