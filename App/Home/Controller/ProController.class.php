<?php

/**
 *      产品管理控制器
 *      [X-Mis] (C)2007-2099
 *      This is NOT a freeware, use is subject to license terms
 *      http://www.xinyou88.com
 *      tel:400-000-9981
 *      qq:16129825
 */

namespace Home\Controller;

use Think\Controller;
use Think\Log;

class ProController extends CommonController
{

    public function _initialize()
    {
        parent::_initialize();
        $this->dbname = CONTROLLER_NAME;
    }

    public function _filter(&$map)
    {
        if(!in_array(session('uid'),C('ADMINISTRATOR'))){
            $map['depid'] = array('EQ', getdepid());
        }

        if(IS_POST && isset($_REQUEST['stime']) && $_REQUEST['stime'] != ''&&isset($_REQUEST['etime']) && $_REQUEST['etime'] != ''){
         $map['addtime'] =array(array('egt',I('stime')),array('elt',I('etime'))) ;
        }
    }

    public function _befor_index()
    {
        
    }

    public function _befor_add()
    {
        // 附件临时id 在保存商品信息之后，更新这个id为商品的id
        $attid = time();
        $this->assign('attid', $attid);

    }

    public function _after_added($id)
    {
      // 新增进货记录
      $data = I('post.');
      $data['jpid'] = (int)$id;
      $data['jpname'] = $data['name'];
      $data['jpjiage'] = $data['jiage'];
      $data['remark'] = '';
      $proin = A('Proin');
      $proin->autoAdd($data);

      // 新增时 附件id 是时间戳，保存成功后更新附件attid为商品id
      $map = array('attid' => $data['attid']);
      $fileData['attid'] = $id;
      M('files')->where($map)->save($fileData);
    }

    public function _befor_insert($data)
    {
        $code = 'ZY';
        if ($data['type'] == '寄售') {
            $code              = 'JS';
            $data['starttime'] = gettime();
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
        } else {
            $code = 'ZY';
            unset($data['endtime']);
        }
        $model           = D($this->dbname);
        $count           = $model->where('date(addtime) = CURDATE() AND depid='.getdepid())->count('id');
        $data['code']    = $code . date("Ymd", time()) . str_pad($count + 1, 3, '0', STR_PAD_LEFT);
        $data['addtime'] = date("Y-m-d H:i:s", time());
        return $data;
    }

    public function _befor_edit()
    {
        $model = D($this->dbname);
        $info  = $model->find(I('get.id'));
        $attid = $info['id'];
        $this->assign('attid', $attid);

        $files = M('files')->where(array('attid'=>$attid))->select();
        $this->assign('files',$files);

    }
    public function _befor_view()
    {
        $files = M('files')->where(array('attid'=>I('get.id')))->select();
        $this->assign('files',$files);
    }

    public function _befor_update($data)
    {
        if ($data['type'] == '寄售') {
            $data['endtime'] = empty($data['endtime']) ? null : $data['endtime'];
            $model = D($this->dbname);
            $info = $model->getById($data['id']);
            if(empty($info['starttime'])){
                $data['starttime'] = date("Y-m-d H:i:s", time());
            }
        } else {
            unset($data['endtime']);
            $data['starttime'] = null;
        }
        return $data;
    }

    public function _after_edit($id)
    {
        $postData = I('post.');
        if(!isset($postData['fileids'])){
            return;
        }

        // 更新fileid
        $model = M('files');
        $map['id'] = array('in', implode(',', $postData['fileids']));
        $data['attid'] = $id;
        $model->where($map)->save($data);
        // 删除移除的图片
        $where['id'] = array('not in', implode(',', $postData['fileids']));
        $where['ABS(attid)'] = $id;
        // $where['attid'] = array('eq', -$id);
        // $where['_logic'] = 'or';
        // $map['_complex'] = $where;
        $files = $model->where($where)->select();
        if($files){
            foreach ($files as $file) {
                @unlink($file['filename']);
            }
        }
        $model->where($where)->delete();
    }

    public function _befor_del($id)
    {

    }

    public function lock(){
        $model = D($this->dbname);
        $id    = I('get.id');
        if ($id) {
            \Think\Log::write('lock: '. $id);
            $data       = $model->find($id);
            $data['id'] = $id;
            if ($data['lock'] == 1) {
                $data['lock'] = 0;
                $msg          = '锁定';
            } else {
                $data['lock'] = 1;
                $msg            = '启用';
            }
            // $model->save($data);
            $model->where('id=' . $id .'')->setField('lock', $data['lock']);
            $this->mtReturn(200, $msg . $id, $_REQUEST['navTabId'], false);
        } else {
            \Think\Log::write('lock: 清理数据');
            $dbModel = D();
            // 1、备份数据； 2、删除数据
            // 图片文件
			// -- 出库记录
			// -- 入库记录
			// -- 库存数据
            // $sql = 'INSERT INTO v2_files_del SELECT * FROM v2_files WHERE attid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'DELETE FROM v2_files WHERE attid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'INSERT INTO v2_proout_del SELECT * FROM v2_proout WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'DELETE FROM v2_proout WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'INSERT INTO v2_proin_del SELECT * FROM v2_proin WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'DELETE FROM v2_proin WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);';
            // $sql .= 'INSERT INTO v2_pro_del SELECT * FROM v2_pro WHERE `lock` = 0;';
            // \Think\Log::write('del: '. $sql);
            // $dbModel->execute($sql);
            $dbModel->execute('
                INSERT INTO v2_files_del SELECT * FROM v2_files WHERE attid in (SELECT id FROM v2_pro WHERE `lock` = 0);
                DELETE FROM v2_files WHERE attid in (SELECT id FROM v2_pro WHERE `lock` = 0);

                INSERT INTO v2_proout_del SELECT * FROM v2_proout WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);
                DELETE FROM v2_proout WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);

                INSERT INTO v2_proin_del SELECT * FROM v2_proin WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);
                DELETE FROM v2_proin WHERE jpid in (SELECT id FROM v2_pro WHERE `lock` = 0);

                INSERT INTO v2_pro_del SELECT * FROM v2_pro WHERE `lock` = 0;
            ');
            
            // DELETE FROM v2_pro WHERE lock = 0;
			
            $Rs = $model->where('`lock` = 0')->delete();
            $this->mtReturn(200, '清理' . $Rs . '条无用的记录', $_REQUEST['navTabId'], false);
        }
        
    }
    
    public function outxls()
    {
        $model = D($this->dbname);
        $map   = $this->_search();
        if (method_exists($this, '_filter')) {
            $this->_filter($map);
        }
        $list     = $model->where($map)->field('id,name,fenlei,jiage,sjiage,type,ruku,kucun,chuku,title,uname,addtime,updatetime')->select();
        $headArr  = array('商品编码', '商品名称', '商品分类', '进价', '售价', '计量单位', '入库数量', '库存数量', '出库数量', '型号规格', '添加人', '添加时间', '更新时间');
        $filename = '商品信息';
        $this->xlsout($filename, $headArr, $list);
    }
    
    public function getBack()
    {
        $model = D($this->dbname);
        $id    = I('get.id');
        $data['id'] = $id;
        $data['status'] = '取回';
        if(false === $data = $model->create($data,$model::MODEL_UPDATE)){
            $this->mtReturn(300, '失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
        }
        $model->save($data);
        $this->mtReturn(200, "取回成功" , $_REQUEST['navTabId'], true);
    }

    public function autoUpdate($data)
    {
        $model = D('pro');
        if (false === $data = $model->create($data,$model::MODEL_UPDATE)) {
            $this->mtReturn(300, '自动同步库存记录失败，请检查值是否已经存在', $_REQUEST['navTabId'], true);
        }
        if (!$model->save($data)) {
            $this->mtReturn(300, "自动同步库存记录失败", $_REQUEST['navTabId'], true);
        }
    }


    // 寄售商品未售出未预订 可取回
    public function quhui()
    {
        if(!IS_POST){
            $this->mtReturn(300,'只支持post请求');
        }
        $model = D($this->dbname);
        $ids   = $_REQUEST['ids'];
        if (empty($ids)) {
            $this->mtReturn(300,"取回商品不能为空！");
        }
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']       = array('in', $ids);
        $map['type']   = array('eq', '寄售');
        $where['status'] = array('neq', '售出');
        $where['status'] = array('neq', '预订');
        $where['_logic'] = 'or';
        $map['_complex'] = $where;
        $tmpCount        = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn(300,'【寄售】商品【未售出】【未预订】时可取回');
        }
        
        $data['id']     = array('in', $ids);
        $data['status'] = '取回';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn(300,$model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn(300,$model->getError());
        }
        $info = $this->dbname . ' 取回成功! proid:' . implode('|', $ids);
        $this->mtReturn(200,$info, $_REQUEST['navTabId'], false);
    }

    // 售出商品可退货
    public function tuihuo()
    {
        if(!IS_POST){
            $this->mtReturn(300,'只支持post请求');
        }
        $model = D($this->dbname);
        $ids   = $_REQUEST['ids'];
        if (empty($ids)) {
            $this->mtReturn(300,"退货商品不能为空！");
        }
        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']     = array('in', $ids);
        $map['status'] = array('neq', '售出');
        $tmpCount      = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn(300,'只有【售出】的商品才可【退货】');
        }
        $data['id']     = array('in', $ids);
        $data['sjiage'] = 0;
        $data['yufu'] = 0;
        $data['zhekou'] = 0;
        $data['outtime'] = null;
        $data['status'] = '在库';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn(300,$model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn(300,$model->getError());
        }
        $this->mtReturn(200,$this->dbname . ' 退货成功! proid:' . implode('|', $ids), $_REQUEST['navTabId'],false);
    }

    // 寄售商品 售出但未打款 可打款
    public function dakuan()
    {
        if(!IS_POST){
            $this->mtReturn(300,'只支持post请求');
        }
        $model = D($this->dbname);
        $ids   = $_REQUEST['ids'];

        if (empty($ids)) {
            $this->mtReturn(300,"需打款商品不能为空！");
        }

        if (!in_array(getuserid(), C('ADMINISTRATOR'))) {
            $map['depid'] = array('EQ', getdepid());
        }
        $map['id']          = array('in', $ids); //implode(',', $ids)
        $where['type']        = array('neq', '寄售');
        $where['status']    = array('neq', '售出');
        $where['paystatus'] = array('neq', '未打款');
        $where['_logic']    = 'or';
        $map['_complex']    = $where;
        $tmpCount           = $model->where($map)->count();
        if ($tmpCount > 0) {
            $this->mtReturn(300,'【寄售】商品【售出】但【未打款】才需打款');
        }
        $data['id']        = array('in', $ids);// implode(',', $ids)
        $data['paystatus'] = '已打款';
        if (false === $data = $model->create($data, $model::MODEL_UPDATE)) {
            $this->mtReturn(300,$model->getError());
        }
        if (!$model->save($data)) {
            $this->mtReturn(300,$model->getError());
        }
        $this->mtReturn(200, $this->dbname . ' 打款成功! proid:' . $ids,$_REQUEST['navTabId'],false);
    }

}
