<?php
/**
 * Api公共类
 * Interface引用api模式，没有display等view的渲染和页面模版输出
 */
namespace Common\Controller;
use Think\Controller;

class ApiController extends Controller
{
    protected $curUser = null;
    //protected $userStuID = null;
    //protected $userTeaID = null;

    public function _initialize()
    {
        if(!IS_POST){
            $this->mtReturn('只支持POST请求');
        }

        $token = $_SERVER['HTTP_'.C('AUTH_TOKEN')];
        $this->curUser = S($token);
        if(!$this->curUser){
            $this->mtReturn('请先登录',201);
        }
    }

    /**
     * 公共错误返回
     * @param $msg 需要打印的错误信息
     * @param $code 默认打印300信息
     */
    public function mtReturn($msg='',$code=300,$data=''){
        // $udata['id']          = $this->curUser['uid'];
        // $udata['update_time'] = time();
        // $Rs                   = M("user")->save($udata);
        // $dat['username']      = $this->curUser['username'];
        // $dat['content']       = $info;
        // $dat['os']            = $_SERVER['HTTP_USER_AGENT'];
        // $dat['url']           = MODULE_NAME . '/' . CONTROLLER_NAME . '/' . ACTION_NAME;;
        // $dat['addtime']       = date("Y-m-d H:i:s", time());
        // $dat['ip']            = get_client_ip();
        // M("log")->add($dat);

        $result = array(
            'code' => $code,
            'msg' => $msg,
            'data' => $data
        );
        $this->ajaxReturn($result);exit;
    }

    /*
     *检查用户账号
     *@return 混合模型
     * */
    public function checkUserAccount($user,$t=0){
        $this->mtReturn('test');
// //        if(!preg_match("/1[3578]{1}\d{9}$/",$user)){
// //            $this->myApiPrint('手机号码格式不对');
// //        }
//         $where['stu_user'] = $user;
//         $owner = M('student');
//         $resn = $owner->where($where)->find();
//         if($t==1&&!$resn){
//             $this->myApiPrint('非法请求，账号不存在');
//         }
//         return $resn;
    }

    /**
     * 图片二进制存入物理地址
     * @param $data base64加密图片流字符串
     * @param $uid  用户ID
     * @param $type 图片类型，默认gif
     * @return 数组，booler 与 返回值
     */
    public function myStream2Img($data,$uid,$type='.gif',$name=''){
        $name = (empty($name))?time().$type:$name.$type;
        $dir = '/Public/Upload/'.$uid.'/';
        $s2i = new \Common\Org\Stream2Image($name,$dir);// 实例化上传类
        $re = $s2i->stream2Image(base64_decode($data));
        //@file_put_contents('a1_dir.log',$dir.$name.PHP_EOL,FILE_APPEND);
        if(true === $re){@chmod('./'.$dir,0777);@chmod('./'.$dir.$name,0777); return $dir.$name;}
        else {
            $result = array(
                'code' => 300,
                'msg' => $s2i->print_errInfo,
                'result' => ''
            );
            $this->ajaxReturn($result);exit;
        }
    }

    

    /*
     * 生成定长22位的订单码
     * */
    public function MyOrderNo22(){
        $code  =date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $code .= randCodeM(22-strlen($code),1);
        return $code;
    }

    /*
     * 检查请求有效性与参数
     * @return 混合模型
     * */
    public function checkRequestTime($time){
        if(($time) > 0){
            //300秒/5分钟的有效请求
            $v =time()-$time;
            if($v<300 && $v>0) return true;
            else return false;
        }else return false;
    }

    /*
     * 检查数组是否为空
     * */
    public function arrIsEmpty($arr)
    {
        foreach($arr as $v)
        {
            if(empty($v)) return true;
        }
    }

    //安全性接口，验签操作
    public function mySign($para_temp){

        //除去待签名参数数组中的空值和签名参数
        $para_filter = $this->myParaFilter($para_temp);

        //对待签名参数数组排序
        $para_sort = $this->myArgSort($para_filter);

        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        $prestr = $this->myParaLinkstring($para_sort);
        return $prestr;
    }

    //安全性接口，验签操作
    public function myParaFilter($para) {
        $para_filter = array();
        while (list ($key, $val) = each ($para)) {
            if($key === "sign" || $key === "sign_pass" || $val === "")continue;
            else	$para_filter[$key] = $para[$key];
        }
        return $para_filter;
    }

    /**
     * 把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param $para 需要拼接的数组
     * return 拼接完成以后的字符串
     */
    function myParaLinkstring($para) {
        $arg  = "";
        while (list ($key, $val) = each ($para)) {
            $arg.=$key."=".$val."&";
        }
        //去掉最后一个&字符
        $arg = substr($arg,0,count($arg)-2);

        //如果存在转义字符，那么去掉转义
        if(get_magic_quotes_gpc()){$arg = stripslashes($arg);}

        return $arg;
    }

    /**
     * 对数组排序
     * @param $para 排序前的数组
     * return 排序后的数组
     */
    function myArgSort($para) {
        ksort($para);
        reset($para);
        return $para;
    }
}