<?php
/**
 * 公共接口API
 * 
 * 
 * @author zjk
 *
 */

namespace PC\Controller;
use Common\Controller\ApiController;

class PublicController extends ApiController{
    
    public function _initialize(){
        //模块初始化，重写父类方法，避免该模块进入token验证
    }

    // 登录成功 返回token用于登录认证 uname pwd
    public function login()
    {
        $data = I('post.');
        if (!$this->existAccount($data['uname'])) {
			$this->mtReturn('用户不存在');
        }

        $account = M('user')->getByUsername($data['uname']);
        if ($account['password'] != $this->encrypt($data['pwd'])) {
			$this->mtReturn('密码不正确');
        }

		//cache user
        $resData['uid'] = $account['id';
		$resData['username'] = $account['username'];
		$resData['truename'] = $account['truename'];
		$resData['depname'] = $account['depname'];
		$resData['posname'] = $account['posname'];
		$resData['loginip'] = get_client_ip();
		$resData['logintime'] = date("Y-m-d H:i:s",time());
		$resData['logins'] = $account['logins'];
		
        $strToken = $resData['username'].'|'.$resData['id'];
        $token = myDes_encode($strToken,$resData['username']);
        S($token,$resData);

        $userData['id'] = $account['uid'];
        $userData['logintime'] = date("Y-m-d H:i:s",time());
        $userData['loginip'] = get_client_ip();
		$userData['logins'] = array('exp','logins+1');
		$userData['update_time'] = time();
        M("user")->save($userData);
        
        $logData['username'] = $account['username'];
        $logData['content'] = '登录成功！';
		$logData['os'] = $_SERVER['HTTP_USER_AGENT'];
        $logData['url'] = U();
        $logData['addtime'] = date("Y-m-d H:i:s",time());
        $logData['ip'] = get_client_ip();
        M("log")->add($logData);

        $this->mtReturn('登录成功',200,$resData);
    }

    public function existAccount($username) {
        if (M('user')->where(array("username"=>$username,"status"=>1))->count() > 0) {
            return true;
        }
        return false;
    }


}