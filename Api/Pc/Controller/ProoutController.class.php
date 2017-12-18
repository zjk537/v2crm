<?php

/**
 *      出库记录控制器
 *      
 *      @author zjk
 *
 */

namespace Pc\Controller;

use Think\Controller;

class ProoutController extends CommonController
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

    }

    public function complex_field()
    {
        $proFields    = $this->fieldMap('pro', M('pro')->getDbFields());
        $proinFields  = $this->fieldMap('proin', M('proin')->getDbFields());
        $prooutFields = $this->fieldMap('proout', M('proout')->getDbFields());
        $custFields   = $this->fieldMap('cust', M('cust')->getDbFields());
        $depFields = array();
        array_push($depFields, '`' . C('DB_PREFIX') . 'auth_group`.`name` as `prodepname`');
        array_push($depFields, '`' . C('DB_PREFIX') . 'auth_group`.`phone` as `prodepphone`');


        $field        = implode(',', $proFields) . ','
        . implode(',', $depFields) . ','
        . implode(',', $proinFields) . ','
        . implode(',', $prooutFields) . ','
        . implode(',', $custFields);
        return $field;
    }
    public function complex_join()
    {
        $join = sprintf('LEFT JOIN `%1$sproin` ON `%1$spro`.`id` = `%1$sproin`.`jpid`
            LEFT JOIN `%1$sauth_group` on `%1$spro`.`depid` = `%1$sauth_group`.`id`
            LEFT JOIN (SELECT a.* FROM `%1$sproout` as a INNER JOIN (SELECT max(`id`) as id FROM `%1$sproout` group by `jpid`) as b on a.id = b.id) as `%1$sproout` on `%1$spro`.`id` = `%1$sproout`.`jpid`
            LEFT JOIN `%1$scust` on `%1$spro`.`cid` = `%1$scust`.`id`', C('DB_PREFIX'));
        return $join;
    }

    public function _befor_index()
    {

    }

    public function _befor_add()
    {
        // $attid=time();
        // $this->assign('attid',$attid);

        // $model = D('pro');
        // $id    = I('get.id');
        // $vo    = $model->getById($id);
        // $this->assign('Rs', $vo);

    }

    public function _after_add($id)
    {
        $postData  = $this->postData;
        $data['id'] = $postData['jpid'];
        $data['sjiage'] = $postData['jpsjiage'];
        $data['yufu'] = $postData['yufu'];
        $data['zhekou'] = $postData['zhekou'];
        //$data['paystatus'] = $postData['paystatus'];
        $data['outtime'] = gettime();
        $data['status'] = $postData['status'];
    	$pro = A('pro');
    	$pro->autoUpdate($data);

        $model = D($this->dbname);
        $map = array();
        $map['`' . C('DB_PREFIX') . 'pro`.`id`'] = array('EQ', $data['id']);
        $join = $this->complex_join();
        $field = $this->complex_field();
        $voList = $model->join($join)->where($map)->field($field)->select();
        return $voList;
    }

    public function _befor_insert($data)
    {
        $model = D('pro');
        $proInfo = $model->getById($data['id']);
        if($proInfo['status'] == '取回'){
            $this->mtReturn("取回商品售出！");
        }
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

    }

    public function _after_edit($id)
    {

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
        $list     = $model->where($map)->field('id,juname,jpname,jpjiage,jpdanwei,jpguige,shuliang,title,jhname,uname,addtime')->select();
        $headArr  = array('ID', '经办人', '产品名称', '产品价格', '计量单位', '规格型号', '出库数量', '说明', '关联合同', '操作人', '入库时间');
        $filename = '出库记录';
        $this->xlsout($filename, $headArr, $list);
    }

    public function fenxi()
    {
        $this->display();
    }

    // 更新商品时自动更新出库信息
    public function autoAdd($data)
    {
        $model = D('proout');

        unset($data['id']);
        if (false === $data = $model->create($data)) {
            $this->mtReturn($model->getError());
        }
        if(!$model->add($data)){
            $this->mtReturn($model->getError());
        }

        // $isSuccess = true;
        // if(empty($data['id']) || $data['id'] == 0){
        //     $isSuccess = $model->add($data);
        // } else {
        //     $isSuccess = $model->save($data);
        // }
        // if (!$isSuccess) {
        //     $this->mtReturn("自动同步出库记录失败");
        // }
    }
}
