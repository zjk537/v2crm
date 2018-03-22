<?php

/**
 *      出库记录模型
 *
 *      @author zjk
 */

namespace Pc\Model;
use Think\Model;

class ProoutModel extends Model{


    protected $_validate = array(
        array('jpid','isproout','商品已售出，不能重复售出！',1,'function'),
    );
    
		// 自动完成规则
	protected $_auto = array (
	    // array('status',1,1), // 对status字段在新增的时候赋值0
		array('uid','getuserid',1,'function'),
		array('depid','getdepid',1,'function'),
        array('uname','gettruename',1,'function'), 		
	    array('addtime','gettime',1,'function'), 
		array('uuid','getuserid',2,'function'),
        array('uuname','gettruename',2,'function'), 		
	    array('updatetime','gettime',2,'function'), 
	);

}