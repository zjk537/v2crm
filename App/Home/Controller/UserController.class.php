<?php
namespace Home\Controller;

use Think\Controller;

class UserController extends CommonController
{

    public function _initialize()
    {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }

    public function _befor_add()
    {
        $list = orgcateTree($pid = 0, $level = 0, $type = 0);
        $this->assign('list', $list);
    }

    public function _befor_insert($data)
    {
        $password         = md5(md5(I('pwd')));
        $data['password'] = $password;
        unset($data['pwd']);
        return $data;
    }

    public function _befor_edit()
    {
        $list = orgcateTree($pid = 0, $level = 0, $type = 0);
        $this->assign('list', $list);
    }

    public function _befor_update($data)
    {
        if (strlen(I('pwd')) !== 32) {
            $password         = md5(md5(I('pwd')));
            $data['password'] = $password;
        }
        unset($data['pwd']);
        // 更新用户权限
        $gcId = M('auth_group')->where(array("name" => $data['posname']))->getField('id');
        M('auth_group_access')->where('uid=' . $data['id'] . '')->setField('group_id', $gcId);
        return $data;
    }

    public function editrule()
    {
        $uid = I('get.id');
        //if ($uid<>session('uid')){
        
        $model = M('auth_group_access');
        $count = $model->where(array('uid'=>$uid))->count();
        if($count > 0){
            $model->where(array('uid'=>$uid))->delete();
        } else {
            $depname = urldecode(I('get.depname'));
            $posname = urldecode(I('get.posname'));
            $gcdata['uid']      = $uid;
            $gcdata['group_id']=M('auth_group')->where(array("name"=>$depname))->getField('id');
            $model->data($gcdata)->add();
            
            $gcdata['group_id']=M('auth_group')->where(array("name"=>$posname))->getField('id');
            $model->data($gcdata)->add();
        }
        $this->mtReturn(200, "设置成功" . $id, $_REQUEST['navTabId'], false);
        //}
    }

    public function _befor_del($id)
    {
        $uid = $id;
        M('auth_group_access')->where('uid=' . $uid . '')->delete();
    }

}
