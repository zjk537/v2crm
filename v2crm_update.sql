/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : 127.0.0.1
 Source Database       : v2crm

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : utf-8

 Date: 04/26/2017 22:27:05 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `v2_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `v2_auth_group`;
CREATE TABLE `v2_auth_group` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '类型 0 店面; 1 职位',
  `name` varchar(50) NOT NULL COMMENT '名称',-- update title
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '店面联系电话',
  `level` int(2) NOT NULL COMMENT '所属级别',
  `pid` int(4) NOT NULL COMMENT '父级id',
  `sort` int(4) NOT NULL COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(2000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户分组表 店面表';

-- ----------------------------
--  Records of `v2_auth_group`
-- ----------------------------
BEGIN;
INSERT INTO `v2_auth_group` VALUES 
('1', '0', '系统运维', '','0', '0', '1', '1', ''), 
('2', '0', '建外SOHO','010-47228827', '0', '0', '2', '1', ''), 
('3', '0', '三里屯', '010-47228828','0', '0', '3', '1', ''), 
('4', '1', '管理员','', '1', '1', '1', '1', ''), 
('5', '1', '店长', '','0', '0', '1', '1', ''), 
('6', '1', '店员', '','0', '0', '1', '1', '');
COMMIT;

-- ----------------------------
--  Table structure for `v2_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `v2_auth_group_access`;
CREATE TABLE `v2_auth_group_access` (
  `uid` mediumint(8) NOT NULL,
  `group_id` mediumint(8) NOT NULL,
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户职位表';

-- ----------------------------
--  Table structure for `v2_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `v2_auth_rule`;
CREATE TABLE `v2_auth_rule` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL COMMENT '级别',
  `pid` int(11) NOT NULL COMMENT '父级Id',
  `action` char(80) NOT NULL DEFAULT '' COMMENT '操作名称',-- update name
  `name` char(20) NOT NULL DEFAULT '' COMMENT '名称',-- update title
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` char(100) NOT NULL DEFAULT '',
  `sort` tinyint(4) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `action` (`action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='菜单功能表';

-- ----------------------------
--  Records of `v2_auth_rule`
-- ----------------------------
BEGIN;
INSERT INTO `v2_auth_rule` VALUES 
('1', '0', '0', 'home/system/index', '系统管理', '1', '1', '', '99'), 
('2', '1', '1', 'home/org/', '店面管理', '1', '1', '', '1'), 
('3', '2', '2', 'home/org/add', '新增', '1', '1', '', '1'), 
('4', '2', '2', 'home/org/edit', '编辑', '1', '1', '', '2'), 
('5', '2', '2', 'home/org/index', '查看', '1', '1', '', '0'), 
('6', '2', '2', 'home/org/del', '删除', '1', '1', '', '3'), 
('8', '1', '1', 'home/dep', '职位管理', '1', '1', '', '2'), 
('9', '2', '8', 'home/dep/index', '查看', '1', '1', '', '0'), 
('10', '2', '8', 'home/dep/add', '新增', '1', '1', '', '1'), 
('11', '2', '8', 'home/dep/edit', '编辑', '1', '1', '', '2'), 
('12', '2', '8', 'home/dep/del', '删除', '1', '1', '', '3'), 
('13', '2', '8', 'home/dep/editrule', '权限', '1', '1', '', '4'), 
('14', '1', '1', 'home/user/', '用户管理', '1', '1', '', '3'), 
('15', '2', '14', 'home/user/index', '查看', '1', '1', '', '0'), 
('16', '2', '14', 'home/user/add', '新增', '1', '1', '', '1'), 
('17', '2', '14', 'home/user/edit', '编辑', '1', '1', '', '2'), 
('18', '2', '14', 'home/user/del', '删除', '1', '1', '', '3'), 
('19', '2', '14', 'home/user/editrule', '权限', '1', '1', '', '4'), 
('20', '1', '1', 'home/config/', '数据字典', '1', '1', '', '4'), 
('21', '2', '20', 'home/config/index', '查看', '1', '1', '', '0'), 
('22', '2', '20', 'home/config/add', '新增', '1', '1', '', '1'), 
('23', '2', '20', 'home/config/edit', '编辑', '1', '1', '', '2'), 
('24', '2', '20', 'home/config/del', '删除', '1', '1', '', '3'), 
('25', '1', '1', 'home/menu/', '菜单管理', '1', '1', '', '5'), 
('26', '2', '25', 'home/menu/index', '查看', '1', '1', '', '0'), 
('27', '2', '25', 'home/menu/add', '新增', '1', '1', '', '1'), 
('28', '2', '25', 'home/menu/edit', '编辑', '1', '1', '', '2'), 
('29', '2', '25', 'home/menu/del', '删除', '1', '1', '', '3'), 
('30', '1', '1', 'home/rule/', '功能列表', '1', '1', '', '6'), 
('31', '2', '30', 'home/rule/index', '查看', '1', '1', '', '0'), 
('32', '2', '30', 'home/rule/add', '新增', '1', '1', '', '1'), 
('33', '2', '30', 'home/rule/edit', '编辑', '1', '1', '', '2'), 
('34', '2', '30', 'home/rule/del', '删除', '1', '1', '', '3'), 
('35', '1', '1', 'home/database', '数据备份', '1', '1', '', '10'), 
('36', '2', '35', 'home/database/index', '查看', '1', '1', '', '0'), 
('37', '1', '1', 'home/database/', '备份文件', '1', '1', '', '11'), 
('38', '2', '37', 'home/database/bakup', '查看', '1', '1', '', '0'), 
('39', '1', '1', 'home/log', '操作日志', '1', '1', '', '15'), 
('40', '2', '39', 'home/log/index', '查看', '1', '1', '', '0'), 
('41', '2', '39', 'home/log/del', '删除', '1', '1', '', '1'), 
('163', '0', '0', 'home/cust/index', '客户管理', '1', '1', '', '3'), 
('164', '1', '163', 'home/cust/', '客户信息', '1', '1', '', '1'), 
('165', '2', '164', 'home/cust/view', '查看', '1', '1', '', '0'), 
('166', '2', '164', 'home/cust/add', '新增', '1', '1', '', '1'), 
('167', '2', '164', 'home/cust/edit', '编辑', '1', '1', '', '2'), 
('168', '2', '164', 'home/cust/del', '删除', '1', '1', '', '3'), 
('169', '2', '164', 'home/cust/outxls', '导出', '1', '1', '', '4'), 
('199', '0', '0', 'home/stock/index', '库存管理', '1', '1', '', '2'), 
('200', '1', '199', 'home/pro/index', '商品管理', '1', '1', '', '1'), 
('201', '2', '200', 'home/pro/view', '查看', '1', '1', '', '0'), 
('202', '2', '200', 'home/pro/add', '新增', '1', '1', '', '1'), 
('203', '2', '200', 'home/pro/edit', '编辑', '1', '1', '', '2'), 
('204', '2', '200', 'home/pro/del', '删除', '1', '1', '', '3'), 
('205', '2', '200', 'home/pro/outxls', '导出', '1', '1', '', '4'), 
('206', '1', '199', 'home/proin/index', '入库记录', '1', '1', '', '2'), 
('207', '2', '206', 'home/proin/view', '查看', '1', '1', '', '0'), 
('209', '2', '206', 'home/proin/edit', '编辑', 1, 1, '', 2),
('210', '2', '206', 'home/proin/outxls', '导出', '1', '1', '', '4'), 
('211', '1', '199', 'home/proout/index', '出库记录', '1', '1', '', '3'), 
('212', '2', '211', 'home/proout/view', '查看', '1', '1', '', '0'), 
('214', '2', '211', 'home/proout/edit', '编辑', 1, 1, '', 2),
('215', '2', '211', 'home/proout/outxls', '导出', '1', '1', '', '4');
COMMIT;

-- ----------------------------
--  Table structure for `v2_config`
-- ----------------------------
DROP TABLE IF EXISTS `v2_config`;
CREATE TABLE `v2_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fenlei` varchar(20) NOT NULL COMMENT '分类',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `desc` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',-- update title
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置项',
  `remark` varchar(100) NOT NULL COMMENT '备注',
  `addtime` datetime NOT NULL COMMENT '创建时间',
  `updatetime` datetime NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置';

-- ----------------------------
--  Records of `v2_config`
-- ----------------------------
BEGIN;
INSERT INTO `v2_config` VALUES ('1', '系统', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '', '主要用于数据解析和页面表单的生成', '2015-02-01 14:39:41', null, '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '0'), 
('2', '基础', 'PERPAGE', '0', '每页条数', '', '列表分页条数', '2015-02-01 14:49:47', null, '1', '15', '0'), 
('3', '基础', 'SEARCHKEY', '3', '参与搜索的字段名', '', '', '2015-02-01 14:56:03', null, '1', '1:name\r\n2:title\r\n3:username\r\n4:value\r\n5:truename\r\n6:tel\r\n7:email\r\n8:qq\r\n9:phone\r\n10:type\r\n11:xingming\r\n12:xueli\r\n13:xuexiao\r\n14:fenlei\r\n15:depname\r\n16:posname\r\n17:dianhua\r\n18:danwei\r\n19:zhiwu\r\n20:uname\r\n21:uuname\r\n22:beizhu\r\n23:zhuangtai\r\n24:bumen\r\n25:zhiwei\r\n26:zhuanye\r\n27:zaizhi\r\n28:jcname\r\n29:juname\r\n30:gonghao', '0'), 
('4', '系统', 'DATA_CACHE_TIME', '0', '数据缓存时间', '', '数据缓存有效期 0表示永久缓存', '2015-02-01 15:05:20', null, '1', '14400', '0'), 
('5', '系统', 'SESSION_PREFIXX', '1', 'session 前缀', '', '', '2015-02-01 15:07:09', null, '1', 'v2', '0'), 
('6', '系统', 'WEB_SITE_TITLE', '2', '系统名称', '', '', '2015-02-01 15:17:46', null, '1', 'V2系统信息化管理平台', '0'), 
('7', '系统', 'DATA_BACKUP_PATH', '1', '数据库备份路径', '', '', '2015-02-01 15:55:43', null, '1', 'data', '0'), 
('8', '系统', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '2015-02-01 15:56:41', null, '1', '20971520', '0'), 
('9', '系统', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '2015-02-01 15:57:49', null, '1', '1', '0'), 
('10', '系统', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '2015-02-01 15:58:48', null, '1', '9', '0'), 
('11', '模型', 'MODEL_F_TYPE', '3', '图表类型', '', '', '2015-03-06 14:16:26', null, '1', '0:不生成\r\n1:3D饼图\r\n2:柱状图\r\n3:曲线图\r\n4:环状图\r\n5:柱商务图', '0'), 
('12', '模型', 'MODEL_L_SHOW', '3', '字段模型列表显示', '', '', '2015-02-02 14:55:31', null, '1', '0:不显示\r\n1:显示', '0'), 
('13', '模型', 'MODEL_B_ATTR', '3', '数据模型中表单属性', '', '', '2015-02-02 15:46:08', null, '1', '0:文本框\r\n1:文本域\r\n2:密码框\r\n3:日期框\r\n4:编辑器\r\n5:微调器\r\n6:单选框\r\n7:多选框\r\n8:下拉框\r\n9:查找带回\r\n10:上传附件\r\n11:日期时间框', '0'), 
('14', '模型', 'MODEL_B_ISMUST', '3', '数据模型中是否必填', '', '', '2015-02-02 16:05:26', null, '1', '0:非必填\r\n1:必填\r\n2:必填日期\r\n3:必填手机号码\r\n4:必填EMAIL\r\n5:必填字母\r\n6:必填身份证号码\r\n7:必填中文\r\n8:必填数字\r\n9:必填日期时间', '0'), 
('15', '模型', 'MODEL_B_ISSORT', '3', '数据模型中的字段是否参与排序', '', '', '2015-02-02 19:53:07', null, '1', '0:不参与\r\n1:参与', '0'), 
('16', '基础', 'BASE_SEX', '3', '性别', '', '', '2015-02-02 21:21:58', null, '1', '0:男\r\n1:女', '0'), 
('17', '模型', 'MODEL_B_SHOW', '3', '字段模型表单显示', '', '', '2015-02-01 22:12:54', null, '1', '0:不显示\r\n1:都显示\r\n2:新增显示\r\n3:编辑显示', '0'), 
('18', '基础', 'CONFIG_CLASS', '3', '配置分类', '', '', '2015-02-25 10:22:21', null, '1', '0:系统\r\n1:基础\r\n2:模型\r\n3:客户管理\r\n4:库存管理', '0'), 
('34', '客户管理', 'CUST_TYPE', '3', '客户来源', '', '', '2015-03-03 21:44:04', null, '1', '百度推广\r\n电话营销\r\n主动联系\r\n客户介绍', '0'), 
('35', '客户管理', 'CUSTGD_TYPE', '3', '联系方式', '', '', '2015-03-04 11:18:41', null, '1', '电话\r\nQQ\r\n电子邮箱\r\n上门拜访', '0'), 
('36', '客户管理', 'CUSTGD_FENLEI', '3', '进展阶段', '', '', '2015-03-04 11:22:02', null, '1', '需求整理\r\n选择比较\r\n购买决定\r\n成交客户\r\n他人签单', '0'), 
('37', '库存管理', 'PRO_TYPE', '3', '产品来源', '', '', '2015-03-04 20:47:13', null, '1', '寄售\r\n进货', '0'), 
('39', '库存管理', 'PRO_STATUS', '3', '产品状态', '', '', '2015-03-04 20:47:13', null, '1', '在库\r\n预定\r\n售出\r\n取回', '0'), 
('40', '库存管理', 'PRO_PAY_TYPE', '3', '付款方式', '', '', '2015-03-04 20:47:13', '2017-06-12 22:26:34', '1', '现金\r\n汇款\r\n信用卡\r\n网银转帐', '0'), 
('41', '库存管理', 'PRO_PAY_STATUS', '3', '付款状态', '', '付款状态', '2015-02-01 15:58:48', '2017-06-06 20:58:30', '1', '已打款\r\n未打款', '0'), 
('42', '库存管理', 'PRO_JS_WARN', '0', '寄售预警时间', '', '寄售到期提前7天给预警提示', '2017-05-26 13:29:29', null, '1', '7', '0'), 
('43', '库存管理', 'PRO_SC_WARN', '0', '售出商品预警时间', '', '已售出未付款超过2天', '2017-05-26 14:36:22', null, '1', '2', '0');
COMMIT;

-- ----------------------------
--  Table structure for `v2_cust`
-- ----------------------------
DROP TABLE IF EXISTS `v2_cust`;
CREATE TABLE `v2_cust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '联系人',-- update xingming
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `remark` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',-- update beizhu
  -- `title` varchar(50) NOT NULL DEFAULT '' COMMENT '公司名称',-- del
  `dizhi` varchar(200) NOT NULL DEFAULT '' COMMENT '地址',
  -- `email` varchar(200) NOT NULL DEFAULT '' COMMENT '电子邮件',-- del
  -- `qq` varchar(50) NOT NULL DEFAULT '' COMMENT 'QQ' ,-- del
  `sex` varchar(2) NOT NULL DEFAULT '' COMMENT '性别',
  `yhname` varchar(50) NOT NULL DEFAULT '' COMMENT '开户行',-- new
  `yhcard` varchar(30) NOT NULL DEFAULT '' COMMENT '银行卡号', -- new
  `idcard` varchar(20) NOT NULL DEFAULT '' COMMENT '身份证号', -- new
  -- `bumen` varchar(50) NOT NULL DEFAULT '' COMMENT '部门', -- del
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '客户来源',
  -- `fenlei` varchar(20) NOT NULL DEFAULT '' COMMENT '进展',-- del
  -- `name` varchar(100) NOT NULL DEFAULT '',-- del
  `juid` int(11) NOT NULL DEFAULT 0 COMMENT '经办人Id',
  `juname` varchar(50) NOT NULL DEFAULT '' COMMENT '经办人',
  `uid` int(11) NOT NULL COMMENT '操作人Id',
  `uname` varchar(50) NOT NULL COMMENT '操作人',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `uuid` int(11) NULL COMMENT '更新人Id',
  `uuname` varchar(50) NULL COMMENT '更新人',
  `updatetime` datetime NULL COMMENT '更新时间',
  -- `xcrq` date NULL COMMENT '下次联系时间',-- del
  -- `addm` varchar(20) NULL DEFAULT '' COMMENT '添加月份', -- del
  PRIMARY KEY (`id`),
  UNIQUE KEY (`phone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客户管理';

-- ----------------------------
--  Table structure for `v2_files`
-- ----------------------------
DROP TABLE IF EXISTS `v2_files`;
CREATE TABLE `v2_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attid` int(11) NOT NULL,
  -- `folder` varchar(50) NOT NULL DEFAULT '' COMMENT '保存目录',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `filetype` varchar(50) NOT NULL DEFAULT '' COMMENT '文件类型',
  -- `filedesc` varchar(200) NOT NULL DEFAULT '' COMMENT '文件说明',
  `uid` varchar(50) NOT NULL COMMENT '操作人Id',
  `uname` varchar(50) NOT NULL COMMENT '操作人',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  -- `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统附件表';

-- ----------------------------
--  Table structure for `v2_log`
-- ----------------------------
DROP TABLE IF EXISTS `v2_log`;
CREATE TABLE `v2_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `username` char(20) NOT NULL,
  `content` char(100) NOT NULL,
  `os` varchar(300) NOT NULL,
  `url` char(100) NOT NULL,
  `ip` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- ----------------------------
--  Table structure for `v2_menu`
-- ----------------------------
DROP TABLE IF EXISTS `v2_menu`;
CREATE TABLE `v2_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` tinyint(1) NOT NULL,
  `pid` int(4) NOT NULL,
  `catename` char(20) NOT NULL DEFAULT '',
  `alink` char(100) NOT NULL DEFAULT '',
  `sort` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- ----------------------------
--  Records of `v2_menu`
-- ----------------------------
BEGIN;
INSERT INTO `v2_menu` VALUES 
('1', '0', '0', '库存管理', 'stock/index', '2', '1'), 
('3', '0', '0', '客户管理', 'Cust/index', '3', '1'), 
('7', '0', '0', '系统管理', 'system/index', '99', '1'), 
('25', '1', '1', '商品信息', 'pro/index', '1', '1'), 
('32', '1', '1', '出库记录', 'proout/index', '3', '1'), 
('62', '1', '1', '入库记录', 'proin/index', '2', '1'), 
('49', '1', '3', '客户信息', 'cust/index', '1', '1'), 
('9', '1', '7', '组织机构', 'org/index', '1', '1'), 
('13', '1', '7', '操作日志', 'Log/index', '7', '1'), 
('21', '1', '7', '备份文件', 'database/bakup', '5', '1'), 
('22', '1', '7', '系统设置', 'system/index', '1', '1'), 
('24', '1', '7', '数据备份', 'Database/index', '4', '1'), 
('10', '2', '9', '职位管理', 'dep/index', '2', '1'), 
('14', '2', '9', '用户管理', 'user/index', '3', '1'), 
('23', '2', '9', '店面管理', 'org/index', '0', '1'), 
('11', '2', '22', '菜单管理', 'menu/index', '4', '1'), 
('19', '2', '22', '功能列表', 'rule/index', '5', '1'), 
('31', '2', '22', '数据字典', 'config/index', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `v2_pro`
-- ----------------------------
DROP TABLE IF EXISTS `v2_pro`;
CREATE TABLE `v2_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `depid` int(11) NOT NULL COMMENT '店面Id',
  `depname` varchar(50) NOT NULL COMMENT '店面名称',
  `depphone` varchar(20) NOT NULL DEFAULT '' COMMENT '店面电话',
  `name` varchar(50) NOT NULL COMMENT '产品名称',
  `fenlei` varchar(20) NOT NULL COMMENT '产品分类',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '产品编码',-- new
  `jcode` varchar(20) NOT NULL COMMENT '原始编码',-- new
  `cid` int(11) NOT NULL DEFAULT 0 COMMENT '寄售人或供应商id',-- new
  `cname` varchar(50) NULL COMMENT '寄售人或供应商', -- new
  `type` varchar(20) NOT NULL COMMENT '来源类型', -- update
  `color` varchar(20) NULL COMMENT '颜色', -- new
  `chengse` varchar(20) NULL COMMENT '成色', -- new 
  `bujian` varchar(20) NULL COMMENT '部件', -- new 

  `chima` varchar(20) NULL COMMENT '尺码', -- new 
  `jiankuan` varchar(20) NULL COMMENT '肩宽', -- new 
  `yaowei` varchar(20) NULL COMMENT '腰围', -- new 
  `xiongwei` varchar(20) NULL COMMENT '胸围', -- new 
  `tunwei` varchar(20) NULL COMMENT '臀围', -- new 
  `yichang` varchar(20) NULL COMMENT '衣长', -- new 
  `kuchang` varchar(20) NULL COMMENT '裤长', -- new 
  `xiuchang` varchar(20) NULL COMMENT '袖长', -- new 
  `jiage` int(11) NOT NULL COMMENT '进价',
  `bjiage` int(11) NOT NULL COMMENT '标价',-- new
  `sjiage` int(11) NOT NULL DEFAULT 0 COMMENT '销售价格',
  `yufu` int(11) NOT NULL DEFAULT 0 COMMENT '预付金额',-- new
  `zhekou` int(11) NOT NULL DEFAULT 0 COMMENT '折扣金额', -- new
  `status` varchar(20) NOT NULL COMMENT '产品状态',-- update
  `paystatus` varchar(20) NULL COMMENT '付款状态',-- new
  `remark` text NULL COMMENT '备注', -- update beizhi
  `starttime` datetime NULL COMMENT '寄售开始时间', -- new
  `endtime` datetime NULL COMMENT '寄售结束时间', -- new
  `outtime` datetime NULL COMMENT '售出时间', -- new
  -- `title` varchar(50) NOT NULL COMMENT '型号规格', -- del
  `uid` int(11) NOT NULL COMMENT '添加人Id',
  `uname` varchar(50) NOT NULL COMMENT '添加人',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `uuid` int(11) NULL COMMENT '更新人Id',
  `uuname` varchar(50) NULL COMMENT '更新人',
  `updatetime` datetime NULL COMMENT '更新时间',
  -- `kucun` int(11) NOT NULL DEFAULT '0' COMMENT '库存数量',-- del
  -- `ruku` int(11) NOT NULL DEFAULT '0' COMMENT '入库数量', -- del
  -- `chuku` int(11) NOT NULL DEFAULT '0' COMMENT '出库数量 ',-- del
  -- `tuiku` int(11) NOT NULL DEFAULT '0' COMMENT '退库数量', -- del
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='产品管理';

-- ----------------------------
--  Table structure for `v2_proin`
-- ----------------------------
DROP TABLE IF EXISTS `v2_proin`;
CREATE TABLE `v2_proin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jpid` int(11) NOT NULL COMMENT '产品Id',
  `jpname` varchar(50) NOT NULL COMMENT '产品名称',
  `jpjiage` int(11) NOT NULL COMMENT '进价', 
  `paytype` varchar(50) NULL COMMENT '付款方式', -- new
  -- `jpdanwei` varchar(20) NOT NULL COMMENT '计量单位', -- del
  -- `jpguige` varchar(50) NOT NULL COMMENT '规格型号', -- del
  -- `ruku` int(11) NOT NULL DEFAULT 0 COMMENT '入库数量',-- update shuliang
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '说明', -- update title
  `juid` int(11) NOT NULL COMMENT '经办人Id',
  `juname` varchar(50) NOT NULL COMMENT '经办人',
  `uid` int(11) NOT NULL COMMENT '操作人Id',
  `uname` varchar(50) NOT NULL COMMENT '操作人',
  `addtime` datetime NOT NULL COMMENT '操作时间',
  `uuid` int(11) NULL COMMENT '更新人Id', 
  `uuname` varchar(50) NULL COMMENT '更新人', 
  `updatetime` datetime NULL COMMENT '更新时间', 
  -- `status` tinyint(1) NOT NULL DEFAULT '1', -- del
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='入库记录';


-- ----------------------------
--  Table structure for `v2_proout`
-- ----------------------------
DROP TABLE IF EXISTS `v2_proout`;
CREATE TABLE `v2_proout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jpid` int(11) NOT NULL COMMENT '产品Id',
  `jpname` varchar(50) NOT NULL COMMENT '产品名称',
  `jpsjiage` int(11) NOT NULL COMMENT '销售价格',
  `paytype` varchar(50) NOT NULL COMMENT '付款方式', -- new
  `custname` varchar(50) NULL COMMENT '顾客姓名', -- new
  `custphone` varchar(50) NULL COMMENT '顾客联系方式', -- new
  -- `fee` int(11) NOT NULL DEFAULT 0 COMMENT '手续费', -- new
  -- `jpdanwei` varchar(20) NOT NULL COMMENT '计量单位',-- del
  -- `jpguige` varchar(50) NOT NULL COMMENT '产品规格',-- del
  -- `chuku` int(11) NOT NULL DEFAULT 0 COMMENT '出库数量',-- del shuliang
  `beizhu` varchar(100) NULL COMMENT '备注',
  `juid` int(11) NOT NULL COMMENT '经办人Id',
  `juname` varchar(50) NOT NULL COMMENT '经办人',
  `uid` int(11) NOT NULL COMMENT '操作人Id',
  `uname` varchar(50) NOT NULL COMMENT '操作人',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `uuid` int(11)  NULL  COMMENT '更新人Id',-- del
  `uuname` varchar(50) NULL COMMENT '更新人',
  `updatetime` datetime NULL COMMENT '更新时间',
  -- `jhid` int(11) NOT NULL COMMENT '关联合同Id',-- del
  -- `jhname` varchar(50) NOT NULL COMMENT '关联合同',-- del
  -- `status` tinyint(1) NOT NULL DEFAULT '1',-- del
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='出库记录';

-- ----------------------------
--  Table structure for `v2_user`
-- ----------------------------
DROP TABLE IF EXISTS `v2_user`;
CREATE TABLE `v2_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `memo` varchar(50) NOT NULL,
  `depname` varchar(50) NOT NULL,
  `posname` varchar(50) NOT NULL,
  `truename` varchar(50) NOT NULL,
  `sex` char(5) NOT NULL,
  `tel` varchar(20) NOT NULL DEFAULT '',
  `phone` char(11) NOT NULL,
  `neixian` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  `qq` varchar(20) NOT NULL,
  `logintime` datetime DEFAULT NULL,
  `loginip` char(15) DEFAULT NULL,
  `logins` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  `bian` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `v2_user`
-- ----------------------------
BEGIN;
INSERT INTO `v2_user` VALUES 
('1', 'admin', '14e1b600b1fd579f47433b88e8d85291', '74870e1114ddb042052b11710f2e1316', '系统运维', '管理员', 'zjk537', '男', '8552646', '13812349563', '6535665', 'pinkecn@qq.com', '1612985', '2017-04-26 21:34:12', '127.0.0.1', '364', '1', '1493213652', '去采购办公用品，纸张，墨盒\r\n客户资料整理分析\r\n开总结会'), 
('2', 'lintao11', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '建外SOHO', '店长', '林涛', '男', '52', '5', '', '2', '2', '2017-04-25 21:41:49', '127.0.0.1', '4', '1', '1493127709', ''), 
('3', 'lintao22', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '建外SOHO', '店员', '张三', '男', '552', '525', '', 'pinkecn@qq.com', '16212', '2015-03-13 10:02:44', '61.139.126.203', '46', '1', '1426212164', '51212ssss'), 
('4', 'lintao33', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '三里屯', '店长', '李四', '女', '135121', '11212', '', '1212', '1212121', '2015-03-09 11:03:29', '118.123.16.120', '5', '1', '1425870296', '1521');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
