<?php
namespace Pc\Controller;

use Common\Controller\ApiController;

class CommonController extends ApiController
{
    protected $postData;
    public function _initialize()
    {
        parent::_initialize();
        $this->_name = CONTROLLER_NAME;

        $json = @file_get_contents("php://input");;
        $this->postData = json_decode($json,true);
        $config = S('DB_CONFIG_DATA');
        if (!$config) {
            $config = A('Config')->listAll();
            S('DB_CONFIG_DATA', $config);
        }
        C($config);
        // $name = MODULE_NAME . '/' . CONTROLLER_NAME . '/' . ACTION_NAME;
        // if (!authcheck($name, $this->curUser['uid'])) {
        //     $this->mtReturn($this->curUser['username'] . '很抱歉,此项操作您没有权限！');
        // }
    }

    /**
     * 列表页面
     */
    protected function _list($model, $map, $asc = false)
    {
        //echo json_encode($this->postData);exit;
        // $json = @file_get_contents("php://input");;
        // $postData = json_decode($json,true);
        //排序字段 默认为主键名
        if (isset($postData['order'])) {
            $order = $postData['order'];
        }
        if ($order == '') {
            $order = $model->getPk();

        }

        //排序方式默认按照倒序排列
        //接受 sost参数 0 表示倒序 非0都 表示正序
        if (isset($postData['sort'])) {
            $sort = $postData['sort'];
        }
        if ($sort == '') {
            $sort = $asc ? 'asc' : 'desc';

        }

        if (isset($postData['pageIndex'])) {
            $pageIndex = $postData['pageIndex'];
        }
        if ($pageIndex == '') {
            $pageIndex = 1;

        }

        //取得满足条件的记录数
        $count = $model->where($map)->count();
        $resData = array();        
        if ($count > 0) {

            $pageSize = C('PERPAGE');
            $voList = $model->where($map)->order("`" . $order . "` " . $sort)->limit($pageSize)->page($pageIndex . ',' . $pageSize . '')->select();

            //列表排序显示
            $sortImg = $sort; //排序图标
            //$sortAlt = $sort == 'desc' ? '升序排列' : '倒序排列'; //排序提示
            $sort    = $sort == 'desc' ? 1 : 0; //排序方式

            if (method_exists($this, '_after_list')) {
                $this->_after_list($voList);
            }
            $resData['list'] = $voList;

        }
        $resData['totalCount'] = (int)$count; //数据总数
        $resData['pageIndex'] = $pageIndex; //当前的页数，默认为1
        $resData['pageSize'] = (int)$pageSize; //每页显示多少条

        return $resData;
    }

    public function lists()
    {
        $model = D($this->dbname);
        $map   = $this->_search();
        $resData = array();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        if (!empty($model)) {
            $resData = $this->_list($model, $map);
        }
        // if (method_exists($this, '_before_response')) {
        //     $this->_before_response();
        // }
        $this->mtReturn('数据查询成功，pageIndex:'.$resData['pageIndex'],200,$resData);
    }

    protected function _search($dbname = '')
    {
        $dbname = $dbname ? $dbname : $this->dbname;
        $model  = D($dbname);
        $map    = array();
        foreach ($model->getDbFields() as $key => $val) {
            if (isset($_REQUEST['keys']) && $_REQUEST['keys'] != '') {
                if (in_array($val, C('SEARCHKEY'))) {
                    $map[$val] = array('like', '%' . trim($_REQUEST['keys']) . '%');
                } else {
                    //$map [$val] = $_REQUEST['keys'];
                }

            }
        }
        $map['_logic'] = 'or';
        if ((IS_POST) && isset($_REQUEST['keys']) && $_REQUEST['keys'] != '') {
            $where['_complex'] = $map;
            return $where;
        } else {
            return $map;
        }
    }

    public function add()
    {
        $model = D($this->dbname);
        $data  = $this->postData;
        if (false === $data = $model->create($data)) {
            $this->mtReturn('失败，请检查值是否已经存在');
        }
        if (method_exists($this, '_befor_insert')) {
            $data = $this->_befor_insert($data);
        }
        if ($model->add($data)) {
            if (method_exists($this, '_after_add')) {
                $id = $model->getLastInsID();
                $this->_after_add($id);
            }
            //$id = $model->getLastInsID();
            $this->mtReturn( $this->dbname." 新增成功", 200);
        }
        
    }

    public function edit()
    {
        $model = D($this->dbname);
        // if (IS_POST) {
            $data = $this->postData;
            $id = $data['id'];
            if (false === $data = $model->create($data)) {
                $this->mtReturn('失败，请检查值是否已经存在');
            }
            if (method_exists($this, '_befor_update')) {
                $data = $this->_befor_update($data);
            }
            if ($model->save($data)) {
                if (method_exists($this, '_after_edit')) {
                    $this->_after_edit($id);
                }
            }
            $this->mtReturn($this->dbname." 编辑成功".$id,200);
        // }
        // if (method_exists($this, '_befor_edit')) {
        //     $this->_befor_edit();
        // }
        // $id = $_REQUEST[$model->getPk()];
        // $vo = $model->getById($id);
        // $this->assign('id', $id);
        // $this->assign('Rs', $vo);
        // $this->display();
    }

    public function detail()
    {
        $model = D($this->dbname);
        $id    = $this->postData['id'];
        $vo    = $model->getById($id);
        $this->mtReturn('Success',200,$vo);
    }

    public function del()
    {
        $model = D($this->dbname);
        $id    = I('get.id');
        if ($id) {
            $data       = $model->find($id);
            $data['id'] = $id;
            if ($data['status'] == 1) {
                $data['status'] = 0;
                $msg            = '锁定';
                if (method_exists($this, '_befor_del')) {
                    $this->_befor_del($id);
                }
            } else {
                $data['status'] = 1;
                $msg            = '启用';
            }
            $model->save($data);
            $this->mtReturn(200, $msg . $id, $_REQUEST['navTabId'], false);
        } else {
            $info = $model->where('status=0')->select();
            foreach ($info as $key => $v) {
                $attid       = $v['attid'];
                $ad['attid'] = 0;
                M('files')->where(array("attid" => $attid))->save($ad);
            }
            $info = M('files')->where('attid=0 and  uid=' . session('uid'))->select();
            foreach ($info as $key => $v) {
                $filepath = $v['folder'] . $v['filename'];
                unlink($filepath);
            }
            M('files')->where('attid=0 and  uid=' . session('uid'))->delete();
            if (!in_array(session('uid'), C('ADMINISTRATOR'))) {
                $Rs = $model->where('status=0 and uid=' . session("uid"))->delete();
            } else {
                $Rs = $model->where('status=0')->delete();
            }
            $this->mtReturn(200, '清理' . $Rs . '条无用的记录', $_REQUEST['navTabId'], false);
        }
    }

    public function _fenxi($fd, $ft, $type)
    {
        import("Org.Util.Chart");
        $chart    = new \Chart;
        $model    = D($this->dbname);
        $this->fd = $fd;
        $map      = $this->_search();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        $list = $model->where($map)->distinct($this->fd)->field($this->fd)->select();
        echo $model->getlastsql();
        foreach ($list as $key => $vo) {
            $info  = $info . "," . $vo[$this->fd];
            $co    = $model->where(array($this->fd => $vo[$this->fd]))->where($map)->count('id');
            $count = $count . "," . $co;
        }
        $title  = $ft;
        $data   = explode(",", substr($count, 1));
        $size   = 140;
        $width  = 750;
        $height = 300;
        $legend = explode(",", substr($info, 1));
        ob_end_clean();
        if ($type == 1) {
            $chart->create3dpie($title, $data, $size, $height, $width, $legend);
        }
        if ($type == 2) {
            $chart->createcolumnar($title, $data, $size, $height, $width, $legend);
        }
        if ($type == 3) {
            $chart->createmonthline($title, $data, $size, $height, $width, $legend);
        }
        if ($type == 4) {
            $chart->createring($title, $data, $size, $height, $width, $legend);
        }
        if ($type == 5) {
            $chart->createhorizoncolumnar($title, $subtitle, $data, $size, $height, $width, $legend);
        }

    }

    public function xlsout($filename = '数据表', $headArr, $list)
    {

        //导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        import("Org.Util.PHPExcel");
        import("Org.Util.PHPExcel.Writer.Excel5");
        import("Org.Util.PHPExcel.IOFactory.php");
        $this->getExcel($filename, $headArr, $list);
    }
    public function xlsin()
    {

        //导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        import("Org.Util.PHPExcel");
        //要导入的xls文件，位于根目录下的Public文件夹
        $filename = "./Public/1.xls";
        //创建PHPExcel对象，注意，不能少了\
        $PHPExcel = new \PHPExcel();
        //如果excel文件后缀名为.xls，导入这个类
        import("Org.Util.PHPExcel.Reader.Excel5");
        //如果excel文件后缀名为.xlsx，导入这下类
        //import("Org.Util.PHPExcel.Reader.Excel2007");
        //$PHPReader=new \PHPExcel_Reader_Excel2007();

        $PHPReader = new \PHPExcel_Reader_Excel5();
        //载入文件
        $PHPExcel = $PHPReader->load($filename);
        //获取表中的第一个工作表，如果要获取第二个，把0改为1，依次类推
        $currentSheet = $PHPExcel->getSheet(0);
        //获取总列数
        $allColumn = $currentSheet->getHighestColumn();
        //获取总行数
        $allRow = $currentSheet->getHighestRow();
        //循环获取表中的数据，$currentRow表示当前行，从哪行开始读取数据，索引值从0开始
        for ($currentRow = 1; $currentRow <= $allRow; $currentRow++) {
            //从哪列开始，A表示第一列
            for ($currentColumn = 'A'; $currentColumn <= $allColumn; $currentColumn++) {
                //数据坐标
                $address = $currentColumn . $currentRow;
                //读取到的数据，保存到数组$arr中
                $arr[$currentRow][$currentColumn] = $currentSheet->getCell($address)->getValue();
            }

        }

    }
    public function getExcel($fileName, $headArr, $data)
    {
        //对数据进行检验
        if (empty($data) || !is_array($data)) {
            die("data must be a array");
        }
        //检查文件名
        if (empty($fileName)) {
            exit;
        }

        $date = date("Y_m_d", time());
        $fileName .= "_{$date}.xls";

        //创建PHPExcel对象，注意，不能少了\
        $objPHPExcel = new \PHPExcel();
        $objProps    = $objPHPExcel->getProperties();

        //设置表头
        $key = ord("A");
        foreach ($headArr as $v) {
            $colum = chr($key);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue($colum . '1', $v);
            $key += 1;
        }

        $column      = 2;
        $objActSheet = $objPHPExcel->getActiveSheet();

        //设置为文本格式
        foreach ($data as $key => $rows) {
            //行写入
            $span = ord("A");
            foreach ($rows as $keyName => $value) {
                // 列写入
                $j = chr($span);

                $objActSheet->setCellValueExplicit($j . $column, $value);
                $span++;
            }
            $column++;
        }

        $fileName = iconv("utf-8", "gb2312", $fileName);
        //重命名表
        // $objPHPExcel->getActiveSheet()->setTitle('test');
        //设置活动单指数到第一个表,所以Excel打开这是第一个表
        $objPHPExcel->setActiveSheetIndex(0);
        ob_end_clean(); //清除缓冲区,避免乱码
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=\"$fileName\"");
        header('Cache-Control: max-age=0');

        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output'); //文件通过浏览器下载
        exit;
    }

}
