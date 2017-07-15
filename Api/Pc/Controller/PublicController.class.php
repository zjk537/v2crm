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

class PublicController extends ApiController
{

    public function _initialize()
    {
        //模块初始化，重写父类方法，避免该模块进入token验证
    }

    // 登录成功 返回token用于登录认证 uname pwd
    public function login()
    {
        if (!IS_POST) {
            $this->mtReturn('只支持POST请求');
        }
        $json = @file_get_contents("php://input");
        //编码识别转换
        $encode = mb_detect_encoding($json,array('UTF-8','GB2312'));
        if($encode != 'UTF-8'){
            $json = iconv('gb2312', 'utf-8', $json);
        }
        $data = json_decode($json, true);
        if (!$this->existAccount($data['username'])) {
            $this->mtReturn('用户不存在');
        }

        $account = M('user')->getByUsername($data['username']);
        if ($account['password'] != $this->encrypt($data['password'])) {
            $this->mtReturn('密码不正确');
        }

        $strToken = $account['username'] . '|' . $account['id'];
        $token    = myDes_encode($strToken, $account['username']);
        //cache user
        $resData['uid']      = $account['id'];
        $resData['username'] = $account['username'];
        $resData['truename'] = $account['truename'];
        $resData['depid']    = getdepid($account['depname']);
        $resData['depphone'] = getdepphone($account['depname']);
        $resData['depname']  = $account['depname'];
        $resData['posname']  = $account['posname'];
        $resData['token']    = $token;
        S($token, $resData);

        $userData['id']          = $account['uid'];
        $userData['logintime']   = date("Y-m-d H:i:s", time());
        $userData['loginip']     = get_client_ip();
        $userData['logins']      = array('exp', 'logins+1');
        $userData['update_time'] = time();
        M("user")->save($userData);

        $logData['username'] = $account['username'];
        $logData['content']  = '登录成功！';
        $logData['os']       = $_SERVER['HTTP_USER_AGENT'];
        $logData['url']      = '';
        $logData['addtime']  = date("Y-m-d H:i:s", time());
        $logData['ip']       = get_client_ip();
        M("log")->add($logData);

        $this->mtReturn('登录成功', 200, $resData);
    }

    public function existAccount($username)
    {
        if (M('user')->where(array("username" => $username, "status" => 1))->count() > 0) {
            return true;
        }
        return false;
    }

    public function encrypt($data)
    {
        //return md5(C('AUTH_MASK') . md5($data));
        return md5(md5($data));
    }

    
}
