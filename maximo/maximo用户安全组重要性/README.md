# maximo用户安全组重要性  

```Sql
select * from laborauth  where groupname in () order by groupname

```
用户如果没有安全组，就会执行不了这语句
