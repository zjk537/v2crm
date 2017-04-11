-- 主机: localhost
-- 生成日期: 2017 年 04 月 11 日 
-- mysql服务器版本: 5.7.17
-- PHP 版本: 5.6.29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `v2crm`
--

-- --------------------------------------------------------

--
-- 表的结构 `v2_auth_group`
--

CREATE TABLE IF NOT EXISTS `v2_auth_group` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `title` char(50) NOT NULL,
  `level` int(2) NOT NULL,
  `pid` int(4) NOT NULL,
  `sort` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `v2_auth_group`
--

INSERT INTO `v2_auth_group` (`id`, `type`, `title`, `level`, `pid`, `sort`, `status`, `rules`) VALUES
(1, 0, '综合办公室', 0, 0, 1, 1, ''),
(2, 0, '财务部', 0, 0, 2, 1, ''),
(3, 0, '技术部', 0, 0, 3, 1, ''),
(4, 0, '市场部', 0, 0, 4, 1, ''),
(5, 1, '总经理', 1, 1, 1, 1, '42,56,57,58,59,61,72,73,74,76,62,63,64,65,66,67,68,69,71,77,78,80,79,82,83,84,85,87,88,89,91,90,93,94,95,96,97,99,100,101,102,103,105,106,107,108,43,44,45,46,48,49,50,52,53,54,55,199,200,201,202,203,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,170,171,172,173,174,175,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,195,196,197,198,220,221,222,223,225,109,110,111,112,113,115,116,117,118,119,120,121,122,123,124,125,126,158,127,128,129,130,132,133,134,135,136,137,139,140,141,142,143,145,146,147,148,149,156,151,152,153,154,157,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,1,14,15,20,21,25,26'),
(6, 1, '办公室主任', 1, 1, 2, 1, ''),
(7, 1, '科员', 1, 1, 3, 1, '42,56,57,58,59,60,61,72,73,74,76,62,63,64,65,67,68,69,71,77,78,80,79,81,82,84,85,88,89,91,90,92,93,94,95,96,97,98,99,100,106,107,108,43,44,45,46,48,49,50,51,52,53,54,55,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,220,221,222,223,225,110,111,112,113,115,116,117,118,119,120,121,122,123,124,125,126,158,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,156,151,152,153,154,155,157,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,2,5,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,159,161,162,37,38,160,39,40,41'),
(8, 0, '市场一组', 1, 4, 1, 1, ''),
(9, 0, '市场三组', 1, 4, 2, 1, ''),
(10, 0, '市场二组', 1, 4, 1, 1, ''),
(12, 0, '市场四组', 1, 4, 1, 1, '1,2,5,3,4,6'),
(13, 1, '会计', 0, 0, 1, 1, '42,56,57,58,59,61,72,73,74,76,62,63,64,65,77,78,80,79,82,88,89,91,90,93,94,95,96,97,99,100,101,102,103,105,106,107,108,43,44,45,46,48,49,50,52,53,54,55,199,200,201,202,203,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,170,171,172,173,174,175,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,195,196,197,198,220,221,222,223,225,110,111,112,113,114,115,125,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,156,151,152,153,154,155,157,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,5,3,4,6,7,9,10,11,12,13,15,16,17,18,19,21,22,23,24,26,27,28,29,31,32,33,34,36,159,161,162,37,38,160,39,40,41');

-- --------------------------------------------------------

--
-- 表的结构 `v2_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `v2_auth_group_access` (
  `uid` mediumint(8) NOT NULL,
  `group_id` mediumint(8) NOT NULL,
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `v2_auth_group_access`
--

INSERT INTO `v2_auth_group_access` (`uid`, `group_id`) VALUES
(2, 5),
(2, 1),
(3, 13),
(3, 2),
(1, 5),
(1, 1),
(4, 4),
(4, 7);

-- --------------------------------------------------------

--
-- 表的结构 `v2_auth_rule`
--

CREATE TABLE IF NOT EXISTS `v2_auth_rule` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `sort` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=242 ;

--
-- 转存表中的数据 `v2_auth_rule`
--

INSERT INTO `v2_auth_rule` (`id`, `level`, `pid`, `name`, `title`, `type`, `status`, `condition`, `sort`) VALUES
(1, 0, 0, 'home/system/index', '系统管理', 1, 1, '', 99),
(2, 1, 1, 'home/org/', '部门管理', 1, 1, '', 1),
(3, 2, 2, 'home/org/add', '新增', 1, 1, '', 1),
(4, 2, 2, 'home/org/edit', '编辑', 1, 1, '', 2),
(5, 2, 2, 'home/org/index', '查看', 1, 1, '', 0),
(6, 2, 2, 'home/org/del', '删除', 1, 1, '', 3),
(7, 2, 2, 'home/org/editrule', '权限', 1, 1, '', 4),
(8, 1, 1, 'home/dep', '职位管理', 1, 1, '', 2),
(9, 2, 8, 'home/dep/index', '查看', 1, 1, '', 0),
(10, 2, 8, 'home/dep/add', '新增', 1, 1, '', 1),
(11, 2, 8, 'home/dep/edit', '编辑', 1, 1, '', 2),
(12, 2, 8, 'home/dep/del', '删除', 1, 1, '', 3),
(13, 2, 8, 'home/dep/editrule', '权限', 1, 1, '', 4),
(14, 1, 1, 'home/user/', '用户管理', 1, 1, '', 3),
(15, 2, 14, 'home/user/index', '查看', 1, 1, '', 0),
(16, 2, 14, 'home/user/add', '新增', 1, 1, '', 1),
(17, 2, 14, 'home/user/edit', '编辑', 1, 1, '', 2),
(18, 2, 14, 'home/user/del', '删除', 1, 1, '', 3),
(19, 2, 14, 'home/user/editrule', '权限', 1, 1, '', 4),
(20, 1, 1, 'home/config/', '数据字典', 1, 1, '', 4),
(21, 2, 20, 'home/config/index', '查看', 1, 1, '', 0),
(22, 2, 20, 'home/config/add', '新增', 1, 1, '', 1),
(23, 2, 20, 'home/config/edit', '编辑', 1, 1, '', 2),
(24, 2, 20, 'home/config/del', '删除', 1, 1, '', 3),
(25, 1, 1, 'home/menu/', '菜单管理', 1, 1, '', 5),
(26, 2, 25, 'home/menu/index', '查看', 1, 1, '', 0),
(27, 2, 25, 'home/menu/add', '新增', 1, 1, '', 1),
(28, 2, 25, 'home/menu/edit', '编辑', 1, 1, '', 2),
(29, 2, 25, 'home/menu/del', '删除', 1, 1, '', 3),
(30, 1, 1, 'home/rule/', '功能列表', 1, 1, '', 6),
(31, 2, 30, 'home/rule/index', '查看', 1, 1, '', 0),
(32, 2, 30, 'home/rule/add', '新增', 1, 1, '', 1),
(33, 2, 30, 'home/rule/edit', '编辑', 1, 1, '', 2),
(34, 2, 30, 'home/rule/del', '删除', 1, 1, '', 3),
(35, 1, 1, 'home/database', '数据备份', 1, 1, '', 10),
(36, 2, 35, 'home/database/index', '查看', 1, 1, '', 0),
(37, 1, 1, 'home/database/', '备份文件', 1, 1, '', 11),
(38, 2, 37, 'home/database/bakup', '查看', 1, 1, '', 0),
(39, 1, 1, 'home/log', '操作日志', 1, 1, '', 15),
(40, 2, 39, 'home/log/index', '查看', 1, 1, '', 0),
(41, 2, 39, 'home/log/del', '删除', 1, 1, '', 1),
(42, 0, 0, 'home/office/index', '个人办公', 1, 1, '', 1),
(43, 1, 42, 'home/contact/index', '我的通讯录', 1, 1, '', 21),
(44, 2, 43, 'home/contact/view', '查看', 1, 1, '', 0),
(45, 2, 43, 'home/contact/add', '新增', 1, 1, '', 1),
(46, 2, 43, 'home/contact/edit', '编辑', 1, 1, '', 2),
(47, 2, 43, 'home/contact/del', '删除', 1, 1, '', 3),
(48, 2, 43, 'home/contact/outxls', '导出', 1, 1, '', 4),
(49, 1, 42, 'home/pcontact/index', '公共通讯录', 1, 1, '', 22),
(50, 2, 49, 'home/pcontact/view', '查看', 1, 1, '', 0),
(51, 2, 49, 'home/pcontact/del', '删除', 1, 1, '', 2),
(52, 2, 49, 'home/pcontact/outxls', '导出', 1, 1, '', 3),
(53, 1, 42, 'home/ccontact/', '公司通讯录', 1, 1, '', 23),
(54, 2, 53, 'home/ccontact/index', '查看', 1, 1, '', 1),
(55, 2, 53, 'home/ccontact/outxls', '导出', 1, 1, '', 3),
(56, 1, 42, 'home/mygo/index', '我的去向', 1, 1, '', 0),
(57, 2, 56, 'home/mygo/view', '查看', 1, 1, '', 0),
(58, 2, 56, 'home/mygo/add', '新增', 1, 1, '', 1),
(59, 2, 56, 'home/mygo/edit', '编辑', 1, 1, '', 2),
(60, 2, 56, 'home/mygo/del', '删除', 1, 1, '', 3),
(61, 2, 56, 'home/mygo/outxls', '导出', 1, 1, '', 4),
(62, 1, 42, 'home/mytask/index', '我的任务', 1, 1, '', 3),
(63, 2, 62, 'home/mytask/view', '查看', 1, 1, '', 0),
(64, 2, 62, 'home/mytask/edit', '编辑', 1, 1, '', 2),
(65, 2, 62, 'home/mytask/outxls', '导出', 1, 1, '', 4),
(66, 1, 42, 'home/task/index', '指派任务', 1, 1, '', 4),
(67, 2, 66, 'home/task/view', '查看', 1, 1, '', 0),
(68, 2, 66, 'home/task/add', '新增', 1, 1, '', 1),
(69, 2, 66, 'home/task/edit', '编辑', 1, 1, '', 2),
(70, 2, 66, 'home/task/del', '删除', 1, 1, '', 3),
(71, 2, 66, 'home/task/outxls', '导出', 1, 1, '', 4),
(72, 1, 42, 'home/mygos/index', '员工去向', 1, 1, '', 1),
(73, 2, 72, 'home/mygos/view', '查看', 1, 1, '', 0),
(74, 2, 72, 'home/mygos/edit', '编辑', 1, 1, '', 2),
(75, 2, 72, 'home/mygos/del', '删除', 1, 1, '', 3),
(76, 2, 72, 'home/mygos/outxls', '导出', 1, 1, '', 4),
(77, 1, 42, 'home/myreport/index', '我的工作汇报', 1, 1, '', 5),
(78, 2, 77, 'home/myreport/view', '查看', 1, 1, '', 0),
(79, 2, 77, 'home/myreport/edit', '编辑', 1, 1, '', 2),
(80, 2, 77, 'home/myreport/add', '新增', 1, 1, '', 1),
(81, 2, 77, 'home/myreport/del', '删除', 1, 1, '', 3),
(82, 2, 77, 'home/myreport/outxls', '导出', 1, 1, '', 4),
(83, 1, 42, 'home/report/index', '批注工作汇报', 1, 1, '', 6),
(84, 2, 83, 'home/report/view', '查看', 1, 1, '', 0),
(85, 2, 83, 'home/report/edit', '编辑', 1, 1, '', 2),
(86, 2, 83, 'home/report/del', '删除', 1, 1, '', 3),
(87, 2, 83, 'home/report/outxls', '导出', 1, 1, '', 4),
(88, 1, 42, 'home/doc/index', '我的文档', 1, 1, '', 7),
(89, 2, 88, 'home/doc/view', '查看', 1, 1, '', 0),
(90, 2, 88, 'home/doc/edit', '编辑', 1, 1, '', 2),
(91, 2, 88, 'home/doc/add', '新增', 1, 1, '', 1),
(92, 2, 88, 'home/doc/del', '删除', 1, 1, '', 3),
(93, 2, 88, 'home/doc/outxls', '导出', 1, 1, '', 4),
(94, 1, 42, 'home/zhishi/index', '知识管理', 1, 1, '', 8),
(95, 2, 94, 'home/zhishi/view', '查看', 1, 1, '', 0),
(96, 2, 94, 'home/zhishi/add', '新增', 1, 1, '', 1),
(97, 2, 94, 'home/zhishi/edit', '编辑', 1, 1, '', 2),
(98, 2, 94, 'home/zhshi/del', '删除', 1, 1, '', 3),
(99, 2, 94, 'home/zhishi/outxls', '导出', 1, 1, '', 4),
(100, 1, 42, 'home/info/index', '发通知', 1, 1, '', 9),
(101, 2, 100, 'home/info/view', '查看', 1, 1, '', 0),
(102, 2, 100, 'home/info/add', '新增', 1, 1, '', 1),
(103, 2, 100, 'home/info/edit', '编辑', 1, 1, '', 2),
(104, 2, 100, 'home/info/del', '删除', 1, 1, '', 3),
(105, 2, 100, 'home/info/outxls', '导出', 1, 1, '', 4),
(106, 1, 42, 'home/myinfo/index', '收通知', 1, 1, '', 10),
(107, 2, 106, 'home/myinfo/view', '查看', 1, 1, '', 0),
(108, 2, 106, 'home/myinfo/edit', '回复', 1, 1, '', 2),
(109, 0, 0, 'home/hr/index', '人事管理', 1, 1, '', 4),
(110, 1, 109, 'home/hr/', '员工档案', 1, 1, '', 1),
(111, 2, 110, 'home/hr/view', '查看', 1, 1, '', 0),
(112, 2, 110, 'home/hr/add', '新增', 1, 1, '', 1),
(113, 2, 110, 'home/hr/edit', '编辑', 1, 1, '', 2),
(114, 2, 110, 'home/hr/del', '删除', 1, 1, '', 3),
(115, 2, 110, 'home/hr/outxls', '导出', 1, 1, '', 4),
(116, 2, 110, 'home/hr/fenxi', '分析', 1, 1, '', 5),
(117, 2, 110, 'home/hr/birthday', '生日', 1, 1, '', 6),
(118, 2, 110, 'home/hr/sex', '性别', 1, 1, '', 7),
(119, 2, 110, 'home/hr/bumen', '部门', 1, 1, '', 8),
(120, 2, 110, 'home/hr/hunyin', '婚姻', 1, 1, '', 9),
(121, 2, 110, 'home/hr/zhengzhi', '政治', 1, 1, '', 10),
(122, 2, 110, 'home/hr/type', '类型', 1, 1, '', 11),
(123, 2, 110, 'home/hr/zaizhi', '在职', 1, 1, '', 12),
(124, 2, 110, 'home/hr/xueli', '学历', 1, 1, '', 13),
(125, 2, 110, 'home/hr/zhuanye', '专业', 1, 1, '', 14),
(126, 2, 110, 'home/hr/xuewei', '学位', 1, 1, '', 15),
(127, 1, 109, 'home/hrht/index', '人事合同', 1, 1, '', 2),
(128, 2, 127, 'home/hrht/view', '查看', 1, 1, '', 0),
(129, 2, 127, 'home/hrht/add', '新增', 1, 1, '', 1),
(130, 2, 127, 'home/hrht/edit', '编辑', 1, 1, '', 2),
(131, 2, 127, 'home/hrht/del', '删除', 1, 1, '', 3),
(132, 2, 127, 'home/hrht/outxls', '导出', 1, 1, '', 4),
(133, 2, 127, 'home/hrht/daoqi', '到期', 1, 1, '', 5),
(134, 1, 109, 'home/hrjf/index', '奖罚管理', 1, 1, '', 3),
(135, 2, 134, 'home/hrjf/view', '查看', 1, 1, '', 0),
(136, 2, 134, 'home/hrjf/add', '新增', 1, 1, '', 1),
(137, 2, 134, 'home/hrjf/edit', '编辑', 1, 1, '', 2),
(138, 2, 134, 'home/hrjf/del', '删除', 1, 1, '', 3),
(139, 2, 134, 'home/hrjf/outxls', '导出', 1, 1, '', 4),
(140, 1, 109, 'home/hrzz/index', '证照管理', 1, 1, '', 5),
(141, 2, 140, 'home/hrzz/view', '查看', 1, 1, '', 0),
(142, 2, 140, 'home/hrzz/add', '新增', 1, 1, '', 1),
(143, 2, 140, 'home/hzz/edit', '编辑', 1, 1, '', 2),
(144, 2, 140, 'home/hrzz/del', '删除', 1, 1, '', 3),
(145, 2, 140, 'home/hrzz/outxls', '导出', 1, 1, '', 4),
(146, 1, 109, 'home/hrpx/index', '培训管理', 1, 1, '', 7),
(147, 2, 146, 'home/hrpx/view', '查看', 1, 1, '', 0),
(148, 2, 146, 'home/hrpx/add', '新增', 1, 1, '', 1),
(149, 2, 146, 'home/hrpx/edit', '编辑', 1, 1, '', 2),
(150, 2, 146, 'home/hrpx/del', '删除', 1, 1, '', 3),
(151, 1, 109, 'home/hrdd/index', '人事调动', 1, 1, '', 8),
(152, 2, 151, 'home/hrdd/view', '查看', 1, 1, '', 0),
(153, 2, 151, 'home/hrdd/add', '新增', 1, 1, '', 1),
(154, 2, 151, 'home/hrdd/edit', '编辑', 1, 1, '', 2),
(155, 2, 151, 'home/hrdd/del', '删除', 1, 1, '', 3),
(156, 2, 146, 'home/hrpx/outxls', '导出', 1, 1, '', 4),
(157, 2, 151, 'home/hrdd/outxls', '导出', 1, 1, '', 4),
(158, 2, 110, 'home/hr/hukou', '户口', 1, 1, '', 16),
(159, 2, 35, 'home/database/export', '备份', 1, 1, '', 1),
(160, 2, 37, 'home/database/del', '删除', 1, 1, '', 1),
(161, 2, 35, 'home/database/optimize', '优化', 1, 1, '', 2),
(162, 2, 35, 'home/database/repair', '修复', 1, 1, '', 4),
(163, 0, 0, 'home/cust/index', '客户管理', 1, 1, '', 3),
(164, 1, 163, 'home/cust/', '客户信息', 1, 1, '', 1),
(165, 2, 164, 'home/cust/view', '查看', 1, 1, '', 0),
(166, 2, 164, 'home/cust/add', '新增', 1, 1, '', 1),
(167, 2, 164, 'home/cust/edit', '编辑', 1, 1, '', 2),
(168, 2, 164, 'home/cust/del', '删除', 1, 1, '', 3),
(169, 2, 164, 'home/cust/outxls', '导出', 1, 1, '', 4),
(170, 2, 164, 'home/cust/fenxi', '分析', 1, 1, '', 5),
(171, 2, 164, 'home/cust/jinnian', '今年', 1, 1, '', 6),
(172, 2, 164, 'home/cust/qunian', '去年', 1, 1, '', 7),
(173, 2, 164, 'home/cust/fenlei', '进展', 1, 1, '', 8),
(174, 2, 164, 'home/cust/type', '来源', 1, 1, '', 9),
(175, 2, 164, 'home/cust/uname', '添加人', 1, 1, '', 10),
(176, 2, 164, 'home/cust/daoqi', '跟踪', 1, 1, '', 5),
(177, 1, 163, 'home/custcon/index', '联系人', 1, 1, '', 2),
(178, 2, 177, 'home/custcon/view', '查看', 1, 1, '', 0),
(179, 2, 177, 'home/custcon/add', '新增', 1, 1, '', 1),
(180, 2, 177, 'home/custcon/edit', '编辑', 1, 1, '', 2),
(181, 2, 177, 'home/custcon/del', '删除', 1, 1, '', 3),
(182, 2, 177, 'home/custcon/outxls', '导出', 1, 1, '', 4),
(183, 1, 163, 'home/custgd/index', '跟单记录', 1, 1, '', 3),
(184, 2, 183, 'home/custgd/view', '查看', 1, 1, '', 0),
(185, 2, 183, 'home/custgd/add', '新增', 1, 1, '', 1),
(186, 2, 183, 'home/custgd/edit', '编辑', 1, 1, '', 2),
(187, 2, 183, 'home/custgd/del', '删除', 1, 1, '', 3),
(188, 2, 183, 'home/custgd/outxls', '导出', 1, 1, '', 4),
(189, 1, 163, 'home/hetong/index', '合同管理', 1, 1, '', 4),
(190, 2, 189, 'home/hetong/view', '查看', 1, 1, '', 0),
(191, 2, 189, 'home/hetong/add', '新增', 1, 1, '', 1),
(192, 2, 189, 'home/hetong/edit', '编辑', 1, 1, '', 2),
(193, 2, 189, 'home/hetong/del', '删除', 1, 1, '', 3),
(194, 2, 189, 'home/hetong/outxls', '导出', 1, 1, '', 4),
(195, 2, 189, 'home/htfenxi/index', '分析', 1, 1, '', 5),
(196, 2, 189, 'home/htfenxi/', '今年', 1, 1, '', 6),
(197, 2, 189, 'home/htfenxi/lastyear', '去年', 1, 1, '', 8),
(198, 2, 189, 'home/htfenxi/yewuyuan', '业务员', 1, 1, '', 8),
(199, 0, 0, 'home/stock/index', '库存管理', 1, 1, '', 2),
(200, 1, 199, 'home/pro/index', '产品管理', 1, 1, '', 1),
(201, 2, 200, 'home/pro/view', '查看', 1, 1, '', 0),
(202, 2, 200, 'home/pro/add', '新增', 1, 1, '', 1),
(203, 2, 200, 'home/pro/edit', '编辑', 1, 1, '', 2),
(204, 2, 200, 'home/pro/del', '删除', 1, 1, '', 3),
(205, 2, 200, 'home/pro/outxls', '导出', 1, 1, '', 4),
(206, 1, 199, 'home/proin/index', '入库记录', 1, 1, '', 2),
(207, 2, 206, 'home/proin/view', '查看', 1, 1, '', 0),
(208, 2, 206, 'home/proin/add', '新增', 1, 1, '', 1),
(209, 2, 206, 'home/proin/edit', '编辑', 1, 1, '', 2),
(210, 2, 206, 'home/proin/outxls', '导出', 1, 1, '', 4),
(211, 1, 199, 'home/proout/index', '出库记录', 1, 1, '', 3),
(212, 2, 211, 'home/proout/view', '查看', 1, 1, '', 0),
(213, 2, 211, 'home/proout/add', '新增', 1, 1, '', 1),
(214, 2, 211, 'home/proout/edit', '编辑', 1, 1, '', 2),
(215, 2, 211, 'home/proout/outxls', '导出', 1, 1, '', 4),
(216, 1, 199, 'home/stock/', '库存管理', 1, 1, '', 4),
(217, 2, 216, 'home/stock/view', '查看', 1, 1, '', 0),
(218, 2, 216, 'home/stock/outxls', '导出', 1, 1, '', 4),
(219, 2, 216, 'home/stock/baojing', '报警', 1, 1, '', 5),
(220, 1, 163, 'home/huo/index', '发货记录', 1, 1, '', 5),
(221, 2, 220, 'home/huo/view', '查看', 1, 1, '', 0),
(222, 2, 220, 'home/huo/add', '新增', 1, 1, '', 1),
(223, 2, 220, 'home/huo/edit', '编辑', 1, 1, '', 2),
(224, 2, 220, 'home/huo/del', '删除', 1, 1, '', 3),
(225, 2, 220, 'home/huo/outxls', '导出', 1, 1, '', 4),
(226, 0, 0, 'home/shou/index', '财务管理', 1, 1, '', 6),
(227, 1, 226, 'home/shou/', '收款记录', 1, 1, '', 1),
(228, 2, 227, 'home/shou/view', '查看', 1, 1, '', 0),
(229, 2, 227, 'home/shou/add', '新增', 1, 1, '', 1),
(230, 2, 227, 'home/shou/edit', '编辑', 1, 1, '', 2),
(231, 2, 227, 'home/shou/outxls', '导出', 1, 1, '', 4),
(232, 1, 226, 'home/fu/index', '付款记录', 1, 1, '', 2),
(233, 2, 232, 'home/fu/view', '查看', 1, 1, '', 0),
(234, 2, 232, 'home/fu/add', '新增', 1, 1, '', 1),
(235, 2, 232, 'home/fu/edit', '编辑', 1, 1, '', 2),
(236, 2, 232, 'home/fu/outxls', '导出', 1, 1, '', 4),
(237, 1, 226, 'home/piao/index', '开票管理', 1, 1, '', 3),
(238, 2, 237, 'home/piao/view', '查看', 1, 1, '', 0),
(239, 2, 237, 'home/piao/add', '新增', 1, 1, '', 1),
(240, 2, 237, 'home/piao/edit', '编辑', 1, 1, '', 2),
(241, 2, 237, 'home/piao/outxls', '导出', 1, 1, '', 4);

-- --------------------------------------------------------

--
-- 表的结构 `v2_config`
--

CREATE TABLE IF NOT EXISTS `v2_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fenlei` varchar(20) NOT NULL COMMENT '分类',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `addtime` datetime NOT NULL COMMENT '创建时间',
  `updatetime` datetime NOT NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `v2_config`
--

INSERT INTO `v2_config` (`id`, `fenlei`, `name`, `type`, `title`, `extra`, `remark`, `addtime`, `updatetime`, `status`, `value`, `sort`) VALUES
(1, '系统', 'CONFIG_TYPE_LIST', 3, '配置类型列表', '', '主要用于数据解析和页面表单的生成', '2015-02-01 14:39:41', '2015-02-25 10:44:48', 1, '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', 0),
(2, '基础', 'PERPAGE', 0, '每页条数', '', '列表分页条数', '2015-02-01 14:49:47', '2015-02-25 10:44:55', 1, '15', 0),
(3, '基础', 'SEARCHKEY', 3, '参与搜索的字段名', '', '', '2015-02-01 14:56:03', '2015-03-06 15:04:30', 1, '1:name\r\n2:title\r\n3:username\r\n4:value\r\n5:truename\r\n6:tel\r\n7:email\r\n8:qq\r\n9:phone\r\n10:type\r\n11:xingming\r\n12:xueli\r\n13:xuexiao\r\n14:fenlei\r\n15:depname\r\n16:posname\r\n17:dianhua\r\n18:danwei\r\n19:zhiwu\r\n20:uname\r\n21:uuname\r\n22:beizhu\r\n23:zhuangtai\r\n24:bumen\r\n25:zhiwei\r\n26:zhuanye\r\n27:zaizhi\r\n28:jcname\r\n29:juname\r\n30:gonghao', 0),
(4, '系统', 'DATA_CACHE_TIME', 0, '数据缓存时间', '', '数据缓存有效期 0表示永久缓存', '2015-02-01 15:05:20', '2015-02-25 10:44:23', 1, '14400', 0),
(5, '系统', 'SESSION_PREFIXX', 1, 'session 前缀', '', '', '2015-02-01 15:07:09', '2015-02-25 10:44:17', 1, 'lygxykj', 0),
(6, '系统', 'WEB_SITE_TITLE', 2, '系统名称', '', '', '2015-02-01 15:17:46', '2015-02-25 10:44:06', 1, 'V2系统信息化管理平台', 0),
(11, '模型', 'MODEL_B_SHOW', 3, '字段模型表单显示', '', '', '2015-02-01 22:12:54', '2015-02-25 10:43:02', 1, '0:不显示\r\n1:都显示\r\n2:新增显示\r\n3:编辑显示', 0),
(7, '系统', 'DATA_BACKUP_PATH', 1, '数据库备份路径', '', '', '2015-02-01 15:55:43', '2015-02-25 10:43:53', 1, 'data', 0),
(8, '系统', 'DATA_BACKUP_PART_SIZE', 0, '数据库备份卷大小', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '2015-02-01 15:56:41', '2015-02-25 10:44:00', 1, '20971520', 0),
(9, '系统', 'DATA_BACKUP_COMPRESS', 4, '数据库备份文件是否启用压缩', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '2015-02-01 15:57:49', '2015-02-25 10:43:30', 1, '1', 0),
(10, '系统', 'DATA_BACKUP_COMPRESS_LEVEL', 4, '数据库备份文件压缩级别', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '2015-02-01 15:58:48', '2015-02-25 10:43:25', 1, '9', 0),
(12, '模型', 'MODEL_L_SHOW', 3, '字段模型列表显示', '', '', '2015-02-02 14:55:31', '2015-02-25 10:42:53', 1, '0:不显示\r\n1:显示', 0),
(13, '模型', 'MODEL_B_ATTR', 3, '数据模型中表单属性', '', '', '2015-02-02 15:46:08', '2015-02-28 11:40:06', 1, '0:文本框\r\n1:文本域\r\n2:密码框\r\n3:日期框\r\n4:编辑器\r\n5:微调器\r\n6:单选框\r\n7:多选框\r\n8:下拉框\r\n9:查找带回\r\n10:上传附件\r\n11:日期时间框', 0),
(14, '模型', 'MODEL_B_ISMUST', 3, '数据模型中是否必填', '', '', '2015-02-02 16:05:26', '2015-02-28 11:37:48', 1, '0:非必填\r\n1:必填\r\n2:必填日期\r\n3:必填手机号码\r\n4:必填EMAIL\r\n5:必填字母\r\n6:必填身份证号码\r\n7:必填中文\r\n8:必填数字\r\n9:必填日期时间', 0),
(15, '模型', 'MODEL_B_ISSORT', 3, '数据模型中的字段是否参与排序', '', '', '2015-02-02 19:53:07', '2015-02-25 10:42:27', 1, '0:不参与\r\n1:参与', 0),
(16, '基础', 'BASE_SEX', 3, '性别', '', '', '2015-02-02 21:21:58', '2015-02-25 10:28:07', 1, '0:男\r\n1:女', 0),
(17, '基础', 'BASE_XUELI', 3, '学历', '', '', '2015-02-02 21:23:26', '2015-02-25 10:28:01', 1, '0:中专\r\n1:大专\r\n2:本科\r\n3:硕士\r\n4:博士', 0),
(18, '基础', 'CONFIG_CLASS', 3, '配置分类', '', '', '2015-02-25 10:22:21', '2015-03-06 09:45:11', 1, '0:系统\r\n1:基础\r\n2:模型\r\n3:个人\r\n4:人事管理\r\n5:客户管理\r\n6:库存管理\r\n7:财务管理', 0),
(19, '个人', 'BASE_SHUXING', 3, '属性', '', '通讯录属性', '2015-02-26 15:30:42', '2015-02-27 09:42:38', 1, '私有\r\n公共', 0),
(20, '个人', 'TASK_STATUS', 3, '任务状态', '', '任务管理中的状态', '2015-02-28 12:24:20', '2015-02-28 12:24:41', 1, '0:进行中\r\n1:已完成', 0),
(21, '个人', 'REPORT_TYPE', 3, '工作汇报类型', '', '', '2015-02-28 16:00:03', '0000-00-00 00:00:00', 1, '日总结\r\n周总结\r\n月总结\r\n年总结\r\n其他', 0),
(22, '人事管理', 'HR_HUNYIN', 3, '婚姻状况', '', '', '2015-02-28 20:43:51', '0000-00-00 00:00:00', 1, '未婚\r\n已婚\r\n离异\r\n丧偶', 0),
(23, '人事管理', 'HR_ZHENGZHI', 3, '政治面貌', '', '', '2015-02-28 20:50:09', '0000-00-00 00:00:00', 1, '群众\r\n共青团员\r\n预备党员\r\n党员\r\n民主党派', 0),
(24, '人事管理', 'HR_HUKOU', 3, '户口类别', '', '', '2015-02-28 20:53:21', '0000-00-00 00:00:00', 1, '本地城镇居民\r\n外埠城镇居民\r\n本地农村户口\r\n外地农村户口', 0),
(25, '人事管理', 'HR_TYPE', 3, '员工类型', '', '', '2015-02-28 21:08:16', '0000-00-00 00:00:00', 1, '正式员工\r\n合同工\r\n临时工', 0),
(26, '人事管理', 'HR_ZAIZHI', 3, '在职状态', '', '', '2015-02-28 21:11:25', '0000-00-00 00:00:00', 1, '在职\r\n离职\r\n借调\r\n离休\r\n退休', 0),
(27, '人事管理', 'HR_XUEWEI', 3, '学位', '', '', '2015-02-28 21:15:46', '2015-02-28 21:30:14', 1, '其他\r\n学士\r\n硕士\r\n博士', 0),
(28, '人事管理', 'HRHT_TYPE', 3, '人事合同类型', '', '', '2015-03-01 12:56:36', '0000-00-00 00:00:00', 1, '劳务合同\r\n保密合同\r\n其他', 0),
(29, '人事管理', 'HRJF_TYPE', 3, '奖罚项目', '', '', '2015-03-01 15:50:35', '0000-00-00 00:00:00', 1, '奖励\r\n惩罚', 0),
(30, '人事管理', 'HRZZ_TYPE', 3, '证照类型', '', '', '2015-03-01 17:49:50', '0000-00-00 00:00:00', 1, '身份证\r\n驾驶证\r\n技能证\r\n健康证\r\n其他', 0),
(31, '人事管理', 'HRDD_TYPE', 3, '调动类型', '', '', '2015-03-01 20:21:25', '0000-00-00 00:00:00', 1, '晋升\r\n调动\r\n降级\r\n其他', 0),
(32, '人事管理', 'HRGH_TYPE', 3, '关怀类型', '', '', '2015-03-01 20:42:08', '0000-00-00 00:00:00', 1, '其他\r\n节日\r\n生日\r\n祝福\r\n庆祝', 0),
(33, '个人', 'ZHISHI_TYPE', 3, '知识分类', '', '', '2015-03-03 12:33:37', '2015-03-03 12:39:23', 1, '产品知识\r\n技术知识\r\n营销知识\r\n质量知识\r\n培训资料\r\n管理知识\r\n其他知识', 0),
(34, '客户管理', 'CUST_TYPE', 3, '客户来源', '', '', '2015-03-03 21:44:04', '0000-00-00 00:00:00', 1, '百度推广\r\n电话营销\r\n主动联系\r\n客户介绍', 0),
(35, '客户管理', 'CUSTGD_TYPE', 3, '联系方式', '', '', '2015-03-04 11:18:41', '0000-00-00 00:00:00', 1, '电话\r\nQQ\r\n电子邮箱\r\n上门拜访', 0),
(36, '客户管理', 'CUSTGD_FENLEI', 3, '进展阶段', '', '', '2015-03-04 11:22:02', '0000-00-00 00:00:00', 1, '需求整理\r\n选择比较\r\n购买决定\r\n成交客户\r\n他人签单', 0),
(37, '库存管理', 'PRO_TYPE', 3, '计量单位', '', '', '2015-03-04 20:47:13', '2015-03-06 10:00:57', 1, '台\r\n个\r\n套\r\n只', 0),
(38, '模型', 'MODEL_F_TYPE', 3, '图表类型', '', '', '2015-03-06 14:16:26', '0000-00-00 00:00:00', 1, '0:不生成\r\n1:3D饼图\r\n2:柱状图\r\n3:曲线图\r\n4:环状图\r\n5:柱商务图', 0);

-- --------------------------------------------------------

--
-- 表的结构 `v2_contact`
--

CREATE TABLE IF NOT EXISTS `v2_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xingming` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `danwei` varchar(50) NOT NULL,
  `zhiwu` varchar(20) NOT NULL,
  `dianhua` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `shuxing` varchar(20) NOT NULL,
  `beizhu` text NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1',
  `qq` varchar(50) NOT NULL,
  `fenlei` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='通讯录' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `v2_contact`
--

INSERT INTO `v2_contact` (`id`, `xingming`, `sex`, `danwei`, `zhiwu`, `dianhua`, `phone`, `email`, `shuxing`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `qq`, `fenlei`) VALUES
(1, '王东省', '男', '未发生的小故事', '的冯绍峰', '5152451512', '1461381212', '12@fgss.co', '公共', 'fsdjlf dsjfds非金属大量发生发神经了范德萨发生的进口量发s发生的好了丰盛的放暑假了发生的几率经过了卡斯尽快发了多少教师节快乐股份吉萨看了经过了卡机了高科技洛克剧场想那么难受了农家乐机关垃圾发过来看电视剧联盟恼羞成怒，没那个了开始的年纪那些年快乐购房缴纳那个谁老年卡拉克那个按了那个谁可能刚分手可能过了时间告诉了当年噶尽量客观那算了那旮旯尼古拉可能\r\n发生的家乐福稍等\r\n很浪费时间个联系可能刚开始电脑x\r\n分公司答复', 1, '陈高明', '2015-02-26 20:18:45', 1, '陈高明', '2015-03-02 12:35:10', 1, '1212121212', '业务往来'),
(2, '孙菲菲', '女', '范德萨发顺丰', '范德萨', '1545121321', '2121512', '121121@品客.com', '私有', '范德萨范德萨 ', 1, '陈高明', '2015-02-27 11:33:00', 0, '', '0000-00-00 00:00:00', 1, '1251022', '常用'),
(3, '王海军', '男', '范德萨发的说法', '范德萨', '451213451', '212313212', '12121213', '公共', '放水电费水电费撒发生ffsd发a\r\n发生范德萨', 2, '高明', '2015-02-27 11:47:36', 0, '', '0000-00-00 00:00:00', 1, '12', '快递');

-- --------------------------------------------------------

--
-- 表的结构 `v2_cust`
--

CREATE TABLE IF NOT EXISTS `v2_cust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xingming` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `beizhu` varchar(200) NOT NULL,
  `title` varchar(50) NOT NULL,
  `dizhi` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `qq` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `bumen` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `juid` varchar(1000) NOT NULL,
  `juname` varchar(1000) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `fenlei` varchar(20) NOT NULL,
  `xcrq` date NOT NULL,
  `addm` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='客户管理' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `v2_cust`
--

INSERT INTO `v2_cust` (`id`, `xingming`, `phone`, `addtime`, `updatetime`, `status`, `beizhu`, `title`, `dizhi`, `email`, `qq`, `sex`, `bumen`, `type`, `name`, `juid`, `juname`, `uid`, `uname`, `uuid`, `uuname`, `fenlei`, `xcrq`, `addm`) VALUES
(1, '陈高明', '13812349563', '2015-03-04 11:57:31', '2015-03-07 14:42:12', 1, '1221', '连云港信友科技有限公司', '江苏省连云港市', 'pinkecn@qq.com', '16129825', '男', '经理', '主动联系', '', '3', '王冬冬', 1, '陈高明', 2, '李洁霞', '成交客户', '0000-00-00', '2015-03'),
(2, '汪东兴', '13822121251', '2015-03-06 16:15:21', '2015-03-06 16:35:21', 1, '', '百度公司', '北京市', '', '', '男', '经理', '电话营销', '', '2,1', '李洁霞,陈高明', 1, '陈高明', 1, '陈高明', '暂未联系', '0000-00-00', '2015-03'),
(3, '王旭东', '135555511', '2015-02-01 16:43:11', '2015-03-06 20:26:22', 1, '', '腾讯公司', '深圳', '', '', '女', '', '主动联系', '', '3,2', '王冬冬,李洁霞', 1, '陈高明', 0, '', '成交客户', '2015-03-18', '2015-02');

-- --------------------------------------------------------

--
-- 表的结构 `v2_custcon`
--

CREATE TABLE IF NOT EXISTS `v2_custcon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xingming` varchar(50) NOT NULL,
  `jcid` int(11) NOT NULL,
  `jcname` varchar(200) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `bumen` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `qq` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `beizhu` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='联系人' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_custcon`
--

INSERT INTO `v2_custcon` (`id`, `xingming`, `jcid`, `jcname`, `sex`, `bumen`, `phone`, `email`, `qq`, `name`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, '王德林', 1, '连云港信友科技有限公司', '男', '项目负责人', '13812345262', 'pinkecn!@q.com', '151212', '', 'fsdfds', 1, '陈高明', '2015-03-04 10:58:57', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_custgd`
--

CREATE TABLE IF NOT EXISTS `v2_custgd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jcid` int(11) NOT NULL,
  `jcname` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `fenlei` varchar(20) NOT NULL,
  `xcrq` date NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='跟单记录' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `v2_custgd`
--

INSERT INTO `v2_custgd` (`id`, `jcid`, `jcname`, `type`, `fenlei`, `xcrq`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `value`) VALUES
(1, 1, '连云港信友科技有限公司', '电话', '选择比较', '2015-03-18', 1, '陈高明', '2015-03-04 11:43:26', 1, '陈高明', '2015-03-04 12:12:27', 1, '正在对比'),
(2, 1, '连云港信友科技有限公司', '上门拜访', '购买决定', '2015-03-19', 1, '陈高明', '2015-03-04 11:46:24', 0, '', '0000-00-00 00:00:00', 1, '差不多了'),
(3, 1, '连云港信友科技有限公司', '上门拜访', '成交客户', '0000-00-00', 1, '陈高明', '2015-03-04 12:14:45', 1, '陈高明', '2015-03-04 12:29:53', 1, '搞定了'),
(4, 3, '腾讯公司', '上门拜访', '成交客户', '2015-03-18', 1, '陈高明', '2015-03-06 20:26:22', 0, '', '0000-00-00 00:00:00', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `v2_doc`
--

CREATE TABLE IF NOT EXISTS `v2_doc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `fenlei` varchar(20) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `juid` varchar(1000) NOT NULL,
  `juname` varchar(1000) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我的文档' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_doc`
--

INSERT INTO `v2_doc` (`id`, `title`, `fenlei`, `beizhu`, `attid`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, '营业执照', '公司证件', '&lt;p&gt;\r\n	2015年新版营业执照\r\n&lt;/p&gt;', 1425355425, '', '', 1, '陈高明', '2015-03-03 12:05:32', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_files`
--

CREATE TABLE IF NOT EXISTS `v2_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attid` int(11) NOT NULL,
  `folder` varchar(50) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `filetype` varchar(50) NOT NULL,
  `filedesc` varchar(200) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `v2_files`
--

INSERT INTO `v2_files` (`id`, `attid`, `folder`, `filename`, `filetype`, `filedesc`, `uid`, `addtime`, `status`) VALUES
(13, 1425098978, 'Uploads/Public/2015-02-28/', '54f14a7a3e337.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-28 12:56:26', 1),
(14, 1425098978, 'Uploads/Public/2015-02-28/', '54f14ee44249d.pdf', 'pdf', '个人信用报告.pdf', '1', '2015-02-28 13:15:16', 1),
(12, 1425045333, 'Uploads/Public/2015-02-27/', '54f011e1e3141.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-27 14:42:41', 1),
(15, 1425101764, 'Uploads/Public/2015-02-28/', '54f153f339efa.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-28 13:36:51', 1),
(16, 1425131004, 'Uploads/Public/2015-02-28/', '54f1c9cd5bc18.pdf', 'pdf', '个人信用报告.pdf', '1', '2015-02-28 21:59:41', 1),
(17, 1425279910, 'Uploads/Public/2015-03-02/', '54f40d05a1d47.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-02 15:11:01', 1),
(18, 1425355425, 'Uploads/Public/2015-03-03/', '54f53309dc338.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-03 12:05:29', 1),
(19, 1425799502, 'Uploads/Public/2015-03-10/', '54fe8f5edec94.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-10 14:29:50', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_fu`
--

CREATE TABLE IF NOT EXISTS `v2_fu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addm` varchar(20) NOT NULL,
  `jhid` int(11) NOT NULL,
  `jhname` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `fenlei` varchar(50) NOT NULL,
  `bianhao` varchar(50) NOT NULL,
  `jine` int(11) NOT NULL,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `beizhu` varchar(200) NOT NULL,
  `uid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `attid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='付款记录' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `v2_fu`
--

INSERT INTO `v2_fu` (`id`, `addm`, `jhid`, `jhname`, `type`, `fenlei`, `bianhao`, `jine`, `juid`, `juname`, `beizhu`, `uid`, `uuname`, `uname`, `addtime`, `uuid`, `updatetime`, `status`, `attid`) VALUES
(1, '2015-03', 4, '长绒棉销售', '现金', '差旅费', '10021', 500, 3, '王冬冬', '出差报销', 1, '陈高明', '陈高明', '2015-03-08 12:24:40', 1, '2015-03-08 15:14:42', 1, 0),
(2, '2015-03', 4, '长绒棉销售', '公司账号转账', '办公费', '1000', 200, 3, '王冬冬', '111', 1, '陈高明', '陈高明', '2015-03-08 12:38:00', 1, '2015-03-08 15:14:34', 1, 0),
(3, '2015-03', 4, '长绒棉销售', '现金', '货款', '1022', 100, 3, '王冬冬', '12233', 1, '陈高明', '陈高明', '2015-03-08 12:41:07', 1, '2015-03-08 15:14:15', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hetong`
--

CREATE TABLE IF NOT EXISTS `v2_hetong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bianhao` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `jcid` int(11) NOT NULL,
  `jcname` varchar(200) NOT NULL,
  `xingming` varchar(50) NOT NULL,
  `dianhua` varchar(50) NOT NULL,
  `jine` int(11) NOT NULL,
  `yishou` int(11) NOT NULL,
  `weishou` int(11) NOT NULL,
  `yikai` int(11) NOT NULL,
  `fukuan` int(11) NOT NULL,
  `dqrq` date NOT NULL,
  `name` varchar(50) NOT NULL,
  `juid` varchar(1000) NOT NULL,
  `juname` varchar(1000) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `addm` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='合同管理' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `v2_hetong`
--

INSERT INTO `v2_hetong` (`id`, `bianhao`, `title`, `jcid`, `jcname`, `xingming`, `dianhua`, `jine`, `yishou`, `weishou`, `yikai`, `fukuan`, `dqrq`, `name`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `beizhu`, `attid`, `addm`, `status`) VALUES
(1, '2015030801', '网络服务费', 1, '连云港信友科技有限公司', '王晓丹', '1382532612', 20000, 0, 0, 0, 0, '2015-02-18', '汪东兴', '3,2,1', '王冬冬,李洁霞,陈高明', 1, '陈高明', '2015-02-01 16:44:35', 2, '李洁霞', '2015-03-08 10:22:20', '', 1422780234, '2015-01', 1),
(2, '2002', '网络服务', 1, '连云港信友科技有限公司', '王晓丹', '1382256223', 15620, 0, 0, 0, 0, '2015-04-16', '陈高明', '', '', 1, '陈高明', '2015-02-01 16:45:34', 1, '陈高明', '2015-03-07 17:16:02', '', 1422780295, '2015-01', 1),
(3, '', '', 3, '腾讯公司', '', '', 30150, 0, 0, 0, 0, '2015-05-06', '陈高明', '', '', 1, '陈高明', '2015-03-06 16:46:43', 1, '陈高明', '2015-03-06 17:18:58', '1212', 1425631574, '2015-03', 1),
(4, '2015030812', '长绒棉销售', 1, '连云港信友科技有限公司', '陈高明', '13812349563', 15000, 15000, 0, 15000, 800, '2015-04-30', '汪东兴', '2', '李洁霞', 1, '陈高明', '2015-03-08 10:45:14', 1, '陈高明', '2015-03-08 10:45:23', '方法个', 1425782628, '2015-03', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hr`
--

CREATE TABLE IF NOT EXISTS `v2_hr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xingming` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `shengri` date NOT NULL,
  `xuexiao` varchar(100) NOT NULL,
  `xueli` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `jiadizhi` varchar(255) NOT NULL,
  `beizhu` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `updatetime` datetime NOT NULL,
  `uid` int(11) NOT NULL,
  `gonghao` varchar(50) NOT NULL,
  `bumen` varchar(50) NOT NULL,
  `zhiwei` varchar(50) NOT NULL,
  `shenfenzheng` varchar(20) NOT NULL,
  `jiankang` varchar(50) NOT NULL,
  `hunyin` varchar(20) NOT NULL,
  `minzu` varchar(20) NOT NULL,
  `jiguan` varchar(50) NOT NULL,
  `zhengzhi` varchar(50) NOT NULL,
  `rudang` date NOT NULL,
  `hukou` varchar(20) NOT NULL,
  `hukoudi` varchar(200) NOT NULL,
  `jiadianhua` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `ruzhi` date NOT NULL,
  `zaizhi` varchar(20) NOT NULL,
  `lizhi` date NOT NULL,
  `biye` date NOT NULL,
  `xuewei` varchar(20) NOT NULL,
  `zhuanye` varchar(20) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `shehui` text NOT NULL,
  `xuexi` text NOT NULL,
  `gongzuo` text NOT NULL,
  `jineng` text NOT NULL,
  `attid` int(11) NOT NULL,
  `birthday` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='员工档案' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `v2_hr`
--

INSERT INTO `v2_hr` (`id`, `xingming`, `sex`, `shengri`, `xuexiao`, `xueli`, `addtime`, `jiadizhi`, `beizhu`, `status`, `updatetime`, `uid`, `gonghao`, `bumen`, `zhiwei`, `shenfenzheng`, `jiankang`, `hunyin`, `minzu`, `jiguan`, `zhengzhi`, `rudang`, `hukou`, `hukoudi`, `jiadianhua`, `type`, `ruzhi`, `zaizhi`, `lizhi`, `biye`, `xuewei`, `zhuanye`, `uname`, `uuid`, `uuname`, `shehui`, `xuexi`, `gongzuo`, `jineng`, `attid`, `birthday`) VALUES
(1, '陈高明', '男', '1982-02-01', '北化大学', '本科', '2015-02-28 21:46:41', '连云港市灌南县', '&lt;p&gt;\r\n	补充\r\n&lt;/p&gt;', 1, '2015-03-06 12:25:11', 1, '1001', '综合办公室', '总经理', '320821198202013562', '健康', '已婚', '汉族', '江苏省灌南县', '群众', '0000-00-00', '本地城镇居民', '连云港市海州区', '0518526525', '正式员工', '2007-01-01', '在职', '0000-00-00', '2004-07-01', '学士', '工商管理', '陈高明', 1, '陈高明', '', '北华大学', '工作经', '什么都会一点', 1425131004, '02'),
(2, '汪东兴', '男', '1987-03-04', '', '本科', '2015-03-01 16:10:54', '', '', 1, '2015-03-06 12:07:17', 1, '1003', '综合办公室', '办公室主任', '320822198202013030', '健康', '未婚', '汉族', '江苏省连云港市', '群众', '2015-03-01', '本地城镇居民', '', '', '正式员工', '2014-03-01', '在职', '0000-00-00', '0000-00-00', '学士', '行政管理', '陈高明', 1, '陈高明', '', '', '', '', 1425197393, '03'),
(3, '王晓丹', '女', '2015-02-06', '', '硕士', '2015-03-06 16:00:43', '', '', 1, '2015-03-06 16:01:20', 1, '1005', '财务部', '会计', '32082219252323', '健康', '未婚', '', '', '党员', '2015-03-06', '本地城镇居民', '', '', '正式员工', '0000-00-00', '在职', '0000-00-00', '2015-03-06', '硕士', '工商管理', '陈高明', 1, '陈高明', '', '', '', '', 1425628757, '');

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrdd`
--

CREATE TABLE IF NOT EXISTS `v2_hrdd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `ddrq` date NOT NULL,
  `sxrq` date NOT NULL,
  `bumen` varchar(50) NOT NULL,
  `hbumen` varchar(50) NOT NULL,
  `zhiwei` varchar(50) NOT NULL,
  `hzhiwei` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='人事调动' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_hrdd`
--

INSERT INTO `v2_hrdd` (`id`, `juid`, `juname`, `title`, `type`, `ddrq`, `sxrq`, `bumen`, `hbumen`, `zhiwei`, `hzhiwei`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '汪东兴', '升职啦', '晋升', '2015-03-01', '2015-03-01', '', '', '科员', '办公室主任', '发的', 1425213031, 1, '陈高明', '2015-03-01 20:31:30', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrgh`
--

CREATE TABLE IF NOT EXISTS `v2_hrgh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sj` date NOT NULL,
  `feiyong` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='员工关怀' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_hrgh`
--

INSERT INTO `v2_hrgh` (`id`, `juid`, `juname`, `title`, `type`, `sj`, `feiyong`, `name`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '汪东兴', '春节送红包', '节日', '2015-02-18', '500', '很好啊', '多发点', 1425214124, 1, '陈高明', '2015-03-01 20:49:18', 1, '陈高明', '2015-03-02 11:28:29', 1),
(2, 1, '陈高明', '生日礼品', '生日', '2015-03-02', '500', '很哈哦', '地方', 1425266572, 1, '陈高明', '2015-03-02 11:23:21', 1, '陈高明', '2015-03-02 11:23:21', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrht`
--

CREATE TABLE IF NOT EXISTS `v2_hrht` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `bianhao` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `kssj` date NOT NULL,
  `jsrj` date NOT NULL,
  `jcrq` date NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='人事合同' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_hrht`
--

INSERT INTO `v2_hrht` (`id`, `juid`, `juname`, `title`, `bianhao`, `type`, `kssj`, `jsrj`, `jcrq`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 1, '陈高明', '2015-2018年劳动合同', '201020100', '劳务合同', '2015-03-01', '2015-03-05', '0000-00-00', '合同见附件', 1425186778, 1, '陈高明', '2015-03-01 13:13:37', 1, '陈高明', '2015-03-06 12:36:32', 1),
(2, 2, '汪东兴', '2015-2018年劳动合同', '20002111', '劳务合同', '2015-03-02', '2018-03-03', '0000-00-00', '合同内容', 1425267063, 1, '陈高明', '2015-03-02 11:31:40', 1, '陈高明', '2015-03-02 11:32:04', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrjf`
--

CREATE TABLE IF NOT EXISTS `v2_hrjf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `sxrq` date NOT NULL,
  `jine` varchar(20) NOT NULL,
  `gongzi` date NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='奖罚管理' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_hrjf`
--

INSERT INTO `v2_hrjf` (`id`, `juid`, `juname`, `type`, `title`, `sxrq`, `jine`, `gongzi`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 1, '陈高明', '奖励', '工作认证，加工资', '2015-03-01', '2000', '2015-03-01', '工作认证，加工资', 1425196856, 1, '陈高明', '2015-03-01 16:01:37', 0, '', '0000-00-00 00:00:00', 1),
(2, 1, '陈高明', '奖励', '工作满一年，涨工资', '2015-03-01', '500', '2015-03-01', '&lt;strong&gt;工作满一年，涨工资&lt;/strong&gt;', 1425197524, 1, '陈高明', '2015-03-01 16:12:32', 2, '李洁霞', '2015-03-10 10:26:34', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrpx`
--

CREATE TABLE IF NOT EXISTS `v2_hrpx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `feiyong` varchar(20) NOT NULL,
  `kssj` date NOT NULL,
  `jssj` date NOT NULL,
  `zhengshu` varchar(50) NOT NULL,
  `didian` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='培训管理' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_hrpx`
--

INSERT INTO `v2_hrpx` (`id`, `juid`, `juname`, `title`, `feiyong`, `kssj`, `jssj`, `zhengshu`, `didian`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '汪东兴', '计算机安全员', '2000', '2015-03-01', '2015-03-18', '计算机安全员二级证书', '南京', '发的说法', 1425211748, 1, '陈高明', '2015-03-01 20:10:02', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_hrzz`
--

CREATE TABLE IF NOT EXISTS `v2_hrzz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `bianhao` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `sxrq` date NOT NULL,
  `jsrq` date NOT NULL,
  `qzrq` date NOT NULL,
  `danwei` varchar(200) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='证照管理' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_hrzz`
--

INSERT INTO `v2_hrzz` (`id`, `juid`, `juname`, `title`, `bianhao`, `type`, `sxrq`, `jsrq`, `qzrq`, `danwei`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '汪东兴', '驾驶证', '10202020', '驾驶证', '2015-03-01', '2015-03-01', '2015-03-01', '', '发斯蒂芬', 1425203786, 1, '陈高明', '2015-03-01 17:56:55', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_huo`
--

CREATE TABLE IF NOT EXISTS `v2_huo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jhid` int(11) NOT NULL,
  `jhname` varchar(100) NOT NULL,
  `title` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='发货记录' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_huo`
--

INSERT INTO `v2_huo` (`id`, `jhid`, `jhname`, `title`, `name`, `juid`, `juname`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 4, '长绒棉销售', '发票快递', '申通快递5262212212', 3, '王冬冬', '发的说法', 1, '陈高明', '2015-03-08 14:47:56', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_info`
--

CREATE TABLE IF NOT EXISTS `v2_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` varchar(1000) NOT NULL,
  `juname` varchar(1000) NOT NULL,
  `title` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `attid` int(11) NOT NULL,
  `hui` text NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `jzrq` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='通知公告' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_info`
--

INSERT INTO `v2_info` (`id`, `juid`, `juname`, `title`, `value`, `attid`, `hui`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `jzrq`) VALUES
(1, '1,3,2', '陈高明,王冬冬,李洁霞', '3.8活动3.8活动3.8活动3.8活动3.8活动3.8活动', '3.8活动', 1425283352, '\r\n陈高明:支持！2015-03-02 16:03:53\r\n李洁霞:2015-03-10 10:25:29', 1, '陈高明', '2015-03-02 16:03:02', 2, '李洁霞', '2015-03-10 10:25:29', 1, '2015-03-08'),
(2, '4,3,2,1', '王晓丹,王冬冬,李洁霞,陈高明', '客户回访工作安排', '客户回访工作安排', 1426477450, '', 1, '陈高明', '2015-03-16 11:44:47', 0, '', '0000-00-00 00:00:00', 1, '2015-03-18');

-- --------------------------------------------------------

--
-- 表的结构 `v2_log`
--

CREATE TABLE IF NOT EXISTS `v2_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `username` char(20) NOT NULL,
  `content` char(100) NOT NULL,
  `os` varchar(300) NOT NULL,
  `url` char(100) NOT NULL,
  `ip` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `v2_menu`
--

CREATE TABLE IF NOT EXISTS `v2_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` tinyint(1) NOT NULL,
  `pid` int(4) NOT NULL,
  `catename` char(20) NOT NULL DEFAULT '',
  `alink` char(100) NOT NULL DEFAULT '',
  `sort` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=74 ;

--
-- 转存表中的数据 `v2_menu`
--

INSERT INTO `v2_menu` (`id`, `level`, `pid`, `catename`, `alink`, `sort`, `status`) VALUES
(1, 0, 0, '库存管理', 'stock/index', 2, 1),
(2, 0, 0, '个人办公', 'office/index', 0, 1),
(3, 0, 0, '客户管理', 'Cust/index', 3, 1),
(4, 0, 0, '人事管理', 'hr/index', 4, 1),
(8, 1, 2, '我的任务', 'mytask/index', 1, 1),
(7, 0, 0, '系统管理', 'system/index', 99, 1),
(9, 1, 7, '组织机构', 'org/index', 1, 1),
(10, 2, 9, '职位管理', 'dep/index', 2, 1),
(11, 2, 22, '菜单管理', 'menu/index', 4, 1),
(12, 1, 2, '我的去向', 'mygo/index', 0, 1),
(13, 1, 7, '操作日志', 'Log/index', 7, 1),
(14, 2, 9, '用户管理', 'user/index', 3, 1),
(21, 1, 7, '备份文件', 'database/bakup', 5, 1),
(20, 2, 22, '数据模型', 'model/index', 3, 1),
(19, 2, 22, '功能列表', 'rule/index', 5, 1),
(22, 1, 7, '系统设置', 'system/index', 1, 1),
(23, 2, 9, '部门管理', 'org/index', 0, 1),
(24, 1, 7, '数据备份', 'Database/index', 4, 1),
(25, 1, 1, '产品信息', 'pro/index', 1, 1),
(26, 1, 1, '库存管理', 'stock/index', 5, 1),
(27, 1, 2, '通讯录', 'contact/index', 9, 1),
(28, 1, 2, '指派任务', 'task/index', 1, 1),
(29, 2, 27, '我的通讯录', 'contact/index', 1, 1),
(30, 2, 27, '公共通讯录', 'pcontact/index', 2, 1),
(31, 2, 22, '数据字典', 'config/index', 1, 1),
(32, 1, 1, '出库记录', 'proout/index', 3, 1),
(33, 1, 2, '员工去向', 'mygos/index', 0, 1),
(34, 1, 2, '我的工作汇报', 'myreport/index', 2, 1),
(35, 1, 4, '员工档案', 'hr/index', 1, 1),
(36, 1, 4, '人事合同', 'hrht/index', 2, 1),
(37, 1, 4, '奖罚管理', 'hrjf/index', 3, 1),
(38, 1, 4, '证照管理', 'hrzz/index', 4, 1),
(39, 1, 4, '培训管理', 'hrpx/index', 5, 1),
(40, 1, 2, '通知公告', 'info/index', 8, 1),
(41, 2, 40, '发通知', 'info/index', 1, 1),
(42, 2, 40, '收通知', 'myinfo/index', 2, 1),
(43, 1, 4, '人事调动', 'hrdd/index', 8, 1),
(44, 1, 2, '我的文档', 'doc/index', 5, 1),
(45, 1, 3, '合同管理', 'hetong/index', 4, 1),
(46, 2, 27, '公司通讯录', 'ccontact/index', 3, 1),
(47, 1, 2, '知识管理', 'zhishi/index', 5, 1),
(48, 1, 4, '员工关怀', 'hrgh/index', 10, 1),
(49, 1, 3, '客户信息', 'cust/index', 1, 1),
(50, 1, 3, '联系人', 'custcon/index', 2, 1),
(51, 1, 3, '跟单记录', 'custgd/index', 3, 1),
(52, 1, 2, '批注工作汇报', 'report/index', 2, 1),
(53, 1, 4, '统计分析', 'hr/index', 20, 1),
(54, 2, 53, '本月下月生日', 'hr/birthday', 0, 1),
(55, 2, 53, '即将到期的合同', 'hrht/daoqi', 2, 1),
(56, 2, 53, '员工分析', 'hr/fenxi', 3, 1),
(57, 1, 3, '统计分析', 'cust/index', 10, 1),
(58, 2, 57, '客户分析', 'cust/fenxi', 1, 1),
(59, 2, 57, '今年合同增长趋势', 'htfenxi/index', 2, 1),
(60, 2, 57, '即将到期的合同', 'hetong/daoqi', 7, 1),
(61, 2, 57, '需要跟踪的客户', 'cust/daoqi', 10, 1),
(62, 1, 1, '入库记录', 'proin/index', 2, 1),
(63, 1, 1, '库存报警', 'stock/baojing', 5, 1),
(64, 1, 3, '收款记录', 'shou/index', 5, 1),
(65, 1, 3, '付款记录', 'fu/index', 6, 1),
(66, 0, 0, '财务管理', 'shou/index', 5, 1),
(67, 1, 66, '收款记录', 'shou/index', 1, 1),
(68, 1, 66, '付款记录', 'fu/index', 2, 1),
(69, 1, 3, '开票记录', 'piao/index', 7, 1),
(70, 1, 3, '发货记录', 'huo/index', 8, 1),
(71, 1, 66, '开票记录', 'piao/index', 3, 1),
(72, 2, 57, '去年合同增长趋势', 'htfenxi/lastyear', 5, 1),
(73, 2, 57, '业务员分析', 'htfenxi/yewuyuan', 4, 1);

-- --------------------------------------------------------

--
-- 表的结构 `v2_mygo`
--

CREATE TABLE IF NOT EXISTS `v2_mygo` (
  `jssj` datetime NOT NULL,
  `kssj` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `bumen` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我的去向' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `v2_mygo`
--

INSERT INTO `v2_mygo` (`jssj`, `kssj`, `id`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `bumen`) VALUES
('2015-02-28 18:00:00', '2015-02-28 14:00:00', 1, '去海州开发区拜访客户，大家有事直接打我电话哦！谢谢啊尽快在下午之前回来,', 1, '陈高明', '2015-02-27 20:56:12', 1, '陈高明', '2015-02-28 15:20:05', 1, '综合办公室'),
('2015-03-09 17:04:54', '2015-03-09 11:04:49', 2, '去采购办公用品', 4, '王晓丹', '2015-03-09 11:04:20', 0, '', '0000-00-00 00:00:00', 1, '市场部'),
('2015-03-10 11:50:37', '2015-03-09 11:50:29', 3, '去拜访客户', 1, '陈高明', '2015-03-09 11:49:59', 0, '', '0000-00-00 00:00:00', 1, '综合办公室'),
('2015-03-09 11:53:32', '2015-03-09 11:53:30', 4, '去采购配件', 2, '李洁霞', '2015-03-09 11:52:48', 2, '李洁霞', '2015-03-09 12:00:45', 1, '综合办公室'),
('2015-03-11 12:15:58', '2015-03-09 12:15:55', 5, '外地出差', 2, '李洁霞', '2015-03-09 12:13:08', 0, '', '0000-00-00 00:00:00', 1, '综合办公室');

-- --------------------------------------------------------

--
-- 表的结构 `v2_piao`
--

CREATE TABLE IF NOT EXISTS `v2_piao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jhid` int(11) NOT NULL,
  `jhname` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `jine` int(11) NOT NULL,
  `bianhao` varchar(50) NOT NULL,
  `beizhu` varchar(200) NOT NULL,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `addm` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='开票记录' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_piao`
--

INSERT INTO `v2_piao` (`id`, `jhid`, `jhname`, `title`, `jine`, `bianhao`, `beizhu`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `addm`) VALUES
(2, 4, '长绒棉销售', '连云港信友科技有限公司', 15000, '152252', '152622', 3, '王冬冬', 1, '陈高明', '2015-03-08 13:07:46', 0, '', '0000-00-00 00:00:00', 1, '2015-03');

-- --------------------------------------------------------

--
-- 表的结构 `v2_pro`
--

CREATE TABLE IF NOT EXISTS `v2_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `fenlei` varchar(20) NOT NULL,
  `jiage` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `beizhu` text NOT NULL,
  `sjiage` int(11) NOT NULL,
  `kucun` int(11) NOT NULL,
  `ruku` int(11) NOT NULL,
  `chuku` int(11) NOT NULL,
  `tuiku` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='产品管理' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_pro`
--

INSERT INTO `v2_pro` (`id`, `name`, `fenlei`, `jiage`, `type`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `beizhu`, `sjiage`, `kucun`, `ruku`, `chuku`, `tuiku`) VALUES
(1, '打印纸', '办公用品', 95, '只', '10包/箱', 1, '陈高明', '2015-03-07 15:39:21', 0, '', '0000-00-00 00:00:00', 1, '&lt;p&gt;\r\n	调动\r\n&lt;/p&gt;', 0, 150, 150, 0, 0),
(2, '加密狗', '软件配套', 0, '个', '含包装', 1, '陈高明', '2015-03-07 17:15:03', 0, '', '0000-00-00 00:00:00', 1, '发的说法', 500, 6, 95, 89, 0);

-- --------------------------------------------------------

--
-- 表的结构 `v2_proin`
--

CREATE TABLE IF NOT EXISTS `v2_proin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jpid` int(11) NOT NULL,
  `jpname` varchar(50) NOT NULL,
  `jpjiage` int(11) NOT NULL,
  `jpdanwei` varchar(20) NOT NULL,
  `jpguige` varchar(50) NOT NULL,
  `shuliang` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='入库记录' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_proin`
--

INSERT INTO `v2_proin` (`id`, `jpid`, `jpname`, `jpjiage`, `jpdanwei`, `jpguige`, `shuliang`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `juid`, `juname`) VALUES
(1, 1, '打印纸', 0, '只', '10包/箱', 100, '采购', 1, '陈高明', '2015-03-07 17:08:43', 1, '陈高明', '2015-03-08 10:54:29', 1, 2, '李洁霞'),
(2, 2, '加密狗', 500, '个', '含包装', 100, '采购', 1, '陈高明', '2015-03-07 17:18:01', 1, '陈高明', '2015-03-08 10:54:21', 1, 2, '李洁霞');

-- --------------------------------------------------------

--
-- 表的结构 `v2_proout`
--

CREATE TABLE IF NOT EXISTS `v2_proout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jpid` int(11) NOT NULL,
  `jpname` varchar(50) NOT NULL,
  `jpjiage` int(11) NOT NULL,
  `jpdanwei` varchar(20) NOT NULL,
  `jpguige` varchar(50) NOT NULL,
  `shuliang` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `jhid` int(11) NOT NULL,
  `jhname` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='出库记录' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_proout`
--

INSERT INTO `v2_proout` (`id`, `jpid`, `jpname`, `jpjiage`, `jpdanwei`, `jpguige`, `shuliang`, `title`, `uid`, `uname`, `addtime`, `uuid`, `juid`, `juname`, `jhid`, `jhname`, `status`, `uuname`, `updatetime`) VALUES
(1, 2, '加密狗', 500, '个', '含包装', 6, '合同需要', 1, '陈高明', '2015-03-07 19:31:19', 0, 3, '王冬冬', 2, '网络服务', 1, '', '0000-00-00 00:00:00'),
(2, 2, '加密狗', 500, '个', '含包装', 65, '大合同', 1, '陈高明', '2015-03-07 19:43:52', 0, 3, '王冬冬', 2, '网络服务', 1, '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `v2_report`
--

CREATE TABLE IF NOT EXISTS `v2_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `value` varchar(500) NOT NULL,
  `attid` int(11) NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `beizhu` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `juid` varchar(1000) NOT NULL,
  `juname` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='工作汇报' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_report`
--

INSERT INTO `v2_report` (`id`, `uid`, `uname`, `type`, `title`, `value`, `attid`, `uuid`, `uuname`, `addtime`, `updatetime`, `beizhu`, `status`, `juid`, `juname`) VALUES
(1, 1, '陈高明', '周总结', '汇报一周工作情况', '汇报一周工作情况', 1425702698, 2, '李洁霞', '2015-03-07 12:32:02', '2015-03-10 10:25:13', '\r\n陈高明:tinghao2015-03-07 13:14:33\r\n陈高明:不错啊！2015-03-07 14:03:11\r\n李洁霞:2015-03-10 10:25:13', 1, '2', '李洁霞');

-- --------------------------------------------------------

--
-- 表的结构 `v2_shou`
--

CREATE TABLE IF NOT EXISTS `v2_shou` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jhid` int(11) NOT NULL,
  `jhname` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `bianhao` varchar(50) NOT NULL,
  `jine` int(11) NOT NULL,
  `juid` int(11) NOT NULL,
  `juname` varchar(50) NOT NULL,
  `beizhu` varchar(200) NOT NULL,
  `uid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `addm` varchar(50) NOT NULL,
  `attid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='收款记录' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `v2_shou`
--

INSERT INTO `v2_shou` (`id`, `jhid`, `jhname`, `type`, `bianhao`, `jine`, `juid`, `juname`, `beizhu`, `uid`, `uuname`, `uname`, `addtime`, `uuid`, `updatetime`, `status`, `addm`, `attid`) VALUES
(1, 4, '长绒棉销售', '现金', '102020100', 5000, 2, '李洁霞', '业务收款', 1, '陈高明', '陈高明', '2015-03-08 11:48:24', 1, '2015-03-09 10:20:06', 1, '2015-03', 0),
(2, 4, '长绒棉销售', '公司账号', '520120', 10000, 3, '王冬冬', '尾款打公司账号1', 1, '陈高明', '陈高明', '2015-03-08 11:51:55', 1, '2015-03-09 10:20:14', 1, '2015-02', 0);

-- --------------------------------------------------------

--
-- 表的结构 `v2_task`
--

CREATE TABLE IF NOT EXISTS `v2_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `juid` varchar(500) NOT NULL,
  `kssj` datetime NOT NULL,
  `juname` varchar(500) NOT NULL,
  `jssj` datetime NOT NULL,
  `title` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `zhuangtai` varchar(20) NOT NULL,
  `wancheng` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `jhid` int(11) NOT NULL,
  `jhname` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='任务管理' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `v2_task`
--

INSERT INTO `v2_task` (`id`, `juid`, `kssj`, `juname`, `jssj`, `title`, `beizhu`, `zhuangtai`, `wancheng`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `jhid`, `jhname`) VALUES
(1, '4,3,2,1', '2015-03-08 15:25:13', '王晓丹,王冬冬,李洁霞,陈高明', '2015-03-08 15:25:16', '软件不会用，需要服务', '12125152', '已完成', '\r\n陈高明:好的。准备完善2015-03-08 16:06:03\r\n李洁霞:2015-03-10 09:01:36\r\n李洁霞:2015-03-10 10:25:01', 1425799502, 1, '陈高明', '2015-03-08 15:25:51', 1, '陈高明', '2015-03-16 11:45:33', 1, 4, '长绒棉销售'),
(2, '1', '2015-03-15 11:46:39', '陈高明', '2015-03-17 11:46:44', '对客户提出的改进意见进行处理', '', '进行中', '\r\n陈高明:12122015-03-16 11:48:18', 1426477583, 1, '陈高明', '2015-03-16 11:47:36', 1, '陈高明', '2015-03-16 11:48:18', 1, 0, ''),
(3, '4,3,2,1', '2015-03-16 11:49:40', '王晓丹,王冬冬,李洁霞,陈高明', '2015-03-16 11:49:44', '新东方公司的软件开发合同需要签约', '', '进行中', '\r\n陈高明:122015-03-16 11:50:42', 1426477765, 1, '陈高明', '2015-03-16 11:50:19', 1, '陈高明', '2015-03-16 11:50:42', 1, 0, ''),
(4, '4,3,2,1', '2015-03-17 11:51:55', '王晓丹,王冬冬,李洁霞,陈高明', '2015-03-18 11:51:59', '王晓丹准备出差安装，其他人配合', '发的说法', '进行中', '\r\n陈高明:122015-03-16 11:54:02', 1426477899, 1, '陈高明', '2015-03-16 11:52:23', 1, '陈高明', '2015-03-16 11:54:02', 1, 4, '长绒棉销售'),
(5, '4,3,2,1', '2015-03-15 11:53:08', '王晓丹,王冬冬,李洁霞,陈高明', '2015-03-17 11:53:11', '去采购配件', '', '进行中', '\r\n陈高明:122015-03-16 11:53:53', 1426477964, 1, '陈高明', '2015-03-16 11:53:44', 1, '陈高明', '2015-03-16 11:53:53', 1, 1, '网络服务费');

-- --------------------------------------------------------

--
-- 表的结构 `v2_user`
--

CREATE TABLE IF NOT EXISTS `v2_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `memo` varchar(50) NOT NULL,
  `depname` varchar(50) NOT NULL,
  `posname` varchar(50) NOT NULL,
  `truename` char(30) NOT NULL,
  `sex` char(5) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `phone` char(11) NOT NULL,
  `neixian` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `qq` varchar(20) NOT NULL,
  `logintime` datetime NOT NULL,
  `loginip` char(15) NOT NULL,
  `logins` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `update_time` int(11) NOT NULL,
  `bian` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `v2_user`
--

INSERT INTO `v2_user` (`id`, `username`, `password`, `memo`, `depname`, `posname`, `truename`, `sex`, `tel`, `phone`, `neixian`, `email`, `qq`, `logintime`, `loginip`, `logins`, `status`, `update_time`, `bian`) VALUES
(1, 'admin', '14e1b600b1fd579f47433b88e8d85291', '74870e1114ddb042052b11710f2e1316', '综合办公室', '总经理', '陈高明', '男', '8552646', '13812349563', '6535665', 'pinkecn@qq.com', '1612985', '2015-03-29 12:01:25', '127.0.0.1', 360, 1, 1427601685, '去采购办公用品，纸张，墨盒\r\n客户资料整理分析\r\n开总结会'),
(3, 'liuxing88', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '财务部', '会计', '王冬冬', '男', '52', '5', '', '2', '2', '2015-03-08 20:45:18', '0.0.0.0', 2, 1, 1425818718, ''),
(2, 'liuxing99', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '综合办公室', '总经理', '李洁霞', '男', '552', '525', '', 'pinkecn@qq.com', '16212', '2015-03-13 10:02:44', '61.139.126.203', 46, 1, 1426212164, '51212ssss'),
(4, 'liuxing77', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '市场部', '科员', '王晓丹', '女', '135121', '11212', '', '1212', '1212121', '2015-03-09 11:03:29', '118.123.16.120', 5, 1, 1425870296, '1521');

-- --------------------------------------------------------

--
-- 表的结构 `v2_zhishi`
--

CREATE TABLE IF NOT EXISTS `v2_zhishi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `beizhu` text NOT NULL,
  `attid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `addtime` datetime NOT NULL,
  `uuid` int(11) NOT NULL,
  `uuname` varchar(50) NOT NULL,
  `updatetime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='知识管理' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `v2_zhishi`
--

INSERT INTO `v2_zhishi` (`id`, `title`, `type`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, '范德萨发斯蒂芬', '产品知识', '发的说法', 1425357503, 1, '陈高明', '2015-03-03 12:38:58', 0, '', '0000-00-00 00:00:00', 1);
