# vue-ruoyi

## 对象比较\
```vue
valueEquals(a,b)
```

## 输入框按钮同一排
```vue
	<el-form-item label="钢卷号" prop="var01">
	  <el-input v-model="form.itemId" placeholder="请输入钢卷号" >

		<el-button type="primary" slot="suffix"  @click="showLookupInventoryBalance('a')">选择</el-button>
<!--       <i class="el-icon-search" slot="suffix" @click="showLookupInventoryBalance">-->
<!--          点击选择-->
<!--            </i>-->
	  </el-input>
	</el-form-item>

```



## 字典第一列增加空字符选项
```
this.actionNodeNameOptions.unshift({dictValue:"",dictLabel:"无选择"})
```

正则判断数字
```javascript
var reg = /^-?\d+(\.?[0-9]+)?$/;
var value='1.2';
reg.test(value)
```

提取数字并加一
```javascript
        try{
			this.productionOrder.startChildrenNum="A123B";
          let startChildrenNum=this.productionOrder.startChildrenNum.replace(/[^0-9]/ig,"")
          //连续的数字才处理
          if (this.productionOrder.startChildrenNum.indexOf(startChildrenNum) > -1) {
            // console.log("startChildrenNum=",startChildrenNum)
            var a=(parseInt(startChildrenNum)+1);
            // console.log("a=",a)
			let newNum=this.productionOrder.startChildrenNum.replace(startChildrenNum,a+"");
			this.form.proLineNumber=newNum;
          }
        }catch (e){
          console.log(e)
        }

```


## 重置表单
--- 我们需要为每个form-item加上prop属性，要不然无法清空（大部分的问题就是出在这）
--- resetFields()方法是重置表单，重置为默认值，而不是设置为空值
--- 在resetFields()方法之前，如果修改了data里的表单默认值，那么重置以后就是你修改以后的值，而不是data里的值了
--- 使用$nextTick再执行赋值

```
this.$refs['inventoryItemTableQueryForm'].resetFields();
//this.resetForm("inventoryItemTableQueryForm");
// this.$refs.inventoryItemTableQueryForm.resetFields();
```

```xml
      <el-form  :model="inventoryItemTable.queryParams" ref="inventoryItemTableQueryForm"  :inline="true" label-width="68px">
        <el-form-item label="名称" prop="itemNameListSearch">
          <el-input
            v-model="inventoryItemTable.queryParams.itemNameListSearch"
            placeholder="请输入名称"
            clearable
            size="small"
            @keyup.enter.native=""
          />
        </el-form-item>
        <el-form-item label="库存类型" prop="inventoryType">
          <el-select v-model="inventoryItemTable.queryParams.inventoryType" placeholder="请选择库存类型" clearable size="small">
            <el-option
              v-for="dict in inventoryTypeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="cyan" icon="el-icon-search" size="mini" @click="inventoryItemTableQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="inventoryItemTableResetQuery">重置</el-button>
        </el-form-item>
      </el-form>

```

### 初始化data数据
```
vue中：
this.$data 获取当前状态下的data
this.$options.data() 获取该组件初始状态下的data

所以，下面就可以将初始状态的data复制到当前状态的data，实现重置效果：
Object.assign(this.$data, this.$options.data())

当然，如果你只想重置data中的某一个对象或者属性：
this.form = this.$options.data().form
```
### 清空表单爆红
```
this.$refs.form.clearValidate() // 重置校验表单
```




### 复选框
如果出现点击复选框无显示更新,是因为 v-model 是二级字段，修改 v-model 为一级字段可解决，即 v-model="form.processShowFlagArray" 修改为 v-model="processShowFlagArray"

```html
              <el-checkbox-group v-model="processShowFlagArray"  size="medium">
<!--                <el-checkbox-button-->
<!--                  v-for="(dict, index) in processShowFlagOptions"-->
<!--                  :key="dict.dictValue"-->
<!--                  :label="dict.dictValue"-->
<!--                   border>-->
<!--                  {{dict.dictLabel}}-->
<!--                </el-checkbox-button>-->
                <el-checkbox
                  @change="handleChangeProcessShowFlag"
                  v-for="dict in processShowFlagOptions"
                  :key="dict.dictValue"
                  :label="dict.dictValue">
                  {{dict.dictLabel}}
                </el-checkbox>
              </el-checkbox-group>

//data中
processShowFlagArray:[],

handleAdd() {
	this.processShowFlagArray=["1","2","4","8"];
}

```


## 自定义组建
变更v-model绑定的值
```javascript
this.$emit("input", this.currentValue);
```

