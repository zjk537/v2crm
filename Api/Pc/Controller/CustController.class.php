<?php

/**
 *      客户管理控制器
 *
 *        @author zjk
 *
 */

namespace Pc\Controller;

use Think\Controller;

class CustController extends CommonController
{

    public function _initialize()
    {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }

    public function _filter(&$map)
    {
        if (!in_array(session('uid'), C('ADMINISTRATOR'))) {
            // $map[] = array("uid" => array('EQ', session("uid")), "juid" => array('like', '%' . session("uid") . '%'), "_logic" => "or");
            $map[] = array('depid' => getdepid());
        }
        if (IS_POST && isset($_REQUEST['time1']) && $_REQUEST['time1'] != '' && isset($_REQUEST['time2']) && $_REQUEST['time2'] != '') {
            $map['addtime'] = array(array('egt', I('time1')), array('elt', I('time2')));
        }

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
        //$data['addm'] = date("Y-m",time());
        $data['addm'] = '2017-04';
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

    }

    public function _after_edit($id)
    {

    }

    public function _befor_del($id)
    {

    }

    public function autoUpdate($data)
    {
    	$model = D('Cust');
        $tmpCust = $model->where(array('phone' => $data['phone'], 'depid' => getdepid()))->limit(1)->select();
    	// if(empty($data['id']) || $data['id'] == 0){
    	// 	$data['id'] = $tmpCust[0]['id'];
    	// } elseif ( $tmpCust && $tmpCust[0]['id'] != $data['id']) {
     //        $this->mtReturn('手机号码已被占用!');
     //    } 

    	$id = $data['id'] = $tmpCust[0]['id'];
        $isSuccess = true;
        
    	if (false === $data = $model->create($data)) {
            $this->mtReturn($model->getError());
        }
    	if(empty($data['id']) || $data['id'] == 0){
    		$isSuccess = $model->add($data);
    		$id = $model->getLastInsID();
    	} else {
    		$isSuccess = $model->save($data);
    	}
    	
        if (!$isSuccess) {
            $this->mtReturn("自动同步供应商记录失败，请手动添加");
        }
        return $id;
    }

    public function outxls()
    {
        $model = D($this->dbname);
        $map   = $this->_search();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        $list     = $model->where($map)->field('id,name,phone,sex,type,yhname,yhcard,idcard,uname,addtime,updatetime')->select();
        $headArr  = array('ID', '联系人', '手机号码', '性别', '客户来源', '开户行', '银行卡号', '身份证号', '添加人', '添加时间', '更新时间');
        $filename = '客户管理';
        $this->xlsout($filename, $headArr, $list);
    }

    public function fenxi()
    {
        $this->display();
    }

    public function fenlei()
    {
        $this->_fenxi('fenlei', '进展', 4);
    }

    public function type()
    {
        $this->_fenxi('type', '客户来源', 1);
    }

    public function uname()
    {
        $this->_fenxi('uname', '添加人', 2);
    }

    public function jinnian()
    {
        import("Org.Util.Chart");
        $chart = new \Chart;
        for ($i = 1; $i <= 12; $i++) {
            $info = $info . "," . $i;
            if ($i < 10) {
                $co = M($this->dbname)->where(array('addm' => date("Y", time()) . "-0" . $i))->count('id');
            } else {
                $co = M($this->dbname)->where(array('addm' => date("Y", time()) . "-" . $i))->count('id');
            }
            $count = $count . "," . $co;
        }
        $title  = date("Y", time()) . '年客户增长趋势';
        $data   = explode(",", substr($count, 1));
        $size   = 140;
        $width  = 750;
        $height = 300;
        $legend = explode(",", substr($info, 1));
        ob_end_clean();
        $chart->createmonthline($title, $data, $size, $height, $width, $legend);
    }

    public function qunian()
    {
        import("Org.Util.Chart");
        $chart = new \Chart;
        for ($i = 1; $i <= 12; $i++) {
            $info = $info . "," . $i;
            if ($i < 10) {
                $co = M($this->dbname)->where(array('addm' => date("Y", strtotime("-1 year")) . "-0" . $i))->count('id');
            } else {
                $co = M($this->dbname)->where(array('addm' => date("Y", strtotime("-1 year")) . "-" . $i))->count('id');
            }
            $count = $count . "," . $co;
        }
        $title  = date("Y", strtotime("-1 year")) . '年客户增长趋势';
        $data   = explode(",", substr($count, 1));
        $size   = 140;
        $width  = 750;
        $height = 300;
        $legend = explode(",", substr($info, 1));
        ob_end_clean();
        $chart->createmonthline($title, $data, $size, $height, $width, $legend);
    }

    public function daoqi()
    {
        $model = D($this->dbname);
        $map   = $this->_search();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        $map['xcrq'] = array(array('egt', date("Y-m-d", strtotime("-1 week"))), array('elt', date("Y-m-d", strtotime("+1 month"))));
        $list        = $model->where($map)->select();
        $this->assign('list', $list);
        $this->display("index");
    }

    public function recent(){
        $model = D($this->dbname);
        $map = array('uid'=>getuserid());
        $cust = $model->where($map)->order('`updatetime` desc,`addtime` desc')->find();
        $this->mtReturn('成功',200,$cust);
    }
}
