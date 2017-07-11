<?php

/**
 *      产品管理控制器
 *      [X-Mis] (C)2007-2099
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Home\Controller;

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
        // if(!in_array(session('uid'),C('ADMINISTRATOR'))){
        //     $map['id'] = array('EQ', session("uid"));
        // }

        if(IS_POST && isset($_REQUEST['stime']) && $_REQUEST['stime'] != ''&&isset($_REQUEST['etime']) && $_REQUEST['etime'] != ''){
         $map['addtime'] =array(array('egt',I('stime')),array('elt',I('etime'))) ;
        }
    }

    public function _befor_index()
    {

    }

    public function _befor_add()
    {
        // 附件临时id 在保存商品信息之后，更新这个id为商品的id
        $attid = time();
        $this->assign('attid', $attid);

    }

    public function _after_added($id)
    {
      // 新增进货记录
      $data = I('post.');
      $data['jpid'] = (int)$id;
      $data['jpname'] = $data['name'];
      $data['jpjiage'] = $data['jiage'];
      $data['remark'] = '';
      $proin = A('Proin');
      $proin->autoAdd($data);

      //更新附件attid
      $map = array('attid' => $data['attid']);
      $data['attid'] = $id;
      M('files')->where($map)->save($data);
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
        $data['addtime'] = date("Y-m-d H:i:s", time());
        return $data;
    }

    public function _befor_edit()
    {
        $model = D($this->dbname);
        $info  = $model->find(I('get.id'));
        $attid = $info['id'];
        $this->assign('attid', $attid);
    }

    public function _befor_update($data)
    {
        if ($data['type'] == '寄售') {
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
            $model = D($this->dbname);
            $info = $model->getById($data['id']);
            if(empty($info['starttime'])){
                $data['starttime'] = date("Y-m-d H:i:s", time());
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
        $list     = $model->where($map)->field('id,name,fenlei,jiage,sjiage,type,ruku,kucun,chuku,title,uname,addtime,updatetime')->select();
        $headArr  = array('商品编码', '商品名称', '商品分类', '进价', '售价', '计量单位', '入库数量', '库存数量', '出库数量', '型号规格', '添加人', '添加时间', '更新时间');
        $filename = '商品信息';
        $this->xlsout($filename, $headArr, $list);
    }
    
    public function getBack()
    {
        $model = D($this->dbname);
        $id    = I('get.id');
        $data['id'] = $id;
        $data['status'] = '取回';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn(300, '失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
        }
        $model->save($data);
        $this->mtReturn(200, "取回成功" , $_REQUEST['navTabId'], true);
    }

    public function autoUpdate($data)
    {
        $model = D('pro');
        if (false === $data = $model->create($data,$model::MODEL_UPDATE)) {
            $this->mtReturn(300, '自动同步库存记录失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
        }
        if (!$model->save($data)) {
            $this->mtReturn(300, "自动同步库存记录失败", $_REQUEST['navTabId'], true);
        }
    }
}
