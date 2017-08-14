# 子表点击任何行任一列时光标都在该列第一行  

问题描述:如下图,在点击第二行描述的时候,光标却在第一行,而行选中却在第二行,如果进行更改内容,则第一行的内容会变更,只能通过点击最左边的详细信息在下面tabledetails中进行更改

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/001.png)
 在其它应用中没问题,那么最可能的是签名的问题

那么就把所有签名删除掉,导出xml之后使用vim进行全部替换,将所有签名删除
```Vim
%s/sigoption="[A-Za-z]\+"
```
重新导入之后,问题不再存在,然而没有签名满足不了业务需求,还得进一步解决有签名时候的问题
```Sql
declare
  l_sql varchar2(32767);
  c_tab_comment varchar2(32767);
  procedure run(p_sql varchar2) as
  begin 
     execute immediate p_sql;
     
  end; 
begin
run('create table "MAXIMO".CTRLCONDITION_BAK as select * from "MAXIMO"."CTRLCONDITION" where '||11||' = 11');
select comments into c_tab_comment from sys.all_TAB_comments where owner = 'MAXIMO' and table_name = 'CTRLCONDITION' and comments is not null;
run('comment on table MAXIMO.CTRLCONDITION_BAK is '||''''||REPLACE(c_tab_comment, q'[']', q'['']')||'''');

for tc in (select column_name from sys.all_tab_cols where owner = 'MAXIMO' and table_name = 'CTRLCONDITION')
    loop
   for c in (select comments from sys.all_col_comments where owner = 'MAXIMO' and table_name = 'CTRLCONDITION' and column_name=tc.column_name) 
   loop 
   run ('comment on column MAXIMO.CTRLCONDITION_BAK.'||tc.column_name||' is '||''''||REPLACE(c.comments, q'[']', q'['']')||'''');
 end loop;
end loop;
EXCEPTION
  WHEN OTHERS THEN NULL; 
end;
	
update CTRLCONDITION set REEVALUATE=0;


update CTRLCONDITION set REEVALUATE=(select REEVALUATE from CTRLCONDITION_bak where 
CTRLCONDITION_bak.CTRLCONDITIONID=CTRLCONDITION.CTRLCONDITIONID);--恢复重新评估的值
```


重启服务器后问题依旧,那就恢复重新评估字段的值;

接着将"安全措施"选项卡设置为第一个位置,如下图:

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/002.png)
 可以看出正常了,但是点击了含有签名的选项卡之后
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/003.png)
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/004.png)
 再点回来问题有出现了,可以看出签名判断又引发了问题,签名是不会存在这种bug的,那么原因只有一个,主选项组的签名导致的,如果将这些签名设在某个选项卡下的选项卡组中,那么应该就能解决问题了

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/005.png)
 将上图改成下图这种方式,然后把工作票的签名去掉
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8C/img/006.png)
 
问题就解决了

警告:主选项卡的任意选项卡都不要使用签名,容易导致页面出现不可预料的问题



