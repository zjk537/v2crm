<?php

namespace Home\Model;
use Think\Model;

class UserModel extends Model{
    protected $_validate = array(

        array('username','','登陆账号已经存在！',0,'unique',1),
    );


  
}