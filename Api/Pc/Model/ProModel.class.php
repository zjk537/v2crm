<?php

/**
 *      产品管理模型
 *      
 *		@author zjk
 */

namespace Pc\Model;
use Think\Model;

class ProModel extends Model{


    protected $_validate = array(
        array('code','','保存失败，请重试！',0,'unique',1),// 产品编号生成重复
        array('endtime',null,'寄售结束时间不能为空！',0,'notequal',1),
        array('endtime','iseltnow','寄售结束时间不能小于当前时间！',0,'function'),
    );
    
		// 自动完成规则
	protected $_auto = array (
	    array('status','在库',1), // 对status字段在新增的时候赋值0
	    array('depid','getdepid',1,'function'),
	    array('depname','getdepname',1,'function'),
	    array('depphone','getdepphone',1,'function'),
		array('uid','getuserid',1,'function'),
        array('uname','gettruename',1,'function'), 		
	    array('addtime','gettime',1,'function'), 
		array('uuid','getuserid',2,'function'),
        array('uuname','gettruename',2,'function'), 		
	    array('updatetime','gettime',2,'function'), 
	);

}