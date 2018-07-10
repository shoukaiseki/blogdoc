---建表---{{{1

事例网址:

https://github.com/shoukaiseki/blogdoc/tree/master/BIRT/%E6%8B%86%E5%88%86%20table%20%E5%92%8C%20cross%20table

相关birt:
拆分合并table.rptdesign


CREATE TABLE TABLETEST_01 
(
  ID NUMBER 
, DANJIA DECIMAL 
, OKANE DECIMAL 
, MEISHOU VARCHAR2(50) 
, TANNKA DECIMAL 
);

COMMENT ON COLUMN TABLETEST_01.MEISHOU IS '姓名';

COMMENT ON COLUMN TABLETEST_01.TANNKA IS '单价';

COMMENT ON COLUMN TABLETEST_01.OKANE IS '金额';



--------------------------------------------------------
--  文件已创建 - 星期三-七月-11-2018   
--------------------------------------------------------
REM INSERTING into TABLETEST_01
SET DEFINE OFF;
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (1,12312,242,'费承颜',4271);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (2,357,2389,'谌问筠',4367);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (3,484,4597,'融鸿波',2397);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (4,215,3873,'莫元旋',3436);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (5,529,893,'鹿悦可',2407);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (6,684,9378,'闳玮奇',2481);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (7,288,6171,'罗以筠',9262);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (8,328,1645,'杨云飞',7740);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (9,587,7412,'杞笑柳',446);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (10,52,6049,'扈修永',9976);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (11,187,4241,'千芮美',206);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (12,582,2278,'狂力夫',687);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (13,967,8938,'乙曼珍',3936);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (14,935,7638,'郁惜蕊',4729);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (15,521,1924,'印昊空',148);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (16,474,8262,'蒙婉丽',3689);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (17,978,3049,'渠苒苒',4321);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (18,177,6154,'五彦芝',2331);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (19,892,8677,'查晶滢',6481);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (20,407,392,'衡听双',2127);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (21,559,8774,'扶巧夏',9695);
Insert into TABLETEST_01 (ID,DANJIA,OKANE,MEISHOU,TANNKA) values (22,608,7697,'邬幼丝',3271);



CREATE TABLE CROSSTEST_01 
(
  ID NUMBER 
, SIYOU VARCHAR2(50) 
, RYOU DECIMAL 
, MEISHOU VARCHAR2(50) 
);

COMMENT ON COLUMN CROSSTEST_01.MEISHOU IS '姓名';

COMMENT ON COLUMN CROSSTEST_01.SIYOU IS '使用';

COMMENT ON COLUMN CROSSTEST_01.RYOU IS '金额';

--------------------------------------------------------
--  文件已创建 - 星期三-七月-11-2018   
--------------------------------------------------------
REM INSERTING into CROSSTEST_01
SET DEFINE OFF;
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (1,'飞机票',4271,'谌问筠');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (2,'飞机票',4367,'谌问筠');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (3,'高铁',2397,'谌问筠');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (4,'高铁',3436,'谌问筠');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (5,'滴滴',2407,'谌问筠');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (6,'滴滴',2481,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (7,'飞机票',9262,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (8,'飞机票',7740,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (9,'高铁',446,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (10,'高铁',9976,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (11,'滴滴',206,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (12,'滴滴',687,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (13,'飞机票',3936,'鹿悦可');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (14,'飞机票',4729,'扈修永');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (15,'高铁',148,'扈修永');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (16,'高铁',3689,'扈修永');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (17,'滴滴',4321,'扈修永');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (18,'滴滴',2331,'扈修永');
Insert into CROSSTEST_01 (ID,SIYOU,RYOU,MEISHOU) values (19,'滴滴',6481,'扈修永');

