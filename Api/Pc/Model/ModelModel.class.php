<?php

namespace Home\Model;
use Think\Model;

class ModelModel extends Model{
    protected $_validate = array(
        array('name','','�����Ѿ����ڣ�',0,'unique',1),
    );


  
}