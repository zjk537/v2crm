<?php

/**
 *      客户管理模型
 *      
 *		@author zjk
 */

namespace Pc\Model;
use Think\Model;

class CustModel extends Model{

	// 验证因子定义格式
    // array(field,rule,message,condition,type,when,params)
    // condition:0 表单存在字段则验证 1必须验证 2表单值不为空则验证
    protected $_validate = array(
        array('name','','联系人不能为空！',1,'notequal',1),
        array('phone','','手机号不能为空！',1,'notequal',1),
    );
    
		// 自动完成规则
	protected $_auto = array (
	    array('status',1,1), // 对status字段在新增的时候赋值0
		array('uid','getuserid',1,'function'),
	    array('depid','getdepid',1,'function'),
        array('uname','gettruename',1,'function'), 		
	    array('addtime','gettime',1,'function'), 
		array('uuid','getuserid',2,'function'),
        array('uuname','gettruename',2,'function'), 		
	    array('updatetime','gettime',2,'function'), 
	);

}