<?php
/**
 * 系统配置接口API
 *
 *
 * @author zjk
 *
 */

namespace Pc\Controller;

use Common\Controller\ApiController;

class ConfigController extends ApiController
{
	/**
     * 获取数据库中的配置列表
     * @return array 配置数组
     */
    public function lists()
    {
        $map    = array('status' => 1);
        $data   = M('Config')->where($map)->field('type,name,value')->select();
        $this->mtReturn('SUCCESS',200,$data);
    }

    public function listAll()
    {
        $map    = array('status' => 1);
        $data   = M('Config')->where($map)->field('type,name,value')->select();
        $config = array();
        if($data && is_array($data)){
            foreach ($data as $value) {
                $config[$value['name']] = self::parse($value['type'], $value['value']);
            }
        }
        return $config;
    }
     /**
     * 根据配置类型解析配置
     * @param  integer $type  配置类型
     * @param  string  $value 配置值
     */
    private static function parse($type, $value){
        switch ($type) {
            case 3: //解析数组
                $array = preg_split('/[,;\r\n]+/', trim($value, ",;\r\n"));
                if(strpos($value,':')){
                    $value  = array();
                    foreach ($array as $val) {
                        list($k, $v) = explode(':', $val);
                        $value[$k]   = $v;
                    }
                }else{
                    $value =    $array;
                }
                break;
        }
        return $value;
    }
}
