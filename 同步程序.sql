set @depid=2; -- 2
set @depname='建外SOHO'; -- 建外SOHO
set @depusername='VOGUE926'; -- VOGUE926
-- 修复旧数据 
ALTER TABLE Goods ADD fenlei VARCHAR(20); -- 增加分类 对应Categoryid
ALTER TABLE Goods ADD cname VARCHAR(50); -- 供应商名字 同步v2crm
ALTER TABLE Goods ADD phone VARCHAR(50); -- 供应商电话
ALTER TABLE Goods ADD type VARCHAR(20); -- 寄售  自有
ALTER TABLE Goods ADD status1 VARCHAR(20); -- 状态
ALTER TABLE Goods ADD paystatus VARCHAR(20); -- 未打款  已打款
ALTER TABLE Goods ADD uname VARCHAR(50); -- 添加人
ALTER TABLE Goods ADD uuname VARCHAR(50);-- 修改人
ALTER TABLE Goods ADD paytypein VARCHAR(50); -- 进货付款方式
ALTER TABLE Goods ADD paytypeout VARCHAR(50);-- 出货付款方式
ALTER TABLE Goods ADD scname VARCHAR(100); -- 顾客名
ALTER TABLE Goods ADD scphone VARCHAR(100); -- 顾客联系方式
-- 修改目标数据库 只执行一次
ALTER TABLE v2crm.v2_pro ADD imgpath VARCHAR(100); -- v2crm 中添加一列，用于存放图片地址
ALTER TABLE v2crm.v2_cust MODIFY COLUMN phone VARCHAR(50); -- 
ALTER TABLE v2crm.v2_cust MODIFY COLUMN dizhi VARCHAR(200) NULL;
ALTER TABLE v2crm.v2_user MODIFY COLUMN phone VARCHAR(20);
ALTER TABLE v2crm.v2_proin MODIFY COLUMN `remark` VARCHAR(100) NULL;

-- 更新分类
UPDATE Goods INNER JOIN Category ON Goods.CategoryId = Category.Id
SET Goods.fenlei = Category.`Name`;

-- 更新供应商名字 电话
UPDATE Goods INNER JOIN Supplier ON Goods.SupplierId = Supplier.Id
SET Goods.cname = Supplier.`Name`, Goods.Phone = Supplier.Phone;

-- 更新商品类型
UPDATE Goods
SET type = (CASE SourceType WHEN 1 THEN '寄售' ELSE '进货' END),
status1 = (CASE `Status` WHEN 1 THEN '在库' WHEN 2 THEN '预订' WHEN 3 THEN '售出' ELSE '取回' END),
paystatus = (CASE Paid WHEN 1 THEN '已打款' ELSE '未打款' END),
Image = (CASE Image WHEN '' THEN NULL ELSE Image END);

-- 添加人
UPDATE Goods INNER JOIN PurchaseRecord on Goods.Id = PurchaseRecord.GoodsId
SET Goods.uname = PurchaseRecord.Operator;

-- 更新人
UPDATE Goods INNER JOIN SaledRecord on Goods.id = SaledRecord.GoodsId
SET Goods.uuname = SaledRecord.Operator;

-- 更新进货记录 1、现金；2、汇款；3、信用卡；4、网银转帐；
UPDATE Goods INNER JOIN PurchaseRecord on Goods.Id = PurchaseRecord.GoodsId
SET paytypein = CASE PurchaseRecord.PayType 
									WHEN 1 THEN '现金'
									WHEN 2 THEN '汇款'
									WHEN 3 THEN '信用卡'
									WHEN 4 THEN '网银转帐'
									ELSE NULL END;

-- 更新销售记录 1、现金；2、汇款；3、信用卡；4、网银转帐；
UPDATE Goods INNER JOIN SaledRecord on Goods.Id = SaledRecord.GoodsId
SET paytypeout = CASE SaledRecord.PayType 
									WHEN 1 THEN '现金'
									WHEN 2 THEN '汇款'
									WHEN 3 THEN '信用卡'
									WHEN 4 THEN '网银转帐'
									ELSE NULL END;

-- 同步旧库到新库

-- 同步用户
DELETE FROM `User` WHERE `Name` = 'admin';
DELETE FROM `User` WHERE Phone in ( SELECT phone FROM v2crm.v2_user WHERE v2crm.v2_user.depname = @depname); -- 删除v2crm中已存在的用户

INSERT INTO v2crm.v2_user(`username`, `password`, depname, posname, truename, sex, phone, `status`)
SELECT a.`Name`, '14e1b600b1fd579f47433b88e8d85291',@depname, CASE a.RoleId WHEN 2 THEN '店长' ELSE '店员' END,
a.RealName, CASE a.Sex WHEN 1 THEN '男' ELSE '女' END, a.Phone, 1
FROM `User` a;

-- 供应商

-- 删除重复数据 修改店名，默认操作用户名
DELETE FROM Supplier WHERE Id not in ( SELECT * FROM( SELECT MIN(Id) FROM Supplier GROUP BY Phone) a); -- 删除供应商表中重复的记录
DELETE FROM Supplier WHERE Phone in ( SELECT phone FROM v2crm.v2_cust); -- 删除v2crm中已存在的供应商
-- 同步供应商
INSERT INTO v2crm.v2_cust(`name`, phone, `status`, `remark`, dizhi, sex, yhname, yhcard, idcard, `type`, juid, juname, uid, uname, addtime)
SELECT a.`Name`, a.Phone, 1, '', a.Address, CASE a.Sex WHEN 0 THEN '未知' WHEN 1 THEN '男' ELSE '女' END,
a.BankName, a.BankCard, a.IdCard, '', b.id, b.username, b.id, b.username, a.CreatedDate
FROM Supplier a, v2crm.v2_user b
WHERE b.username = @depusername;
-- 
-- 商品信息
INSERT INTO v2crm.v2_pro (depid, `name`, fenlei, pinpai, `code`, jcode, cid, cname, type, color, chengse, bujian, jiage, bjiage, 
sjiage, yufu, zhekou, `status`, paystatus, `remark`, starttime, endtime, outtime, uid, uname, addtime, uuid, uuname,updatetime,imgpath)
select @depid, a.`Name`, a.fenlei, '', a.`Code`, a.OriginalCode,
(SELECT b.id FROM v2crm.v2_cust b WHERE b.phone = a.phone LIMIT 1),a.cname,
a.type,a.Color,a.Quality,a.Parts,
CASE WHEN ISNULL(a.PrimePrice) THEN 0 ELSE a.PrimePrice END,
CASE WHEN ISNULL(a.MarkPrice) THEN 0 ELSE a.MarkPrice END,
CASE WHEN ISNULL(a.SalePrice) THEN 0 ELSE a.SalePrice END,
CASE WHEN ISNULL(a.Prepay) THEN 0 ELSE a.Prepay END,
CASE WHEN ISNULL(a.Discount) THEN 0 ELSE a.Discount END,
a.status1,a.paystatus, a.Desc, a.ConsignStartDate, a.ConsignEndDate, a.SaledDate,
(SELECT c.id FROM v2crm.v2_user c WHERE c.depname = @depname AND c.username = a.uname LIMIT 1), a.uname,
a.CreatedDate,
(SELECT d.id FROM v2crm.v2_user d WHERE d.depname = @depname AND d.username = a.uuname LIMIT 1), a.uuname,
a.UpdatedDate,
CASE WHEN ISNULL(a.Image) THEN NULL ELSE  CONCAT('./Uploads/',@depid,'/2017-11/',a.Image,'.jpg') END
from Goods a;
-- 
-- 同步进货记录

INSERT INTO v2crm.v2_proin (jpid, jpname, depid, jpjiage, paytype, `remark`, juid, juname, uid, uname, addtime, updatetime)
SELECT
(SELECT c.id FROM v2crm.v2_pro c WHERE c.depid = @depid AND c.`code` = b.`Code` LIMIT 1),b.`Name`, @depid, b.PrimePrice, b.paytypein, b.`Desc`,
(SELECT d.id FROM v2crm.v2_user d WHERE d.depname = @depname AND d.username = a.Operator LIMIT 1), a.Operator,
(SELECT d.id FROM v2crm.v2_user d WHERE d.depname = @depname AND d.username = a.Operator LIMIT 1), a.Operator,
a.CreatedDate, b.UpdatedDate
FROM PurchaseRecord a INNER JOIN Goods b ON a.GoodsId = b.Id
-- 
-- 
-- 
-- 同步售出记录
INSERT INTO v2crm.v2_proout(jpid, jpname, depid, jpsjiage, paytype, custname, custphone, beizhu, juid, juname, uid, uname, addtime)
SELECT 
(SELECT c.id FROM v2crm.v2_pro c WHERE c.depid = @depid AND c.`code` = b.`Code` LIMIT 1), b.`Name`,@depid, b.SalePrice, b.paytypeout, a.CustomerName, a.CustomerPhone,a.Remark,
(SELECT c.id FROM v2crm.v2_user c WHERE c.depname = @depname AND c.username = a.Operator LIMIT 1), a.Operator,
(SELECT c.id FROM v2crm.v2_user c WHERE c.depname = @depname AND c.username = a.Operator LIMIT 1), a.Operator, a.CreatedDate 
FROM SaledRecord a INNER JOIN Goods b on a.GoodsId = b.Id
WHERE b.`Status` = 3

-- 更新商品图片
INSERT INTO v2crm.v2_files(attid, filename, filetype, uid, uname, addtime)
SELECT a.id, a.imgpath,'jpg',a.uid, a.uname, a.addtime FROM v2crm.v2_pro a WHERE a.depid = @depid AND a.imgpath is not NULL 