<?php

/**
 * 检查权限
 * @param name string|array  需要验证的规则列表,支持逗号分隔的权限规则或索引数组
 * @param uid  int           认证用户的id
 * @param string mode        执行check的模式
 * @param relation string    如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
 * @return boolean           通过验证返回true;失败返回false
 */
function authcheck($name, $uid, $type = 1, $mode = 'url', $relation = 'or')
{
    if (!in_array($uid, C('ADMINISTRATOR'))) {
        $auth = new \Think\Auth();
        return $auth->check($name, $uid, $type, $mode, $relation) ? true : false;
    } else {
        return true;
    }
}

function getuserid(){
    return S($_SERVER['HTTP_'.C("AUTH_TOKEN")])["uid"];
}


function gettruename(){
    return S($_SERVER['HTTP_'.C('AUTH_TOKEN')])["truename"];
}

function getdepid($depname='')
{
    if(empty($depname)){
        $depname = getdepname();
    }
    $depid = S($_SERVER['HTTP_'.C("AUTH_TOKEN")])["depid"];
    if($depid == ''){
        $dep = M('auth_group')->where(array('name'=>$depname))->limit(1)->select();
        $depid =  $dep[0]['id'];
    }
    return $depid;
}
function getdepname()
{
    return S($_SERVER['HTTP_'.C("AUTH_TOKEN")])["depname"];
}
function gettime(){
    return date('Y-m-d H:i:s',time());
}
// 商品是否售出
function isproout($jpid){
    $model = M('pro');
    $tmpPro = $model->where( array('id' => $jpid ))->select();
    return $tmpPro[0]['status'] !== '售出'; // $tmpPro[0]["status"] == "预定" ||
}
// 寄售商品 结束时间不能小于当前时间
function iseltnow($endtime){
    $end = strtotime($endtime);
    return NOW_TIME <= $end;
}

 /**
 * 图片二进制存入物理地址
 * @param $data base64加密图片流字符串
 * @param $uid  用户ID
 * @param $type 图片类型，默认gif
 * @return 数组，booler 与 返回值
 */
function saveBase64Image($base64)
{
    if(empty($base64)){
        $result = array(
            'code' => 1,
            'msg' => '图片内容不能为空!',
            'filename' => '',
            'filetype' => $type
        );
        return $result;
    }
    //post的数据里面，加号会被替换为空格，需要重新替换回来，如果不是post的数据，则注释掉这一行
    $base64_image = str_replace(' ', '+', $base64);
    if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image, $result)){
        // 图片后缀
        $type = $result[2];
        if(!in_array($type, C('UPLOAD_EXTS'))){
            $result = array(
                'code' => 3,
                'msg' => '不支持的文件类型!',
                'filename' => '',
                'filetype' => ''
            );
            return $result;
        }
        $data = explode(',', $base64_image)[1];
        if(strlen($data) > C('UPLOAD_MAXSIZE')){
            $result = array(
                'code' => 4,
                'msg' => '文件太大!',
                'filename' => '',
                'filetype' => ''
            );
            return $result;
        }

        $name = uniqid().'.'.$type;
        $dir = C('UPLOAD_SAVEPATH').date('Ym').'/';
        $s2i = new \Common\Org\Stream2Image($name,$dir);// 实例化上传类
        $re = $s2i->stream2Image(base64_decode($data));
        if(true === $re){
            @chmod('./'.$dir,0777);
            @chmod('./'.$dir.$name,0777); 
            $result = array(
                'code' => 0,
                'msg' => '',
                'filename' => $dir.$name,
                'filetype' => $type
            );
            return $result;
        }
        $result = array(
            'code' => 5,
            'msg' => $s2i->errInfo,
            'filename' => '',
            'filetype' => ''
        );
        return $result;    
        
    }
    $result = array(
        'code' => 2,
        'msg' => 'base64图片格式有误！',
        'filename' => '',
        'filetype' => ''
    );
    return $result;
}


/**
 * 浮点数舍去指定位数小数点部分。全舍不入
 * @param $n float浮点值
 * @param $len 截取长度字数
 * @return string 截取后的值
 */
// function sub_float($n,$len)
// {
//     stripos($n, '.') && $n= (float)substr($n,0,stripos($n, '.')+$len+1);
//     return $n;
// }

/**
 * 系统缓存缓存管理
 * @param mixed $name 缓存名称
 * @param mixed $value 缓存值
 * @param mixed $options 缓存参数
 * @return mixed
 */
// function cache($name, $value = '', $options = null) {
//     static $cache = '';
//     if (empty($cache)) {
//         $cache = \Think\Cache::getInstance();
//     }
//     // 获取缓存
//     if ('' === $value) {
//         if (false !== strpos($name, '.')) {
//             $vars = explode('.', $name);
//             $data = $cache->get($vars[0]);
//             return is_array($data) ? $data[$vars[1]] : $data;
//         } else {
//             return $cache->get($name);
//         }
//     } elseif (is_null($value)) {//删除缓存
//         return $cache->remove($name);
//     } else {//缓存数据
//         if (is_array($options)) {
//             $expire = isset($options['expire']) ? $options['expire'] : NULL;
//         } else {
//             $expire = is_numeric($options) ? $options : NULL;
//         }
//         return $cache->set($name, $value, $expire);
//     }
// }

/**
 * 生成随机字符串
 * @param int       $length  要生成的随机字符串长度
 * @param string    $type    随机码类型：0，数字+大小写字母；1，数字；2，小写字母；3，大写字母；4，特殊字符；-1，数字+大小写字母+特殊字符
 * @return string
 */
// function randCode($length = 5, $type = 0) {
//     $arr = array(1 => "0123456789", 2 => "abcdefghijklmnopqrstuvwxyz", 3 => "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 4 => "~@#$%^&*(){}[]|");
//     if ($type == 0) {
//         array_pop($arr);
//         $string = implode("", $arr);
//     } elseif ($type == "-1") {
//         $string = implode("", $arr);
//     } else {
//         $string = $arr[$type];
//     }
//     $count = strlen($string) - 1;
//     $code = '';
//     for ($i = 0; $i < $length; $i++) {
//         $code .= $string[mt_rand(0, $count)];
//     }
//     return $code;
// }

/*
 * 产生随机字符
 * $length  int 生成字符传的长度
 * $numeric  int  , = 0 随机数是大小写字符+数字 , = 1 则为纯数字
 */
// function randCodeM($length, $numeric = 0)
// {
//     $seed = base_convert(md5(print_r($_SERVER, 1) . microtime()), 16, $numeric ? 10 : 35);
//     $seed = $numeric ? (str_replace('0', '', $seed) . '012340567890') : ($seed . 'zZ' . strtoupper($seed));
//     $hash = '';
//     $max = strlen($seed) - 1;
//     for ($i = 0; $i < $length; $i++) {
//         $hash .= $seed[mt_rand(0, $max)];
//     }
//     return $hash;
// }

/**
 * 简单对称加密算法之加密
 * @param String $string 需要加密的字串
 * @param String $skey 加密EKY
 * @return String
 */
// function myEncode($string = '')
// {
//     if(empty($string)) return '';
//     $strArr = str_split(base64_encode($string));
//     $strCount = count($strArr);
//     foreach (str_split(C('PASS_KEY')) as $key => $value)
//         $key < $strCount && $strArr[$key] .= $value;
//     return str_replace(array('+','/'), array('-','_'), join('', $strArr));
// }

/**
 * 简单对称加密算法之解密
 * @param String $string 需要解密的字串
 * @param String $skey 解密KEY
 * @return String
 */
// function myDecode($string = '')
// {
//     if(empty($string)) return '';
//     $strArr = str_split(str_replace(array('-','_'),array('+','/'),  $string), 2);
//     $strCount = count($strArr);
//     foreach (str_split(C('PASS_KEY')) as $key => $value)
//         $key <= $strCount && $strArr[$key][1] === $value && $strArr[$key] = $strArr[$key][0];
//     return base64_decode(join('', $strArr));
// }

/**
 * 用户数据 DES加密
 * @param String $str 需要加密的字串
 * @param String $skey 加密EKY
 * @return String
 */
function myDes_encode($str, $key)
{
    $va = \Think\Crypt\Driver\Des::encrypt($str, $key . C('PASS_KEY'));
    $va = base64_encode($va);
    return str_replace(array('+', '/'), array('-', '_'), $va);
}

/**
 * 用户数据 DES解密
 * @param String $str 需要解密的字串
 * @param String $skey 解密KEY
 * @return String
 */
function myDes_decode($str, $key)
{
    $str = str_replace(array('-', '_'), array('+', '/'), $str);
    $str = base64_decode($str);
    $va  = \Think\Crypt\Driver\Des::decrypt($str, $key . C('PASS_KEY'));
    return trim($va);
}
