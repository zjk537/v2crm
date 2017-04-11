<?php

/**
 *      工作汇报控制器
 *      [X-Mis] (C)2007-2099  
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Home\Controller;
use Think\Controller;

class ReportController extends CommonController{

   public function _initialize() {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }
	
   function _filter(&$map) {
		if(!in_array(session('uid'),C('ADMINISTRATOR'))){
		$map['juid'] = array('like','%'.session("uid").'%');
       }

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
	 $data['uid']=session("uid");
	 $data['uname']=session("truename");
	 $data['addtime']=date("Y-m-d H:i:s",time());
	 return $data;
  }
  
  public function _befor_edit(){
     $model = D($this->dbname);
	 $info = $model->find(I('get.id'));
	 $attid=$info['attid'];
	 $this->assign('attid',$attid);
  }
   
  public function _befor_update($data){
	 $data['uuid']=session("uid");
	 $data['uuname']=session("truename");
	 $data['updatetime']=date("Y-m-d H:i:s",time());
	 $data['beizhu']=I("beizhu1")."\r\n".session("truename").":".I('beizhu').date("Y-m-d H:i:s",time());
	 unset($data['beizhu1']);
	 return $data;
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
		$list = $model->where($map)->field('id,uname,type,title,addtime,uuname,updatetime')->select();
	    $headArr=array('ID','汇报人','汇报类型','标题','汇报时间','更新人','更新时间');
	    $filename='工作汇报';
		$this->xlsout($filename,$headArr,$list);
	}

}