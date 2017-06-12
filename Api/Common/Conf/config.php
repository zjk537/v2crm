<?php
return array(

    //数据库设置
    'DB_TYPE'               =>  'mysqli',     // 数据库类型
    'DB_HOST'               =>  'localhost', // 服务器地址
    'DB_NAME'               =>  'v2crm',          // 数据库名
    'DB_USER'               =>  'root',      // 用户名
    'DB_PWD'                =>  '1qaz@WSX',          // 密码
    'DB_PORT'               =>  '3306',        // 端口
    'DB_PREFIX'             =>  'v2_',    // 数据库表前缀
    'DB_FIELDTYPE_CHECK'    =>  false,       // 是否进行字段类型检查
    'DB_FIELDS_CACHE'       =>  true,        // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',      // 数据库编码默认采用utf8

    //超级管理员id,拥有全部权限,只要用户uid在这个角色组里的,就跳出认证.可以设置多个值,如array('1','2','3')
    'ADMINISTRATOR'=>array('1'),
    /* SESSION设置 */
    'SESSION_AUTO_START' => false, // 是否自动开启Session
    'SESSION_OPTIONS'    => array(), // session 配置数组 支持type name id path expire domain 等参数
    'SESSION_TYPE'       => '', // session hander类型 默认无需设置 除非扩展了session hander驱动
    'SESSION_PREFIX'     => 'v2', // session 前缀

    'DEFAULT_MODULE'     => 'Pc', // 默认模块
    'DEFAULT_CONTROLLER' =>  'Index', // 默认控制器名称
    'DEFAULT_ACTION'      =>  'index', // 默认操作名称

    /*URL_MODEL*/
    'URL_MODEL'          => 2,
    'URL_HTML_SUFFIX'   => '',
    'URL_PATHINFO_DEPR' => '/',
    'URL_ROUTER_ON'      => true,

    //上传设置
    'UPLOAD_MAXSIZE'=>31457280,
    'UPLOAD_EXTS'=>array('jpg','gif','png','jpeg'),// 设置附件上传类型 
    'UPLOAD_SAVEPATH'=>'./Uploads/',

    /*加密方式*/
    'DATA_CRYPT_TYPE'  => 'DES',

    /*接口域名*/
    'API_SITE_PREFIX'  => 'http://192.168.54.88/DSY',

    /*默认头像文件路径*/
    'HAND_IMG_PATH'   =>  '/Public/pic_hand_img.png',

    /*加密KEY*/
    'PASS_KEY'    => 'ZJKDRAVOGUE2',
    'AUTH_TOKEN'  => 'V2AUTHTOKEN',

    /*支付方式*/
    'PAY_STATUS'   => array(
        'CYH_WAIT_PAY'  => 'CYH_WAIT_PAY', //等待支付
        'CYH_PAY_W_UP'  => 'CYH_PAY_W_UP', //APP端回调支付成功，等待支付宝回调响应
        'CYH_PAY_OK'    => 'CYH_PAY_OK', //支付完成
    ),
    'PAY_TYPE'   => array(
        'ALIPAY' => '支付宝',
        'SELF'    => '余额支付',
        'WEIXIN'  => '微信支付',
    ),
);