<?php

/**
 *      入库记录控制器
 *      [X-Mis] (C)2007-2099
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Home\Controller;

use Think\Controller;

class ProinController extends CommonController
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
        $attid = time();
        $this->assign('attid', $attid);

    }

    public function _after_add($id)
    {

    }

    public function _befor_insert($data)
    {
        M("pro")->where('id=' . I("jpid"))->setInc('ruku', I("shuliang"));
        M("pro")->where('id=' . I("jpid"))->setInc('kucun', I("shuliang"));
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
        $list     = $model->where($map)->field('id,jpname,jpjiage,jpdanwei,jpguige,shuliang,title,uname,addtime')->select();
        $headArr  = array('ID', '产品名称', '产品价格', '计量单位', '规格型号', '入库数量', '说明', '操作人', '入库时间');
        $filename = '入库记录';
        $this->xlsout($filename, $headArr, $list);
    }

    public function fenxi()
    {
        $this->display();
    }

    public function autoAdd($data)
    {
    	$model = D('proin');
    	if (false === $data = $model->create($data)) {
            $this->mtReturn(300, '自动同步入库记录失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
        }
        if (!$model->add($data)) {
            $this->mtReturn(300, "自动同步入库记录失败，请手动添加入库记录", $_REQUEST['navTabId'], true);
        }
    }

    // public function autoUpdate($data)
    // {
    // 	$model = D('proin');
    // 	if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
    //         $this->mtReturn(300, '自动更新入库记录失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
    // 	}
    // 	if(!$model->where(array('jpid' => $data['jpid']))->save($data)){
    //         $this->mtReturn(300, "自动更新入库记录失败，请手动修改入库记录" , $_REQUEST['navTabId'], true);
    // 	}
    // }

}
