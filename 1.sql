-- ����: localhost
-- ��������: 2017 �� 04 �� 11 �� 
-- mysql�������汾: 5.7.17
-- PHP �汾: 5.6.29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- ���ݿ�: `v2crm`
--

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_auth_group`
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
-- ת����е����� `v2_auth_group`
--

INSERT INTO `v2_auth_group` (`id`, `type`, `title`, `level`, `pid`, `sort`, `status`, `rules`) VALUES
(1, 0, '�ۺϰ칫��', 0, 0, 1, 1, ''),
(2, 0, '����', 0, 0, 2, 1, ''),
(3, 0, '������', 0, 0, 3, 1, ''),
(4, 0, '�г���', 0, 0, 4, 1, ''),
(5, 1, '�ܾ���', 1, 1, 1, 1, '42,56,57,58,59,61,72,73,74,76,62,63,64,65,66,67,68,69,71,77,78,80,79,82,83,84,85,87,88,89,91,90,93,94,95,96,97,99,100,101,102,103,105,106,107,108,43,44,45,46,48,49,50,52,53,54,55,199,200,201,202,203,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,170,171,172,173,174,175,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,195,196,197,198,220,221,222,223,225,109,110,111,112,113,115,116,117,118,119,120,121,122,123,124,125,126,158,127,128,129,130,132,133,134,135,136,137,139,140,141,142,143,145,146,147,148,149,156,151,152,153,154,157,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,1,14,15,20,21,25,26'),
(6, 1, '�칫������', 1, 1, 2, 1, ''),
(7, 1, '��Ա', 1, 1, 3, 1, '42,56,57,58,59,60,61,72,73,74,76,62,63,64,65,67,68,69,71,77,78,80,79,81,82,84,85,88,89,91,90,92,93,94,95,96,97,98,99,100,106,107,108,43,44,45,46,48,49,50,51,52,53,54,55,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,220,221,222,223,225,110,111,112,113,115,116,117,118,119,120,121,122,123,124,125,126,158,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,156,151,152,153,154,155,157,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,2,5,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,159,161,162,37,38,160,39,40,41'),
(8, 0, '�г�һ��', 1, 4, 1, 1, ''),
(9, 0, '�г�����', 1, 4, 2, 1, ''),
(10, 0, '�г�����', 1, 4, 1, 1, ''),
(12, 0, '�г�����', 1, 4, 1, 1, '1,2,5,3,4,6'),
(13, 1, '���', 0, 0, 1, 1, '42,56,57,58,59,61,72,73,74,76,62,63,64,65,77,78,80,79,82,88,89,91,90,93,94,95,96,97,99,100,101,102,103,105,106,107,108,43,44,45,46,48,49,50,52,53,54,55,199,200,201,202,203,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,163,164,165,166,167,169,176,170,171,172,173,174,175,177,178,179,180,182,183,184,185,186,188,189,190,191,192,194,195,196,197,198,220,221,222,223,225,110,111,112,113,114,115,125,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,156,151,152,153,154,155,157,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,5,3,4,6,7,9,10,11,12,13,15,16,17,18,19,21,22,23,24,26,27,28,29,31,32,33,34,36,159,161,162,37,38,160,39,40,41');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `v2_auth_group_access` (
  `uid` mediumint(8) NOT NULL,
  `group_id` mediumint(8) NOT NULL,
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- ת����е����� `v2_auth_group_access`
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
-- ��Ľṹ `v2_auth_rule`
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
-- ת����е����� `v2_auth_rule`
--

INSERT INTO `v2_auth_rule` (`id`, `level`, `pid`, `name`, `title`, `type`, `status`, `condition`, `sort`) VALUES
(1, 0, 0, 'home/system/index', 'ϵͳ����', 1, 1, '', 99),
(2, 1, 1, 'home/org/', '���Ź���', 1, 1, '', 1),
(3, 2, 2, 'home/org/add', '����', 1, 1, '', 1),
(4, 2, 2, 'home/org/edit', '�༭', 1, 1, '', 2),
(5, 2, 2, 'home/org/index', '�鿴', 1, 1, '', 0),
(6, 2, 2, 'home/org/del', 'ɾ��', 1, 1, '', 3),
(7, 2, 2, 'home/org/editrule', 'Ȩ��', 1, 1, '', 4),
(8, 1, 1, 'home/dep', 'ְλ����', 1, 1, '', 2),
(9, 2, 8, 'home/dep/index', '�鿴', 1, 1, '', 0),
(10, 2, 8, 'home/dep/add', '����', 1, 1, '', 1),
(11, 2, 8, 'home/dep/edit', '�༭', 1, 1, '', 2),
(12, 2, 8, 'home/dep/del', 'ɾ��', 1, 1, '', 3),
(13, 2, 8, 'home/dep/editrule', 'Ȩ��', 1, 1, '', 4),
(14, 1, 1, 'home/user/', '�û�����', 1, 1, '', 3),
(15, 2, 14, 'home/user/index', '�鿴', 1, 1, '', 0),
(16, 2, 14, 'home/user/add', '����', 1, 1, '', 1),
(17, 2, 14, 'home/user/edit', '�༭', 1, 1, '', 2),
(18, 2, 14, 'home/user/del', 'ɾ��', 1, 1, '', 3),
(19, 2, 14, 'home/user/editrule', 'Ȩ��', 1, 1, '', 4),
(20, 1, 1, 'home/config/', '�����ֵ�', 1, 1, '', 4),
(21, 2, 20, 'home/config/index', '�鿴', 1, 1, '', 0),
(22, 2, 20, 'home/config/add', '����', 1, 1, '', 1),
(23, 2, 20, 'home/config/edit', '�༭', 1, 1, '', 2),
(24, 2, 20, 'home/config/del', 'ɾ��', 1, 1, '', 3),
(25, 1, 1, 'home/menu/', '�˵�����', 1, 1, '', 5),
(26, 2, 25, 'home/menu/index', '�鿴', 1, 1, '', 0),
(27, 2, 25, 'home/menu/add', '����', 1, 1, '', 1),
(28, 2, 25, 'home/menu/edit', '�༭', 1, 1, '', 2),
(29, 2, 25, 'home/menu/del', 'ɾ��', 1, 1, '', 3),
(30, 1, 1, 'home/rule/', '�����б�', 1, 1, '', 6),
(31, 2, 30, 'home/rule/index', '�鿴', 1, 1, '', 0),
(32, 2, 30, 'home/rule/add', '����', 1, 1, '', 1),
(33, 2, 30, 'home/rule/edit', '�༭', 1, 1, '', 2),
(34, 2, 30, 'home/rule/del', 'ɾ��', 1, 1, '', 3),
(35, 1, 1, 'home/database', '���ݱ���', 1, 1, '', 10),
(36, 2, 35, 'home/database/index', '�鿴', 1, 1, '', 0),
(37, 1, 1, 'home/database/', '�����ļ�', 1, 1, '', 11),
(38, 2, 37, 'home/database/bakup', '�鿴', 1, 1, '', 0),
(39, 1, 1, 'home/log', '������־', 1, 1, '', 15),
(40, 2, 39, 'home/log/index', '�鿴', 1, 1, '', 0),
(41, 2, 39, 'home/log/del', 'ɾ��', 1, 1, '', 1),
(42, 0, 0, 'home/office/index', '���˰칫', 1, 1, '', 1),
(43, 1, 42, 'home/contact/index', '�ҵ�ͨѶ¼', 1, 1, '', 21),
(44, 2, 43, 'home/contact/view', '�鿴', 1, 1, '', 0),
(45, 2, 43, 'home/contact/add', '����', 1, 1, '', 1),
(46, 2, 43, 'home/contact/edit', '�༭', 1, 1, '', 2),
(47, 2, 43, 'home/contact/del', 'ɾ��', 1, 1, '', 3),
(48, 2, 43, 'home/contact/outxls', '����', 1, 1, '', 4),
(49, 1, 42, 'home/pcontact/index', '����ͨѶ¼', 1, 1, '', 22),
(50, 2, 49, 'home/pcontact/view', '�鿴', 1, 1, '', 0),
(51, 2, 49, 'home/pcontact/del', 'ɾ��', 1, 1, '', 2),
(52, 2, 49, 'home/pcontact/outxls', '����', 1, 1, '', 3),
(53, 1, 42, 'home/ccontact/', '��˾ͨѶ¼', 1, 1, '', 23),
(54, 2, 53, 'home/ccontact/index', '�鿴', 1, 1, '', 1),
(55, 2, 53, 'home/ccontact/outxls', '����', 1, 1, '', 3),
(56, 1, 42, 'home/mygo/index', '�ҵ�ȥ��', 1, 1, '', 0),
(57, 2, 56, 'home/mygo/view', '�鿴', 1, 1, '', 0),
(58, 2, 56, 'home/mygo/add', '����', 1, 1, '', 1),
(59, 2, 56, 'home/mygo/edit', '�༭', 1, 1, '', 2),
(60, 2, 56, 'home/mygo/del', 'ɾ��', 1, 1, '', 3),
(61, 2, 56, 'home/mygo/outxls', '����', 1, 1, '', 4),
(62, 1, 42, 'home/mytask/index', '�ҵ�����', 1, 1, '', 3),
(63, 2, 62, 'home/mytask/view', '�鿴', 1, 1, '', 0),
(64, 2, 62, 'home/mytask/edit', '�༭', 1, 1, '', 2),
(65, 2, 62, 'home/mytask/outxls', '����', 1, 1, '', 4),
(66, 1, 42, 'home/task/index', 'ָ������', 1, 1, '', 4),
(67, 2, 66, 'home/task/view', '�鿴', 1, 1, '', 0),
(68, 2, 66, 'home/task/add', '����', 1, 1, '', 1),
(69, 2, 66, 'home/task/edit', '�༭', 1, 1, '', 2),
(70, 2, 66, 'home/task/del', 'ɾ��', 1, 1, '', 3),
(71, 2, 66, 'home/task/outxls', '����', 1, 1, '', 4),
(72, 1, 42, 'home/mygos/index', 'Ա��ȥ��', 1, 1, '', 1),
(73, 2, 72, 'home/mygos/view', '�鿴', 1, 1, '', 0),
(74, 2, 72, 'home/mygos/edit', '�༭', 1, 1, '', 2),
(75, 2, 72, 'home/mygos/del', 'ɾ��', 1, 1, '', 3),
(76, 2, 72, 'home/mygos/outxls', '����', 1, 1, '', 4),
(77, 1, 42, 'home/myreport/index', '�ҵĹ����㱨', 1, 1, '', 5),
(78, 2, 77, 'home/myreport/view', '�鿴', 1, 1, '', 0),
(79, 2, 77, 'home/myreport/edit', '�༭', 1, 1, '', 2),
(80, 2, 77, 'home/myreport/add', '����', 1, 1, '', 1),
(81, 2, 77, 'home/myreport/del', 'ɾ��', 1, 1, '', 3),
(82, 2, 77, 'home/myreport/outxls', '����', 1, 1, '', 4),
(83, 1, 42, 'home/report/index', '��ע�����㱨', 1, 1, '', 6),
(84, 2, 83, 'home/report/view', '�鿴', 1, 1, '', 0),
(85, 2, 83, 'home/report/edit', '�༭', 1, 1, '', 2),
(86, 2, 83, 'home/report/del', 'ɾ��', 1, 1, '', 3),
(87, 2, 83, 'home/report/outxls', '����', 1, 1, '', 4),
(88, 1, 42, 'home/doc/index', '�ҵ��ĵ�', 1, 1, '', 7),
(89, 2, 88, 'home/doc/view', '�鿴', 1, 1, '', 0),
(90, 2, 88, 'home/doc/edit', '�༭', 1, 1, '', 2),
(91, 2, 88, 'home/doc/add', '����', 1, 1, '', 1),
(92, 2, 88, 'home/doc/del', 'ɾ��', 1, 1, '', 3),
(93, 2, 88, 'home/doc/outxls', '����', 1, 1, '', 4),
(94, 1, 42, 'home/zhishi/index', '֪ʶ����', 1, 1, '', 8),
(95, 2, 94, 'home/zhishi/view', '�鿴', 1, 1, '', 0),
(96, 2, 94, 'home/zhishi/add', '����', 1, 1, '', 1),
(97, 2, 94, 'home/zhishi/edit', '�༭', 1, 1, '', 2),
(98, 2, 94, 'home/zhshi/del', 'ɾ��', 1, 1, '', 3),
(99, 2, 94, 'home/zhishi/outxls', '����', 1, 1, '', 4),
(100, 1, 42, 'home/info/index', '��֪ͨ', 1, 1, '', 9),
(101, 2, 100, 'home/info/view', '�鿴', 1, 1, '', 0),
(102, 2, 100, 'home/info/add', '����', 1, 1, '', 1),
(103, 2, 100, 'home/info/edit', '�༭', 1, 1, '', 2),
(104, 2, 100, 'home/info/del', 'ɾ��', 1, 1, '', 3),
(105, 2, 100, 'home/info/outxls', '����', 1, 1, '', 4),
(106, 1, 42, 'home/myinfo/index', '��֪ͨ', 1, 1, '', 10),
(107, 2, 106, 'home/myinfo/view', '�鿴', 1, 1, '', 0),
(108, 2, 106, 'home/myinfo/edit', '�ظ�', 1, 1, '', 2),
(109, 0, 0, 'home/hr/index', '���¹���', 1, 1, '', 4),
(110, 1, 109, 'home/hr/', 'Ա������', 1, 1, '', 1),
(111, 2, 110, 'home/hr/view', '�鿴', 1, 1, '', 0),
(112, 2, 110, 'home/hr/add', '����', 1, 1, '', 1),
(113, 2, 110, 'home/hr/edit', '�༭', 1, 1, '', 2),
(114, 2, 110, 'home/hr/del', 'ɾ��', 1, 1, '', 3),
(115, 2, 110, 'home/hr/outxls', '����', 1, 1, '', 4),
(116, 2, 110, 'home/hr/fenxi', '����', 1, 1, '', 5),
(117, 2, 110, 'home/hr/birthday', '����', 1, 1, '', 6),
(118, 2, 110, 'home/hr/sex', '�Ա�', 1, 1, '', 7),
(119, 2, 110, 'home/hr/bumen', '����', 1, 1, '', 8),
(120, 2, 110, 'home/hr/hunyin', '����', 1, 1, '', 9),
(121, 2, 110, 'home/hr/zhengzhi', '����', 1, 1, '', 10),
(122, 2, 110, 'home/hr/type', '����', 1, 1, '', 11),
(123, 2, 110, 'home/hr/zaizhi', '��ְ', 1, 1, '', 12),
(124, 2, 110, 'home/hr/xueli', 'ѧ��', 1, 1, '', 13),
(125, 2, 110, 'home/hr/zhuanye', 'רҵ', 1, 1, '', 14),
(126, 2, 110, 'home/hr/xuewei', 'ѧλ', 1, 1, '', 15),
(127, 1, 109, 'home/hrht/index', '���º�ͬ', 1, 1, '', 2),
(128, 2, 127, 'home/hrht/view', '�鿴', 1, 1, '', 0),
(129, 2, 127, 'home/hrht/add', '����', 1, 1, '', 1),
(130, 2, 127, 'home/hrht/edit', '�༭', 1, 1, '', 2),
(131, 2, 127, 'home/hrht/del', 'ɾ��', 1, 1, '', 3),
(132, 2, 127, 'home/hrht/outxls', '����', 1, 1, '', 4),
(133, 2, 127, 'home/hrht/daoqi', '����', 1, 1, '', 5),
(134, 1, 109, 'home/hrjf/index', '��������', 1, 1, '', 3),
(135, 2, 134, 'home/hrjf/view', '�鿴', 1, 1, '', 0),
(136, 2, 134, 'home/hrjf/add', '����', 1, 1, '', 1),
(137, 2, 134, 'home/hrjf/edit', '�༭', 1, 1, '', 2),
(138, 2, 134, 'home/hrjf/del', 'ɾ��', 1, 1, '', 3),
(139, 2, 134, 'home/hrjf/outxls', '����', 1, 1, '', 4),
(140, 1, 109, 'home/hrzz/index', '֤�չ���', 1, 1, '', 5),
(141, 2, 140, 'home/hrzz/view', '�鿴', 1, 1, '', 0),
(142, 2, 140, 'home/hrzz/add', '����', 1, 1, '', 1),
(143, 2, 140, 'home/hzz/edit', '�༭', 1, 1, '', 2),
(144, 2, 140, 'home/hrzz/del', 'ɾ��', 1, 1, '', 3),
(145, 2, 140, 'home/hrzz/outxls', '����', 1, 1, '', 4),
(146, 1, 109, 'home/hrpx/index', '��ѵ����', 1, 1, '', 7),
(147, 2, 146, 'home/hrpx/view', '�鿴', 1, 1, '', 0),
(148, 2, 146, 'home/hrpx/add', '����', 1, 1, '', 1),
(149, 2, 146, 'home/hrpx/edit', '�༭', 1, 1, '', 2),
(150, 2, 146, 'home/hrpx/del', 'ɾ��', 1, 1, '', 3),
(151, 1, 109, 'home/hrdd/index', '���µ���', 1, 1, '', 8),
(152, 2, 151, 'home/hrdd/view', '�鿴', 1, 1, '', 0),
(153, 2, 151, 'home/hrdd/add', '����', 1, 1, '', 1),
(154, 2, 151, 'home/hrdd/edit', '�༭', 1, 1, '', 2),
(155, 2, 151, 'home/hrdd/del', 'ɾ��', 1, 1, '', 3),
(156, 2, 146, 'home/hrpx/outxls', '����', 1, 1, '', 4),
(157, 2, 151, 'home/hrdd/outxls', '����', 1, 1, '', 4),
(158, 2, 110, 'home/hr/hukou', '����', 1, 1, '', 16),
(159, 2, 35, 'home/database/export', '����', 1, 1, '', 1),
(160, 2, 37, 'home/database/del', 'ɾ��', 1, 1, '', 1),
(161, 2, 35, 'home/database/optimize', '�Ż�', 1, 1, '', 2),
(162, 2, 35, 'home/database/repair', '�޸�', 1, 1, '', 4),
(163, 0, 0, 'home/cust/index', '�ͻ�����', 1, 1, '', 3),
(164, 1, 163, 'home/cust/', '�ͻ���Ϣ', 1, 1, '', 1),
(165, 2, 164, 'home/cust/view', '�鿴', 1, 1, '', 0),
(166, 2, 164, 'home/cust/add', '����', 1, 1, '', 1),
(167, 2, 164, 'home/cust/edit', '�༭', 1, 1, '', 2),
(168, 2, 164, 'home/cust/del', 'ɾ��', 1, 1, '', 3),
(169, 2, 164, 'home/cust/outxls', '����', 1, 1, '', 4),
(170, 2, 164, 'home/cust/fenxi', '����', 1, 1, '', 5),
(171, 2, 164, 'home/cust/jinnian', '����', 1, 1, '', 6),
(172, 2, 164, 'home/cust/qunian', 'ȥ��', 1, 1, '', 7),
(173, 2, 164, 'home/cust/fenlei', '��չ', 1, 1, '', 8),
(174, 2, 164, 'home/cust/type', '��Դ', 1, 1, '', 9),
(175, 2, 164, 'home/cust/uname', '�����', 1, 1, '', 10),
(176, 2, 164, 'home/cust/daoqi', '����', 1, 1, '', 5),
(177, 1, 163, 'home/custcon/index', '��ϵ��', 1, 1, '', 2),
(178, 2, 177, 'home/custcon/view', '�鿴', 1, 1, '', 0),
(179, 2, 177, 'home/custcon/add', '����', 1, 1, '', 1),
(180, 2, 177, 'home/custcon/edit', '�༭', 1, 1, '', 2),
(181, 2, 177, 'home/custcon/del', 'ɾ��', 1, 1, '', 3),
(182, 2, 177, 'home/custcon/outxls', '����', 1, 1, '', 4),
(183, 1, 163, 'home/custgd/index', '������¼', 1, 1, '', 3),
(184, 2, 183, 'home/custgd/view', '�鿴', 1, 1, '', 0),
(185, 2, 183, 'home/custgd/add', '����', 1, 1, '', 1),
(186, 2, 183, 'home/custgd/edit', '�༭', 1, 1, '', 2),
(187, 2, 183, 'home/custgd/del', 'ɾ��', 1, 1, '', 3),
(188, 2, 183, 'home/custgd/outxls', '����', 1, 1, '', 4),
(189, 1, 163, 'home/hetong/index', '��ͬ����', 1, 1, '', 4),
(190, 2, 189, 'home/hetong/view', '�鿴', 1, 1, '', 0),
(191, 2, 189, 'home/hetong/add', '����', 1, 1, '', 1),
(192, 2, 189, 'home/hetong/edit', '�༭', 1, 1, '', 2),
(193, 2, 189, 'home/hetong/del', 'ɾ��', 1, 1, '', 3),
(194, 2, 189, 'home/hetong/outxls', '����', 1, 1, '', 4),
(195, 2, 189, 'home/htfenxi/index', '����', 1, 1, '', 5),
(196, 2, 189, 'home/htfenxi/', '����', 1, 1, '', 6),
(197, 2, 189, 'home/htfenxi/lastyear', 'ȥ��', 1, 1, '', 8),
(198, 2, 189, 'home/htfenxi/yewuyuan', 'ҵ��Ա', 1, 1, '', 8),
(199, 0, 0, 'home/stock/index', '������', 1, 1, '', 2),
(200, 1, 199, 'home/pro/index', '��Ʒ����', 1, 1, '', 1),
(201, 2, 200, 'home/pro/view', '�鿴', 1, 1, '', 0),
(202, 2, 200, 'home/pro/add', '����', 1, 1, '', 1),
(203, 2, 200, 'home/pro/edit', '�༭', 1, 1, '', 2),
(204, 2, 200, 'home/pro/del', 'ɾ��', 1, 1, '', 3),
(205, 2, 200, 'home/pro/outxls', '����', 1, 1, '', 4),
(206, 1, 199, 'home/proin/index', '����¼', 1, 1, '', 2),
(207, 2, 206, 'home/proin/view', '�鿴', 1, 1, '', 0),
(208, 2, 206, 'home/proin/add', '����', 1, 1, '', 1),
(209, 2, 206, 'home/proin/edit', '�༭', 1, 1, '', 2),
(210, 2, 206, 'home/proin/outxls', '����', 1, 1, '', 4),
(211, 1, 199, 'home/proout/index', '�����¼', 1, 1, '', 3),
(212, 2, 211, 'home/proout/view', '�鿴', 1, 1, '', 0),
(213, 2, 211, 'home/proout/add', '����', 1, 1, '', 1),
(214, 2, 211, 'home/proout/edit', '�༭', 1, 1, '', 2),
(215, 2, 211, 'home/proout/outxls', '����', 1, 1, '', 4),
(216, 1, 199, 'home/stock/', '������', 1, 1, '', 4),
(217, 2, 216, 'home/stock/view', '�鿴', 1, 1, '', 0),
(218, 2, 216, 'home/stock/outxls', '����', 1, 1, '', 4),
(219, 2, 216, 'home/stock/baojing', '����', 1, 1, '', 5),
(220, 1, 163, 'home/huo/index', '������¼', 1, 1, '', 5),
(221, 2, 220, 'home/huo/view', '�鿴', 1, 1, '', 0),
(222, 2, 220, 'home/huo/add', '����', 1, 1, '', 1),
(223, 2, 220, 'home/huo/edit', '�༭', 1, 1, '', 2),
(224, 2, 220, 'home/huo/del', 'ɾ��', 1, 1, '', 3),
(225, 2, 220, 'home/huo/outxls', '����', 1, 1, '', 4),
(226, 0, 0, 'home/shou/index', '�������', 1, 1, '', 6),
(227, 1, 226, 'home/shou/', '�տ��¼', 1, 1, '', 1),
(228, 2, 227, 'home/shou/view', '�鿴', 1, 1, '', 0),
(229, 2, 227, 'home/shou/add', '����', 1, 1, '', 1),
(230, 2, 227, 'home/shou/edit', '�༭', 1, 1, '', 2),
(231, 2, 227, 'home/shou/outxls', '����', 1, 1, '', 4),
(232, 1, 226, 'home/fu/index', '�����¼', 1, 1, '', 2),
(233, 2, 232, 'home/fu/view', '�鿴', 1, 1, '', 0),
(234, 2, 232, 'home/fu/add', '����', 1, 1, '', 1),
(235, 2, 232, 'home/fu/edit', '�༭', 1, 1, '', 2),
(236, 2, 232, 'home/fu/outxls', '����', 1, 1, '', 4),
(237, 1, 226, 'home/piao/index', '��Ʊ����', 1, 1, '', 3),
(238, 2, 237, 'home/piao/view', '�鿴', 1, 1, '', 0),
(239, 2, 237, 'home/piao/add', '����', 1, 1, '', 1),
(240, 2, 237, 'home/piao/edit', '�༭', 1, 1, '', 2),
(241, 2, 237, 'home/piao/outxls', '����', 1, 1, '', 4);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_config`
--

CREATE TABLE IF NOT EXISTS `v2_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fenlei` varchar(20) NOT NULL COMMENT '����',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '��������',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '��������',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '����˵��',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '����ֵ',
  `remark` varchar(100) NOT NULL COMMENT '����˵��',
  `addtime` datetime NOT NULL COMMENT '����ʱ��',
  `updatetime` datetime NOT NULL COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '״̬',
  `value` text NOT NULL COMMENT '����ֵ',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '����',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- ת����е����� `v2_config`
--

INSERT INTO `v2_config` (`id`, `fenlei`, `name`, `type`, `title`, `extra`, `remark`, `addtime`, `updatetime`, `status`, `value`, `sort`) VALUES
(1, 'ϵͳ', 'CONFIG_TYPE_LIST', 3, '���������б�', '', '��Ҫ�������ݽ�����ҳ���������', '2015-02-01 14:39:41', '2015-02-25 10:44:48', 1, '0:����\r\n1:�ַ�\r\n2:�ı�\r\n3:����\r\n4:ö��', 0),
(2, '����', 'PERPAGE', 0, 'ÿҳ����', '', '�б��ҳ����', '2015-02-01 14:49:47', '2015-02-25 10:44:55', 1, '15', 0),
(3, '����', 'SEARCHKEY', 3, '�����������ֶ���', '', '', '2015-02-01 14:56:03', '2015-03-06 15:04:30', 1, '1:name\r\n2:title\r\n3:username\r\n4:value\r\n5:truename\r\n6:tel\r\n7:email\r\n8:qq\r\n9:phone\r\n10:type\r\n11:xingming\r\n12:xueli\r\n13:xuexiao\r\n14:fenlei\r\n15:depname\r\n16:posname\r\n17:dianhua\r\n18:danwei\r\n19:zhiwu\r\n20:uname\r\n21:uuname\r\n22:beizhu\r\n23:zhuangtai\r\n24:bumen\r\n25:zhiwei\r\n26:zhuanye\r\n27:zaizhi\r\n28:jcname\r\n29:juname\r\n30:gonghao', 0),
(4, 'ϵͳ', 'DATA_CACHE_TIME', 0, '���ݻ���ʱ��', '', '���ݻ�����Ч�� 0��ʾ���û���', '2015-02-01 15:05:20', '2015-02-25 10:44:23', 1, '14400', 0),
(5, 'ϵͳ', 'SESSION_PREFIXX', 1, 'session ǰ׺', '', '', '2015-02-01 15:07:09', '2015-02-25 10:44:17', 1, 'lygxykj', 0),
(6, 'ϵͳ', 'WEB_SITE_TITLE', 2, 'ϵͳ����', '', '', '2015-02-01 15:17:46', '2015-02-25 10:44:06', 1, 'V2ϵͳ��Ϣ������ƽ̨', 0),
(11, 'ģ��', 'MODEL_B_SHOW', 3, '�ֶ�ģ�ͱ���ʾ', '', '', '2015-02-01 22:12:54', '2015-02-25 10:43:02', 1, '0:����ʾ\r\n1:����ʾ\r\n2:������ʾ\r\n3:�༭��ʾ', 0),
(7, 'ϵͳ', 'DATA_BACKUP_PATH', 1, '���ݿⱸ��·��', '', '', '2015-02-01 15:55:43', '2015-02-25 10:43:53', 1, 'data', 0),
(8, 'ϵͳ', 'DATA_BACKUP_PART_SIZE', 0, '���ݿⱸ�ݾ��С', '', '��ֵ��������ѹ����ķ־���󳤶ȡ���λ��B����������20M', '2015-02-01 15:56:41', '2015-02-25 10:44:00', 1, '20971520', 0),
(9, 'ϵͳ', 'DATA_BACKUP_COMPRESS', 4, '���ݿⱸ���ļ��Ƿ�����ѹ��', '0:��ѹ��\r\n1:����ѹ��', 'ѹ�������ļ���ҪPHP����֧��gzopen,gzwrite����', '2015-02-01 15:57:49', '2015-02-25 10:43:30', 1, '1', 0),
(10, 'ϵͳ', 'DATA_BACKUP_COMPRESS_LEVEL', 4, '���ݿⱸ���ļ�ѹ������', '1:��ͨ\r\n4:һ��\r\n9:���', '���ݿⱸ���ļ���ѹ�����𣬸������ڿ���ѹ��ʱ��Ч', '2015-02-01 15:58:48', '2015-02-25 10:43:25', 1, '9', 0),
(12, 'ģ��', 'MODEL_L_SHOW', 3, '�ֶ�ģ���б���ʾ', '', '', '2015-02-02 14:55:31', '2015-02-25 10:42:53', 1, '0:����ʾ\r\n1:��ʾ', 0),
(13, 'ģ��', 'MODEL_B_ATTR', 3, '����ģ���б�����', '', '', '2015-02-02 15:46:08', '2015-02-28 11:40:06', 1, '0:�ı���\r\n1:�ı���\r\n2:�����\r\n3:���ڿ�\r\n4:�༭��\r\n5:΢����\r\n6:��ѡ��\r\n7:��ѡ��\r\n8:������\r\n9:���Ҵ���\r\n10:�ϴ�����\r\n11:����ʱ���', 0),
(14, 'ģ��', 'MODEL_B_ISMUST', 3, '����ģ�����Ƿ����', '', '', '2015-02-02 16:05:26', '2015-02-28 11:37:48', 1, '0:�Ǳ���\r\n1:����\r\n2:��������\r\n3:�����ֻ�����\r\n4:����EMAIL\r\n5:������ĸ\r\n6:�������֤����\r\n7:��������\r\n8:��������\r\n9:��������ʱ��', 0),
(15, 'ģ��', 'MODEL_B_ISSORT', 3, '����ģ���е��ֶ��Ƿ��������', '', '', '2015-02-02 19:53:07', '2015-02-25 10:42:27', 1, '0:������\r\n1:����', 0),
(16, '����', 'BASE_SEX', 3, '�Ա�', '', '', '2015-02-02 21:21:58', '2015-02-25 10:28:07', 1, '0:��\r\n1:Ů', 0),
(17, '����', 'BASE_XUELI', 3, 'ѧ��', '', '', '2015-02-02 21:23:26', '2015-02-25 10:28:01', 1, '0:��ר\r\n1:��ר\r\n2:����\r\n3:˶ʿ\r\n4:��ʿ', 0),
(18, '����', 'CONFIG_CLASS', 3, '���÷���', '', '', '2015-02-25 10:22:21', '2015-03-06 09:45:11', 1, '0:ϵͳ\r\n1:����\r\n2:ģ��\r\n3:����\r\n4:���¹���\r\n5:�ͻ�����\r\n6:������\r\n7:�������', 0),
(19, '����', 'BASE_SHUXING', 3, '����', '', 'ͨѶ¼����', '2015-02-26 15:30:42', '2015-02-27 09:42:38', 1, '˽��\r\n����', 0),
(20, '����', 'TASK_STATUS', 3, '����״̬', '', '��������е�״̬', '2015-02-28 12:24:20', '2015-02-28 12:24:41', 1, '0:������\r\n1:�����', 0),
(21, '����', 'REPORT_TYPE', 3, '�����㱨����', '', '', '2015-02-28 16:00:03', '0000-00-00 00:00:00', 1, '���ܽ�\r\n���ܽ�\r\n���ܽ�\r\n���ܽ�\r\n����', 0),
(22, '���¹���', 'HR_HUNYIN', 3, '����״��', '', '', '2015-02-28 20:43:51', '0000-00-00 00:00:00', 1, 'δ��\r\n�ѻ�\r\n����\r\nɥż', 0),
(23, '���¹���', 'HR_ZHENGZHI', 3, '������ò', '', '', '2015-02-28 20:50:09', '0000-00-00 00:00:00', 1, 'Ⱥ��\r\n������Ա\r\nԤ����Ա\r\n��Ա\r\n��������', 0),
(24, '���¹���', 'HR_HUKOU', 3, '�������', '', '', '2015-02-28 20:53:21', '0000-00-00 00:00:00', 1, '���س������\r\n�Ⲻ�������\r\n����ũ�廧��\r\n���ũ�廧��', 0),
(25, '���¹���', 'HR_TYPE', 3, 'Ա������', '', '', '2015-02-28 21:08:16', '0000-00-00 00:00:00', 1, '��ʽԱ��\r\n��ͬ��\r\n��ʱ��', 0),
(26, '���¹���', 'HR_ZAIZHI', 3, '��ְ״̬', '', '', '2015-02-28 21:11:25', '0000-00-00 00:00:00', 1, '��ְ\r\n��ְ\r\n���\r\n����\r\n����', 0),
(27, '���¹���', 'HR_XUEWEI', 3, 'ѧλ', '', '', '2015-02-28 21:15:46', '2015-02-28 21:30:14', 1, '����\r\nѧʿ\r\n˶ʿ\r\n��ʿ', 0),
(28, '���¹���', 'HRHT_TYPE', 3, '���º�ͬ����', '', '', '2015-03-01 12:56:36', '0000-00-00 00:00:00', 1, '�����ͬ\r\n���ܺ�ͬ\r\n����', 0),
(29, '���¹���', 'HRJF_TYPE', 3, '������Ŀ', '', '', '2015-03-01 15:50:35', '0000-00-00 00:00:00', 1, '����\r\n�ͷ�', 0),
(30, '���¹���', 'HRZZ_TYPE', 3, '֤������', '', '', '2015-03-01 17:49:50', '0000-00-00 00:00:00', 1, '���֤\r\n��ʻ֤\r\n����֤\r\n����֤\r\n����', 0),
(31, '���¹���', 'HRDD_TYPE', 3, '��������', '', '', '2015-03-01 20:21:25', '0000-00-00 00:00:00', 1, '����\r\n����\r\n����\r\n����', 0),
(32, '���¹���', 'HRGH_TYPE', 3, '�ػ�����', '', '', '2015-03-01 20:42:08', '0000-00-00 00:00:00', 1, '����\r\n����\r\n����\r\nף��\r\n��ף', 0),
(33, '����', 'ZHISHI_TYPE', 3, '֪ʶ����', '', '', '2015-03-03 12:33:37', '2015-03-03 12:39:23', 1, '��Ʒ֪ʶ\r\n����֪ʶ\r\nӪ��֪ʶ\r\n����֪ʶ\r\n��ѵ����\r\n����֪ʶ\r\n����֪ʶ', 0),
(34, '�ͻ�����', 'CUST_TYPE', 3, '�ͻ���Դ', '', '', '2015-03-03 21:44:04', '0000-00-00 00:00:00', 1, '�ٶ��ƹ�\r\n�绰Ӫ��\r\n������ϵ\r\n�ͻ�����', 0),
(35, '�ͻ�����', 'CUSTGD_TYPE', 3, '��ϵ��ʽ', '', '', '2015-03-04 11:18:41', '0000-00-00 00:00:00', 1, '�绰\r\nQQ\r\n��������\r\n���Űݷ�', 0),
(36, '�ͻ�����', 'CUSTGD_FENLEI', 3, '��չ�׶�', '', '', '2015-03-04 11:22:02', '0000-00-00 00:00:00', 1, '��������\r\nѡ��Ƚ�\r\n�������\r\n�ɽ��ͻ�\r\n����ǩ��', 0),
(37, '������', 'PRO_TYPE', 3, '������λ', '', '', '2015-03-04 20:47:13', '2015-03-06 10:00:57', 1, '̨\r\n��\r\n��\r\nֻ', 0),
(38, 'ģ��', 'MODEL_F_TYPE', 3, 'ͼ������', '', '', '2015-03-06 14:16:26', '0000-00-00 00:00:00', 1, '0:������\r\n1:3D��ͼ\r\n2:��״ͼ\r\n3:����ͼ\r\n4:��״ͼ\r\n5:������ͼ', 0);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_contact`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='ͨѶ¼' AUTO_INCREMENT=4 ;

--
-- ת����е����� `v2_contact`
--

INSERT INTO `v2_contact` (`id`, `xingming`, `sex`, `danwei`, `zhiwu`, `dianhua`, `phone`, `email`, `shuxing`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `qq`, `fenlei`) VALUES
(1, '����ʡ', '��', 'δ������С����', '�ķ��ܷ�', '5152451512', '1461381212', '12@fgss.co', '����', 'fsdjlf dsjfds�ǽ����������������˷����������Ľ�������s�����ĺ��˷�ʢ�ķ�����˷����ļ��ʾ����˿�˹���췢�˶��ٽ�ʦ�ڿ��ֹɷݼ������˾����˿����˸߿Ƽ���˾糡����ô������ũ���ֻ������������������Ӿ��������߳�ŭ��û�Ǹ��˿�ʼ�������Щ����ֹ��������Ǹ�˭���꿨�����Ǹ������Ǹ�˭���ܸշ��ֿ��ܹ���ʱ������˵���������͹��������������������\r\n�����ļ��ָ��Ե�\r\n���˷�ʱ�����ϵ���ܸտ�ʼ����x\r\n�ֹ�˾��', 1, '�¸���', '2015-02-26 20:18:45', 1, '�¸���', '2015-03-02 12:35:10', 1, '1212121212', 'ҵ������'),
(2, '��Ʒ�', 'Ů', '��������˳��', '������', '1545121321', '2121512', '121121@Ʒ��.com', '˽��', '������������ ', 1, '�¸���', '2015-02-27 11:33:00', 0, '', '0000-00-00 00:00:00', 1, '1251022', '����'),
(3, '������', '��', '����������˵��', '������', '451213451', '212313212', '12121213', '����', '��ˮ���ˮ���������ffsd��a\r\n����������', 2, '����', '2015-02-27 11:47:36', 0, '', '0000-00-00 00:00:00', 1, '12', '���');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_cust`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�ͻ�����' AUTO_INCREMENT=4 ;

--
-- ת����е����� `v2_cust`
--

INSERT INTO `v2_cust` (`id`, `xingming`, `phone`, `addtime`, `updatetime`, `status`, `beizhu`, `title`, `dizhi`, `email`, `qq`, `sex`, `bumen`, `type`, `name`, `juid`, `juname`, `uid`, `uname`, `uuid`, `uuname`, `fenlei`, `xcrq`, `addm`) VALUES
(1, '�¸���', '13812349563', '2015-03-04 11:57:31', '2015-03-07 14:42:12', 1, '1221', '���Ƹ����ѿƼ����޹�˾', '����ʡ���Ƹ���', 'pinkecn@qq.com', '16129825', '��', '����', '������ϵ', '', '3', '������', 1, '�¸���', 2, '���ϼ', '�ɽ��ͻ�', '0000-00-00', '2015-03'),
(2, '������', '13822121251', '2015-03-06 16:15:21', '2015-03-06 16:35:21', 1, '', '�ٶȹ�˾', '������', '', '', '��', '����', '�绰Ӫ��', '', '2,1', '���ϼ,�¸���', 1, '�¸���', 1, '�¸���', '��δ��ϵ', '0000-00-00', '2015-03'),
(3, '����', '135555511', '2015-02-01 16:43:11', '2015-03-06 20:26:22', 1, '', '��Ѷ��˾', '����', '', '', 'Ů', '', '������ϵ', '', '3,2', '������,���ϼ', 1, '�¸���', 0, '', '�ɽ��ͻ�', '2015-03-18', '2015-02');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_custcon`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��ϵ��' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_custcon`
--

INSERT INTO `v2_custcon` (`id`, `xingming`, `jcid`, `jcname`, `sex`, `bumen`, `phone`, `email`, `qq`, `name`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, '������', 1, '���Ƹ����ѿƼ����޹�˾', '��', '��Ŀ������', '13812345262', 'pinkecn!@q.com', '151212', '', 'fsdfds', 1, '�¸���', '2015-03-04 10:58:57', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_custgd`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='������¼' AUTO_INCREMENT=5 ;

--
-- ת����е����� `v2_custgd`
--

INSERT INTO `v2_custgd` (`id`, `jcid`, `jcname`, `type`, `fenlei`, `xcrq`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `value`) VALUES
(1, 1, '���Ƹ����ѿƼ����޹�˾', '�绰', 'ѡ��Ƚ�', '2015-03-18', 1, '�¸���', '2015-03-04 11:43:26', 1, '�¸���', '2015-03-04 12:12:27', 1, '���ڶԱ�'),
(2, 1, '���Ƹ����ѿƼ����޹�˾', '���Űݷ�', '�������', '2015-03-19', 1, '�¸���', '2015-03-04 11:46:24', 0, '', '0000-00-00 00:00:00', 1, '�����'),
(3, 1, '���Ƹ����ѿƼ����޹�˾', '���Űݷ�', '�ɽ��ͻ�', '0000-00-00', 1, '�¸���', '2015-03-04 12:14:45', 1, '�¸���', '2015-03-04 12:29:53', 1, '�㶨��'),
(4, 3, '��Ѷ��˾', '���Űݷ�', '�ɽ��ͻ�', '2015-03-18', 1, '�¸���', '2015-03-06 20:26:22', 0, '', '0000-00-00 00:00:00', 1, '');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_doc`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�ҵ��ĵ�' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_doc`
--

INSERT INTO `v2_doc` (`id`, `title`, `fenlei`, `beizhu`, `attid`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 'Ӫҵִ��', '��˾֤��', '&lt;p&gt;\r\n	2015���°�Ӫҵִ��\r\n&lt;/p&gt;', 1425355425, '', '', 1, '�¸���', '2015-03-03 12:05:32', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_files`
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
-- ת����е����� `v2_files`
--

INSERT INTO `v2_files` (`id`, `attid`, `folder`, `filename`, `filetype`, `filedesc`, `uid`, `addtime`, `status`) VALUES
(13, 1425098978, 'Uploads/Public/2015-02-28/', '54f14a7a3e337.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-28 12:56:26', 1),
(14, 1425098978, 'Uploads/Public/2015-02-28/', '54f14ee44249d.pdf', 'pdf', '�������ñ���.pdf', '1', '2015-02-28 13:15:16', 1),
(12, 1425045333, 'Uploads/Public/2015-02-27/', '54f011e1e3141.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-27 14:42:41', 1),
(15, 1425101764, 'Uploads/Public/2015-02-28/', '54f153f339efa.jpg', 'jpg', 'weixin.jpg', '1', '2015-02-28 13:36:51', 1),
(16, 1425131004, 'Uploads/Public/2015-02-28/', '54f1c9cd5bc18.pdf', 'pdf', '�������ñ���.pdf', '1', '2015-02-28 21:59:41', 1),
(17, 1425279910, 'Uploads/Public/2015-03-02/', '54f40d05a1d47.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-02 15:11:01', 1),
(18, 1425355425, 'Uploads/Public/2015-03-03/', '54f53309dc338.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-03 12:05:29', 1),
(19, 1425799502, 'Uploads/Public/2015-03-10/', '54fe8f5edec94.jpg', 'jpg', 'weixin.jpg', '1', '2015-03-10 14:29:50', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_fu`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�����¼' AUTO_INCREMENT=4 ;

--
-- ת����е����� `v2_fu`
--

INSERT INTO `v2_fu` (`id`, `addm`, `jhid`, `jhname`, `type`, `fenlei`, `bianhao`, `jine`, `juid`, `juname`, `beizhu`, `uid`, `uuname`, `uname`, `addtime`, `uuid`, `updatetime`, `status`, `attid`) VALUES
(1, '2015-03', 4, '����������', '�ֽ�', '���÷�', '10021', 500, 3, '������', '�����', 1, '�¸���', '�¸���', '2015-03-08 12:24:40', 1, '2015-03-08 15:14:42', 1, 0),
(2, '2015-03', 4, '����������', '��˾�˺�ת��', '�칫��', '1000', 200, 3, '������', '111', 1, '�¸���', '�¸���', '2015-03-08 12:38:00', 1, '2015-03-08 15:14:34', 1, 0),
(3, '2015-03', 4, '����������', '�ֽ�', '����', '1022', 100, 3, '������', '12233', 1, '�¸���', '�¸���', '2015-03-08 12:41:07', 1, '2015-03-08 15:14:15', 1, 0);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hetong`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��ͬ����' AUTO_INCREMENT=5 ;

--
-- ת����е����� `v2_hetong`
--

INSERT INTO `v2_hetong` (`id`, `bianhao`, `title`, `jcid`, `jcname`, `xingming`, `dianhua`, `jine`, `yishou`, `weishou`, `yikai`, `fukuan`, `dqrq`, `name`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `beizhu`, `attid`, `addm`, `status`) VALUES
(1, '2015030801', '��������', 1, '���Ƹ����ѿƼ����޹�˾', '������', '1382532612', 20000, 0, 0, 0, 0, '2015-02-18', '������', '3,2,1', '������,���ϼ,�¸���', 1, '�¸���', '2015-02-01 16:44:35', 2, '���ϼ', '2015-03-08 10:22:20', '', 1422780234, '2015-01', 1),
(2, '2002', '�������', 1, '���Ƹ����ѿƼ����޹�˾', '������', '1382256223', 15620, 0, 0, 0, 0, '2015-04-16', '�¸���', '', '', 1, '�¸���', '2015-02-01 16:45:34', 1, '�¸���', '2015-03-07 17:16:02', '', 1422780295, '2015-01', 1),
(3, '', '', 3, '��Ѷ��˾', '', '', 30150, 0, 0, 0, 0, '2015-05-06', '�¸���', '', '', 1, '�¸���', '2015-03-06 16:46:43', 1, '�¸���', '2015-03-06 17:18:58', '1212', 1425631574, '2015-03', 1),
(4, '2015030812', '����������', 1, '���Ƹ����ѿƼ����޹�˾', '�¸���', '13812349563', 15000, 15000, 0, 15000, 800, '2015-04-30', '������', '2', '���ϼ', 1, '�¸���', '2015-03-08 10:45:14', 1, '�¸���', '2015-03-08 10:45:23', '������', 1425782628, '2015-03', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hr`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Ա������' AUTO_INCREMENT=4 ;

--
-- ת����е����� `v2_hr`
--

INSERT INTO `v2_hr` (`id`, `xingming`, `sex`, `shengri`, `xuexiao`, `xueli`, `addtime`, `jiadizhi`, `beizhu`, `status`, `updatetime`, `uid`, `gonghao`, `bumen`, `zhiwei`, `shenfenzheng`, `jiankang`, `hunyin`, `minzu`, `jiguan`, `zhengzhi`, `rudang`, `hukou`, `hukoudi`, `jiadianhua`, `type`, `ruzhi`, `zaizhi`, `lizhi`, `biye`, `xuewei`, `zhuanye`, `uname`, `uuid`, `uuname`, `shehui`, `xuexi`, `gongzuo`, `jineng`, `attid`, `birthday`) VALUES
(1, '�¸���', '��', '1982-02-01', '������ѧ', '����', '2015-02-28 21:46:41', '���Ƹ��й�����', '&lt;p&gt;\r\n	����\r\n&lt;/p&gt;', 1, '2015-03-06 12:25:11', 1, '1001', '�ۺϰ칫��', '�ܾ���', '320821198202013562', '����', '�ѻ�', '����', '����ʡ������', 'Ⱥ��', '0000-00-00', '���س������', '���Ƹ��к�����', '0518526525', '��ʽԱ��', '2007-01-01', '��ְ', '0000-00-00', '2004-07-01', 'ѧʿ', '���̹���', '�¸���', 1, '�¸���', '', '������ѧ', '������', 'ʲô����һ��', 1425131004, '02'),
(2, '������', '��', '1987-03-04', '', '����', '2015-03-01 16:10:54', '', '', 1, '2015-03-06 12:07:17', 1, '1003', '�ۺϰ칫��', '�칫������', '320822198202013030', '����', 'δ��', '����', '����ʡ���Ƹ���', 'Ⱥ��', '2015-03-01', '���س������', '', '', '��ʽԱ��', '2014-03-01', '��ְ', '0000-00-00', '0000-00-00', 'ѧʿ', '��������', '�¸���', 1, '�¸���', '', '', '', '', 1425197393, '03'),
(3, '������', 'Ů', '2015-02-06', '', '˶ʿ', '2015-03-06 16:00:43', '', '', 1, '2015-03-06 16:01:20', 1, '1005', '����', '���', '32082219252323', '����', 'δ��', '', '', '��Ա', '2015-03-06', '���س������', '', '', '��ʽԱ��', '0000-00-00', '��ְ', '0000-00-00', '2015-03-06', '˶ʿ', '���̹���', '�¸���', 1, '�¸���', '', '', '', '', 1425628757, '');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrdd`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='���µ���' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_hrdd`
--

INSERT INTO `v2_hrdd` (`id`, `juid`, `juname`, `title`, `type`, `ddrq`, `sxrq`, `bumen`, `hbumen`, `zhiwei`, `hzhiwei`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '������', '��ְ��', '����', '2015-03-01', '2015-03-01', '', '', '��Ա', '�칫������', '����', 1425213031, 1, '�¸���', '2015-03-01 20:31:30', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrgh`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Ա���ػ�' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_hrgh`
--

INSERT INTO `v2_hrgh` (`id`, `juid`, `juname`, `title`, `type`, `sj`, `feiyong`, `name`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '������', '�����ͺ��', '����', '2015-02-18', '500', '�ܺð�', '�෢��', 1425214124, 1, '�¸���', '2015-03-01 20:49:18', 1, '�¸���', '2015-03-02 11:28:29', 1),
(2, 1, '�¸���', '������Ʒ', '����', '2015-03-02', '500', '�ܹ�Ŷ', '�ط�', 1425266572, 1, '�¸���', '2015-03-02 11:23:21', 1, '�¸���', '2015-03-02 11:23:21', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrht`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='���º�ͬ' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_hrht`
--

INSERT INTO `v2_hrht` (`id`, `juid`, `juname`, `title`, `bianhao`, `type`, `kssj`, `jsrj`, `jcrq`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 1, '�¸���', '2015-2018���Ͷ���ͬ', '201020100', '�����ͬ', '2015-03-01', '2015-03-05', '0000-00-00', '��ͬ������', 1425186778, 1, '�¸���', '2015-03-01 13:13:37', 1, '�¸���', '2015-03-06 12:36:32', 1),
(2, 2, '������', '2015-2018���Ͷ���ͬ', '20002111', '�����ͬ', '2015-03-02', '2018-03-03', '0000-00-00', '��ͬ����', 1425267063, 1, '�¸���', '2015-03-02 11:31:40', 1, '�¸���', '2015-03-02 11:32:04', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrjf`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��������' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_hrjf`
--

INSERT INTO `v2_hrjf` (`id`, `juid`, `juname`, `type`, `title`, `sxrq`, `jine`, `gongzi`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 1, '�¸���', '����', '������֤���ӹ���', '2015-03-01', '2000', '2015-03-01', '������֤���ӹ���', 1425196856, 1, '�¸���', '2015-03-01 16:01:37', 0, '', '0000-00-00 00:00:00', 1),
(2, 1, '�¸���', '����', '������һ�꣬�ǹ���', '2015-03-01', '500', '2015-03-01', '&lt;strong&gt;������һ�꣬�ǹ���&lt;/strong&gt;', 1425197524, 1, '�¸���', '2015-03-01 16:12:32', 2, '���ϼ', '2015-03-10 10:26:34', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrpx`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��ѵ����' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_hrpx`
--

INSERT INTO `v2_hrpx` (`id`, `juid`, `juname`, `title`, `feiyong`, `kssj`, `jssj`, `zhengshu`, `didian`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '������', '�������ȫԱ', '2000', '2015-03-01', '2015-03-18', '�������ȫԱ����֤��', '�Ͼ�', '����˵��', 1425211748, 1, '�¸���', '2015-03-01 20:10:02', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_hrzz`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='֤�չ���' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_hrzz`
--

INSERT INTO `v2_hrzz` (`id`, `juid`, `juname`, `title`, `bianhao`, `type`, `sxrq`, `jsrq`, `qzrq`, `danwei`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 2, '������', '��ʻ֤', '10202020', '��ʻ֤', '2015-03-01', '2015-03-01', '2015-03-01', '', '��˹�ٷ�', 1425203786, 1, '�¸���', '2015-03-01 17:56:55', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_huo`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='������¼' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_huo`
--

INSERT INTO `v2_huo` (`id`, `jhid`, `jhname`, `title`, `name`, `juid`, `juname`, `beizhu`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, 4, '����������', '��Ʊ���', '��ͨ���5262212212', 3, '������', '����˵��', 1, '�¸���', '2015-03-08 14:47:56', 0, '', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_info`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='֪ͨ����' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_info`
--

INSERT INTO `v2_info` (`id`, `juid`, `juname`, `title`, `value`, `attid`, `hui`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `jzrq`) VALUES
(1, '1,3,2', '�¸���,������,���ϼ', '3.8�3.8�3.8�3.8�3.8�3.8�', '3.8�', 1425283352, '\r\n�¸���:֧�֣�2015-03-02 16:03:53\r\n���ϼ:2015-03-10 10:25:29', 1, '�¸���', '2015-03-02 16:03:02', 2, '���ϼ', '2015-03-10 10:25:29', 1, '2015-03-08'),
(2, '4,3,2,1', '������,������,���ϼ,�¸���', '�ͻ��طù�������', '�ͻ��طù�������', 1426477450, '', 1, '�¸���', '2015-03-16 11:44:47', 0, '', '0000-00-00 00:00:00', 1, '2015-03-18');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_log`
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
-- ��Ľṹ `v2_menu`
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
-- ת����е����� `v2_menu`
--

INSERT INTO `v2_menu` (`id`, `level`, `pid`, `catename`, `alink`, `sort`, `status`) VALUES
(1, 0, 0, '������', 'stock/index', 2, 1),
(2, 0, 0, '���˰칫', 'office/index', 0, 1),
(3, 0, 0, '�ͻ�����', 'Cust/index', 3, 1),
(4, 0, 0, '���¹���', 'hr/index', 4, 1),
(8, 1, 2, '�ҵ�����', 'mytask/index', 1, 1),
(7, 0, 0, 'ϵͳ����', 'system/index', 99, 1),
(9, 1, 7, '��֯����', 'org/index', 1, 1),
(10, 2, 9, 'ְλ����', 'dep/index', 2, 1),
(11, 2, 22, '�˵�����', 'menu/index', 4, 1),
(12, 1, 2, '�ҵ�ȥ��', 'mygo/index', 0, 1),
(13, 1, 7, '������־', 'Log/index', 7, 1),
(14, 2, 9, '�û�����', 'user/index', 3, 1),
(21, 1, 7, '�����ļ�', 'database/bakup', 5, 1),
(20, 2, 22, '����ģ��', 'model/index', 3, 1),
(19, 2, 22, '�����б�', 'rule/index', 5, 1),
(22, 1, 7, 'ϵͳ����', 'system/index', 1, 1),
(23, 2, 9, '���Ź���', 'org/index', 0, 1),
(24, 1, 7, '���ݱ���', 'Database/index', 4, 1),
(25, 1, 1, '��Ʒ��Ϣ', 'pro/index', 1, 1),
(26, 1, 1, '������', 'stock/index', 5, 1),
(27, 1, 2, 'ͨѶ¼', 'contact/index', 9, 1),
(28, 1, 2, 'ָ������', 'task/index', 1, 1),
(29, 2, 27, '�ҵ�ͨѶ¼', 'contact/index', 1, 1),
(30, 2, 27, '����ͨѶ¼', 'pcontact/index', 2, 1),
(31, 2, 22, '�����ֵ�', 'config/index', 1, 1),
(32, 1, 1, '�����¼', 'proout/index', 3, 1),
(33, 1, 2, 'Ա��ȥ��', 'mygos/index', 0, 1),
(34, 1, 2, '�ҵĹ����㱨', 'myreport/index', 2, 1),
(35, 1, 4, 'Ա������', 'hr/index', 1, 1),
(36, 1, 4, '���º�ͬ', 'hrht/index', 2, 1),
(37, 1, 4, '��������', 'hrjf/index', 3, 1),
(38, 1, 4, '֤�չ���', 'hrzz/index', 4, 1),
(39, 1, 4, '��ѵ����', 'hrpx/index', 5, 1),
(40, 1, 2, '֪ͨ����', 'info/index', 8, 1),
(41, 2, 40, '��֪ͨ', 'info/index', 1, 1),
(42, 2, 40, '��֪ͨ', 'myinfo/index', 2, 1),
(43, 1, 4, '���µ���', 'hrdd/index', 8, 1),
(44, 1, 2, '�ҵ��ĵ�', 'doc/index', 5, 1),
(45, 1, 3, '��ͬ����', 'hetong/index', 4, 1),
(46, 2, 27, '��˾ͨѶ¼', 'ccontact/index', 3, 1),
(47, 1, 2, '֪ʶ����', 'zhishi/index', 5, 1),
(48, 1, 4, 'Ա���ػ�', 'hrgh/index', 10, 1),
(49, 1, 3, '�ͻ���Ϣ', 'cust/index', 1, 1),
(50, 1, 3, '��ϵ��', 'custcon/index', 2, 1),
(51, 1, 3, '������¼', 'custgd/index', 3, 1),
(52, 1, 2, '��ע�����㱨', 'report/index', 2, 1),
(53, 1, 4, 'ͳ�Ʒ���', 'hr/index', 20, 1),
(54, 2, 53, '������������', 'hr/birthday', 0, 1),
(55, 2, 53, '�������ڵĺ�ͬ', 'hrht/daoqi', 2, 1),
(56, 2, 53, 'Ա������', 'hr/fenxi', 3, 1),
(57, 1, 3, 'ͳ�Ʒ���', 'cust/index', 10, 1),
(58, 2, 57, '�ͻ�����', 'cust/fenxi', 1, 1),
(59, 2, 57, '�����ͬ��������', 'htfenxi/index', 2, 1),
(60, 2, 57, '�������ڵĺ�ͬ', 'hetong/daoqi', 7, 1),
(61, 2, 57, '��Ҫ���ٵĿͻ�', 'cust/daoqi', 10, 1),
(62, 1, 1, '����¼', 'proin/index', 2, 1),
(63, 1, 1, '��汨��', 'stock/baojing', 5, 1),
(64, 1, 3, '�տ��¼', 'shou/index', 5, 1),
(65, 1, 3, '�����¼', 'fu/index', 6, 1),
(66, 0, 0, '�������', 'shou/index', 5, 1),
(67, 1, 66, '�տ��¼', 'shou/index', 1, 1),
(68, 1, 66, '�����¼', 'fu/index', 2, 1),
(69, 1, 3, '��Ʊ��¼', 'piao/index', 7, 1),
(70, 1, 3, '������¼', 'huo/index', 8, 1),
(71, 1, 66, '��Ʊ��¼', 'piao/index', 3, 1),
(72, 2, 57, 'ȥ���ͬ��������', 'htfenxi/lastyear', 5, 1),
(73, 2, 57, 'ҵ��Ա����', 'htfenxi/yewuyuan', 4, 1);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_mygo`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�ҵ�ȥ��' AUTO_INCREMENT=6 ;

--
-- ת����е����� `v2_mygo`
--

INSERT INTO `v2_mygo` (`jssj`, `kssj`, `id`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `bumen`) VALUES
('2015-02-28 18:00:00', '2015-02-28 14:00:00', 1, 'ȥ���ݿ������ݷÿͻ����������ֱ�Ӵ��ҵ绰Ŷ��лл������������֮ǰ����,', 1, '�¸���', '2015-02-27 20:56:12', 1, '�¸���', '2015-02-28 15:20:05', 1, '�ۺϰ칫��'),
('2015-03-09 17:04:54', '2015-03-09 11:04:49', 2, 'ȥ�ɹ��칫��Ʒ', 4, '������', '2015-03-09 11:04:20', 0, '', '0000-00-00 00:00:00', 1, '�г���'),
('2015-03-10 11:50:37', '2015-03-09 11:50:29', 3, 'ȥ�ݷÿͻ�', 1, '�¸���', '2015-03-09 11:49:59', 0, '', '0000-00-00 00:00:00', 1, '�ۺϰ칫��'),
('2015-03-09 11:53:32', '2015-03-09 11:53:30', 4, 'ȥ�ɹ����', 2, '���ϼ', '2015-03-09 11:52:48', 2, '���ϼ', '2015-03-09 12:00:45', 1, '�ۺϰ칫��'),
('2015-03-11 12:15:58', '2015-03-09 12:15:55', 5, '��س���', 2, '���ϼ', '2015-03-09 12:13:08', 0, '', '0000-00-00 00:00:00', 1, '�ۺϰ칫��');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_piao`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��Ʊ��¼' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_piao`
--

INSERT INTO `v2_piao` (`id`, `jhid`, `jhname`, `title`, `jine`, `bianhao`, `beizhu`, `juid`, `juname`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `addm`) VALUES
(2, 4, '����������', '���Ƹ����ѿƼ����޹�˾', 15000, '152252', '152622', 3, '������', 1, '�¸���', '2015-03-08 13:07:46', 0, '', '0000-00-00 00:00:00', 1, '2015-03');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_pro`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='��Ʒ����' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_pro`
--

INSERT INTO `v2_pro` (`id`, `name`, `fenlei`, `jiage`, `type`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `beizhu`, `sjiage`, `kucun`, `ruku`, `chuku`, `tuiku`) VALUES
(1, '��ӡֽ', '�칫��Ʒ', 95, 'ֻ', '10��/��', 1, '�¸���', '2015-03-07 15:39:21', 0, '', '0000-00-00 00:00:00', 1, '&lt;p&gt;\r\n	����\r\n&lt;/p&gt;', 0, 150, 150, 0, 0),
(2, '���ܹ�', '�������', 0, '��', '����װ', 1, '�¸���', '2015-03-07 17:15:03', 0, '', '0000-00-00 00:00:00', 1, '����˵��', 500, 6, 95, 89, 0);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_proin`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='����¼' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_proin`
--

INSERT INTO `v2_proin` (`id`, `jpid`, `jpname`, `jpjiage`, `jpdanwei`, `jpguige`, `shuliang`, `title`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `juid`, `juname`) VALUES
(1, 1, '��ӡֽ', 0, 'ֻ', '10��/��', 100, '�ɹ�', 1, '�¸���', '2015-03-07 17:08:43', 1, '�¸���', '2015-03-08 10:54:29', 1, 2, '���ϼ'),
(2, 2, '���ܹ�', 500, '��', '����װ', 100, '�ɹ�', 1, '�¸���', '2015-03-07 17:18:01', 1, '�¸���', '2015-03-08 10:54:21', 1, 2, '���ϼ');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_proout`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�����¼' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_proout`
--

INSERT INTO `v2_proout` (`id`, `jpid`, `jpname`, `jpjiage`, `jpdanwei`, `jpguige`, `shuliang`, `title`, `uid`, `uname`, `addtime`, `uuid`, `juid`, `juname`, `jhid`, `jhname`, `status`, `uuname`, `updatetime`) VALUES
(1, 2, '���ܹ�', 500, '��', '����װ', 6, '��ͬ��Ҫ', 1, '�¸���', '2015-03-07 19:31:19', 0, 3, '������', 2, '�������', 1, '', '0000-00-00 00:00:00'),
(2, 2, '���ܹ�', 500, '��', '����װ', 65, '���ͬ', 1, '�¸���', '2015-03-07 19:43:52', 0, 3, '������', 2, '�������', 1, '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_report`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�����㱨' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_report`
--

INSERT INTO `v2_report` (`id`, `uid`, `uname`, `type`, `title`, `value`, `attid`, `uuid`, `uuname`, `addtime`, `updatetime`, `beizhu`, `status`, `juid`, `juname`) VALUES
(1, 1, '�¸���', '���ܽ�', '�㱨һ�ܹ������', '�㱨һ�ܹ������', 1425702698, 2, '���ϼ', '2015-03-07 12:32:02', '2015-03-10 10:25:13', '\r\n�¸���:tinghao2015-03-07 13:14:33\r\n�¸���:������2015-03-07 14:03:11\r\n���ϼ:2015-03-10 10:25:13', 1, '2', '���ϼ');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_shou`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�տ��¼' AUTO_INCREMENT=3 ;

--
-- ת����е����� `v2_shou`
--

INSERT INTO `v2_shou` (`id`, `jhid`, `jhname`, `type`, `bianhao`, `jine`, `juid`, `juname`, `beizhu`, `uid`, `uuname`, `uname`, `addtime`, `uuid`, `updatetime`, `status`, `addm`, `attid`) VALUES
(1, 4, '����������', '�ֽ�', '102020100', 5000, 2, '���ϼ', 'ҵ���տ�', 1, '�¸���', '�¸���', '2015-03-08 11:48:24', 1, '2015-03-09 10:20:06', 1, '2015-03', 0),
(2, 4, '����������', '��˾�˺�', '520120', 10000, 3, '������', 'β���˾�˺�1', 1, '�¸���', '�¸���', '2015-03-08 11:51:55', 1, '2015-03-09 10:20:14', 1, '2015-02', 0);

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_task`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='�������' AUTO_INCREMENT=6 ;

--
-- ת����е����� `v2_task`
--

INSERT INTO `v2_task` (`id`, `juid`, `kssj`, `juname`, `jssj`, `title`, `beizhu`, `zhuangtai`, `wancheng`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`, `jhid`, `jhname`) VALUES
(1, '4,3,2,1', '2015-03-08 15:25:13', '������,������,���ϼ,�¸���', '2015-03-08 15:25:16', '��������ã���Ҫ����', '12125152', '�����', '\r\n�¸���:�õġ�׼������2015-03-08 16:06:03\r\n���ϼ:2015-03-10 09:01:36\r\n���ϼ:2015-03-10 10:25:01', 1425799502, 1, '�¸���', '2015-03-08 15:25:51', 1, '�¸���', '2015-03-16 11:45:33', 1, 4, '����������'),
(2, '1', '2015-03-15 11:46:39', '�¸���', '2015-03-17 11:46:44', '�Կͻ�����ĸĽ�������д���', '', '������', '\r\n�¸���:12122015-03-16 11:48:18', 1426477583, 1, '�¸���', '2015-03-16 11:47:36', 1, '�¸���', '2015-03-16 11:48:18', 1, 0, ''),
(3, '4,3,2,1', '2015-03-16 11:49:40', '������,������,���ϼ,�¸���', '2015-03-16 11:49:44', '�¶�����˾�����������ͬ��ҪǩԼ', '', '������', '\r\n�¸���:122015-03-16 11:50:42', 1426477765, 1, '�¸���', '2015-03-16 11:50:19', 1, '�¸���', '2015-03-16 11:50:42', 1, 0, ''),
(4, '4,3,2,1', '2015-03-17 11:51:55', '������,������,���ϼ,�¸���', '2015-03-18 11:51:59', '������׼�����װ�����������', '����˵��', '������', '\r\n�¸���:122015-03-16 11:54:02', 1426477899, 1, '�¸���', '2015-03-16 11:52:23', 1, '�¸���', '2015-03-16 11:54:02', 1, 4, '����������'),
(5, '4,3,2,1', '2015-03-15 11:53:08', '������,������,���ϼ,�¸���', '2015-03-17 11:53:11', 'ȥ�ɹ����', '', '������', '\r\n�¸���:122015-03-16 11:53:53', 1426477964, 1, '�¸���', '2015-03-16 11:53:44', 1, '�¸���', '2015-03-16 11:53:53', 1, 1, '��������');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_user`
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
-- ת����е����� `v2_user`
--

INSERT INTO `v2_user` (`id`, `username`, `password`, `memo`, `depname`, `posname`, `truename`, `sex`, `tel`, `phone`, `neixian`, `email`, `qq`, `logintime`, `loginip`, `logins`, `status`, `update_time`, `bian`) VALUES
(1, 'admin', '14e1b600b1fd579f47433b88e8d85291', '74870e1114ddb042052b11710f2e1316', '�ۺϰ칫��', '�ܾ���', '�¸���', '��', '8552646', '13812349563', '6535665', 'pinkecn@qq.com', '1612985', '2015-03-29 12:01:25', '127.0.0.1', 360, 1, 1427601685, 'ȥ�ɹ��칫��Ʒ��ֽ�ţ�ī��\r\n�ͻ������������\r\n���ܽ��'),
(3, 'liuxing88', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '����', '���', '������', '��', '52', '5', '', '2', '2', '2015-03-08 20:45:18', '0.0.0.0', 2, 1, 1425818718, ''),
(2, 'liuxing99', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '�ۺϰ칫��', '�ܾ���', '���ϼ', '��', '552', '525', '', 'pinkecn@qq.com', '16212', '2015-03-13 10:02:44', '61.139.126.203', 46, 1, 1426212164, '51212ssss'),
(4, 'liuxing77', '14e1b600b1fd579f47433b88e8d85291', 'a48dfea1c806d4a03b850f67542363fb', '�г���', '��Ա', '������', 'Ů', '135121', '11212', '', '1212', '1212121', '2015-03-09 11:03:29', '118.123.16.120', 5, 1, 1425870296, '1521');

-- --------------------------------------------------------

--
-- ��Ľṹ `v2_zhishi`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='֪ʶ����' AUTO_INCREMENT=2 ;

--
-- ת����е����� `v2_zhishi`
--

INSERT INTO `v2_zhishi` (`id`, `title`, `type`, `beizhu`, `attid`, `uid`, `uname`, `addtime`, `uuid`, `uuname`, `updatetime`, `status`) VALUES
(1, '��������˹�ٷ�', '��Ʒ֪ʶ', '����˵��', 1425357503, 1, '�¸���', '2015-03-03 12:38:58', 0, '', '0000-00-00 00:00:00', 1);
