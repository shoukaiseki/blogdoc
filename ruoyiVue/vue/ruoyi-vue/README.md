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


### 统计信息
编译成静态页面时显示的值与标签错位,加上  label-width="122px" size="mini"即可
```
    <el-form :model="statisticInventoryBalanceList" ref="statisticPurchaseOrderRef" :inline="true"  label-width="122px" size="mini">
      <el-form-item label="原材料合计kg：">
        <span>
        {{ statisticInventoryBalanceFormat("default","decimal01") }}
        </span>
      </el-form-item>
      <el-form-item label="半成品合计kg：">
        <span>
        {{ statisticInventoryBalanceFormat("banchengpin","decimal01") }}
        </span>
      </el-form-item>
      <el-form-item label="成品合计kg：">
        <span>
        {{ statisticInventoryBalanceFormat("chengpin","decimal01") }}
        </span>
      </el-form-item>
      <el-form-item label="边丝废料合计kg：">
        <span>
        {{ statisticInventoryBalanceFormat("feipin","decimal01") }}
        </span>
      </el-form-item>
    </el-form>

```
