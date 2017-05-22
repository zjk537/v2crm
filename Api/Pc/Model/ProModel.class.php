<?php

/**
 *      产品管理模型
 *      [X-Mis] (C)2007-2099  
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Pc\Model;
use Think\Model;

class ProModel extends Model{


    protected $_validate = array(
        array('code','','保存失败，请重试！',0,'unique',1),// 产品编号生成重复
    );
    
		// 自动完成规则
	protected $_auto = array (
	    array('status','在库',1), // 对status字段在新增的时候赋值0
		array('uid','getuserid',1,'function'),
        array('uname','gettruename',1,'function'), 		
	    array('addtime','gettime',1,'function'), 
		array('uuid','getuserid',2,'function'),
        array('uuname','gettruename',2,'function'), 		
	    array('updatetime','gettime',2,'function'), 
	);

}