# mysql
##生成随机数
```
update inventory_balance set sort=rand()*1000 ,item_feature='' where 1=1;

update inventory_item set item_sort=rand()*1000,item_feature='' where 1=1;
update inventory_item set create_time=concat('2021-01-01 ', floor(10+rand()*10),':',floor(10+rand()*49),':',floor(10+rand()*49)) where 1=1;

```
