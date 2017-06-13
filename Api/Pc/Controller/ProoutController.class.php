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
        $data['paystatus'] = $postData['paystatus'];
        $data['outtime'] = gettime();
        $data['status'] = '售出';
    	$pro = A('pro');
    	$pro->autoUpdate($data);
    }

    public function _befor_insert($data)
    {
        
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
