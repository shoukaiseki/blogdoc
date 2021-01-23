# 若依vue

### title修改
```
src/layout/components/Sidebar/Logo.vue

src/settings.js
```


### 新建时设置时间为当前时间
```
//java
//yyyy-MM-dd HH:mm:ss
//@JsonFormat( pattern = "yyyy-MM-dd HH:mm:ss" )
//private Date datetime01;

//{y}-{m}-{d} {h}:{i}:{s}
this.form.datetime01=this.parseTime(new Date())

//yyyy-MM-dd
//@JsonFormat( pattern = "yyyy-MM-dd" )
//private Date datetime01;
//{y}-{m}-{d}
this.form.datetime01=this.parseTime(new Date(),'{y}-{m}-{d}')
```
