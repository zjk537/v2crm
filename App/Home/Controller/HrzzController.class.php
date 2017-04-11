<?php

/**
 *      证照管理控制器
 *      [X-Mis] (C)2007-2099  
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Home\Controller;
use Think\Controller;

class HrzzController extends CommonController{

   public function _initialize() {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }
	
   function _filter(&$map) {
		//$map['id'] = array('EQ', I('id'));

	}
	
   public function _befor_index(){ 
   
   }
  
  
  public function _befor_add(){
	  $attid=time();
	  $this->assign('attid',$attid);
    
  }
	
   public function _after_add($data){
    
   }

  public function _befor_insert($data){
	 //$data['addtime']=date("Y-m-d H:i:s",time());
	// return $data;
  }
  
  public function _befor_edit(){
     $model = D($this->dbname);
	 $info = $model->find(I('get.id'));
	 $attid=$info['attid'];
	 $this->assign('attid',$attid);
  }
   
  public function _befor_update($data){

  }
  
    public function _after_edit($data){
     
   }

   public function _befor_del($id){
	  
   }

   public function outxls() {
		$model = D($this->dbname);
		$map = $this->_search();
		if (method_exists($this, '_filter')) {
			$this->_filter($map);
		}
		$list = $model->where($map)->field('id,juname,title,bianhao,type,sxrq,jsrq,addtime,updatetime')->select();
	    $headArr=array('ID','员工姓名','证照名称','证照编号','证照类型','生效日期','结束日期','添加时间','更新时间');
	    $filename='证照管理';
		$this->xlsout($filename,$headArr,$list);
	}

}