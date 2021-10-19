# vue-ruoyi
## 预览PDF
### 安装
```
npm install vue-pdf -D
```
### 自定义浏览组建
#### 使用
高度没法调整,转化后相当于是张图片
```
		<showPdf
			:src="previewDialog.url"
		></showPdf>
```
#### 组建
```
<template>
    <div class="show-pdf">
        <div>
            <pdf
                v-if="pdfSrc"
                :src="pdfSrc"
                :page="currentPage"
                @num-pages="pageCount=$event"
                @page-loaded="currentPage=$event"
                @loaded="loadPdfHandler"
            ></pdf>
        </div>

        <p class="arrow2" v-if="pdfSrc">
            <span @click="changePdfPage(0)" :class="{grey: currentPage==1}">上一页</span>
            {{currentPage}} / {{pageCount}}
            <span
                @click="changePdfPage(1)"
                :class="{grey: currentPage==pageCount}"
            >下一页</span>
        </p>
    </div>
</template>

<script>
import pdf from "vue-pdf";
export default {
    name: "show-pdf",
    components: {
        pdf
    },
    props: {
        src:[String],

    },
    watch: {
        src(val) {
            console.log("pdfSrc");
            console.log(val);
            this.pdfSrc = val;
        },
    },

    data() {
        return {
            pdfSrc: "",
            currentPage: 0, // pdf文件页码
            pageCount: 0, // pdf文件总页数
            numPages: 1,
            activeIndex: 0
        };
    },
    methods: {
        // 改变PDF页码,val传过来区分上一页下一页的值,0上一页,1下一页
        changePdfPage(val) {
            if (val === 0 && this.currentPage > 1) {
                this.currentPage--;
            }
            if (val === 1 && this.currentPage < this.pageCount) {
                this.currentPage++;
            }
        },
        // pdf加载时
        loadPdfHandler(e) {
            this.currentPage = 1; // 加载的时候先加载第一页
        }
    },
    mounted: function() {
        this.pdfSrc = "";
        this.pdfSrc = this.src;
    }
};
</script>

<style scoped>

</style>
```


## 获取当前用户ID
```
this.$store.state.user.userId
```

## 渲染回调
组件全部渲染完成后执行
https://www.jianshu.com/p/a7550c0e164f

如果调用子组建方法时出错,说明子组建还未渲染完成,bom还不存在,所以需要等组建全部渲染完成后才执行
```javascript
this.$nextTick(()=>{
	this.$refs.seeReserveRelationInfoRef.init(itemId,tabName)
});
```

```vue
data(){
	return {
		//不存在的对象,只为 webStorm 中代码提示字段不存在,
		//不方便判断子表数据有无拼写错误
		//如果关闭 webStorm 验证,则无法判断主表字段名是否存在错误的
			nullDomain:{
				economicOrderQuantity:null,
			  	minimumQuantity:null,
		   }
	}
	)

```

## table
#### 更新行
```vue
 this.$set(this.virtualSourceBomList, index, row);
```

## el-input
### 限制输入整数数字
```vue

                  <el-input-number  :controls="false" v-model="demoDomain4.numValue1" :precision="0" :min="0"  style="width:120px" >
                  </el-input-number>

```
#### 注意
queryParams默认值不能为null,如果为null,则默认值会是0

错误方式
```vue
queryParams:{
    itemId: null,
}
```
可用
```vue
queryParams:{
    itemId: undefined,
}
```

### 限制只能输入指定字符

```vue
            <el-form-item label="搜索内容" prop="searchValueListSearch">
                <el-input
                    v-model="searchValueListSearch"
                    placeholder="请输入搜索内容"
                    clearable
                    size="small"
                    @keyup.enter.native="handleQuery"
                    @input="test"
                />
            </el-form-item>

        test(val){
            console.log("test",val)
            val.replace('')
            //限制只能输入指定内容
            let tmp=val.replace(/[^0-9\,]/g,"");
            console.log("tmp",tmp)
            this.searchValueListSearch = tmp;
        },

        test1(val){
            console.log("test",val)
            //限制只能输入指定内容
            let tmp=val.match(/[0-9\,]/g);
            if(!tmp){
                tmp=''
            }else{
                tmp=tmp.join('')
            }
            console.log("tmp",tmp)
            this.searchValueListSearch = tmp;
        },

```

## 组件颜色配置

### el-input背景色 
```vue
<el-input v-model="ownerInfo.data.itemId"  readonly :BackgroundColor="ownerInfoStyle()"/>

<style >
/*红色*/
.el-input__inner[BackgroundColor="danger"] {
    background-color: #FF6347;
}
/*background-color: #F56C6C;*/
/*橙色*/
.el-input__inner[BackgroundColor="warning"] {
    background-color: #E6A23C;
}
/*绿色*/
.el-input__inner[BackgroundColor="success"] {
    background-color: #67C23A;
}
</style >
```

### el-form-item背景色 
```vue
          <el-form-item label="物资清单存在嵌套循环配置" class="item" label-width="500">
          </el-form-item>
<style >
.item .el-form-item__label{
    background-color: #FF6347;
    color: #000000
}
</style >
```

### 跳转后返回
```vue
	Global.$emit("removeCache", "closeSelectedTag", this.$route);
	this.$store.dispatch("tagsView/delView", this.$route);
	this.$router.go(-1)
```

### 跳转另一个页面
跳转传递参数
```vue
handleJumpProductionWorkpieceProcedure(row){
	const productionWorkpieceId = row.productionWorkpieceId||this.currentRowProductionWorkpiece.productionWorkpieceId;
	this.$router.push({
		path:'./ProductionWorkpieceProcedure',
		query:{
			productionWorkpieceId: productionWorkpieceId,
		}
	})
},

```
接收参数
```vue
initPage(){
	//main.js 需要增加原型方法引入
	//import {checkRole,checkPermi} from "@/utils/permission";
	// Vue.prototype.checkRole = checkRole
	
	this.queryParams.productionWorkpieceId=this.$route.query.productionWorkpieceId;
	
	this.isAdmin=this.checkRole(['admin']);
	this.isSystem=this.checkRole(['system'])||this.isAdmin;
	this.getList();
},
```


#### 只读加 readonly,这样显示文字不会暗色
```vue
       <el-form-item label="项目" prop="virtualProductionOrderIdLabel">
        <el-input
          v-model="queryParams.virtualProductionOrderIdLabel"
          placeholder="请选择项目"
          readonly
          size="small"
          @keyup.enter.native="handleQuery"
        >
          <el-button type="primary" slot="suffix"  @click="showLookupProductionOrder('queryParams.productionOrderId')">选择</el-button>

        </el-input>
      </el-form-item>

```

## iview、element等@change方法，保留默认参数再获取到自定义参
```vue
<Select v-model="selectCoin" @on-change="getValue(...arguments,3,4)">
    <Option v-for="item in coinList" :value="item.value" :key="item.value">{{ item.label }}</Option>
</Select>

getValue(value,num1,num2){
//这里的形参具体多少取决于上面实参的多少，比如change的默认值有两个，那么这里的形参就应该写四个（两个是自定义参数）
  console.log(arguments);  //  Arguments(2) ["BTC","ETH" ,3,4]
},
```
或者
```vue
<Select v-model="selectCoin" @on-change="getValue(3,4,...arguments)">
    <Option v-for="item in coinList" :value="item.value" :key="item.value">{{ item.label }}</Option>
</Select>

getValue(num1,num2,value){
//这里的形参具体多少取决于上面实参的多少，比如change的默认值有两个，那么这里的形参就应该写四个（两个是自定义参数）
  console.log(arguments);  //  Arguments(2) ["BTC","ETH" ,3,4]
},
```

#### 未验证
<Input v-model="value14" placeholder="Enter something..." clearable style="width: 200px" @on-change="(event) => {changeNumber(event, params)}"/>


## 对象比较\
```vue
valueEquals(a,b)
```
### input输入框 回车触发绑定事件失效,变成刷新页面
```
<!-- 在 form中增加 @submit.native.prevent 即可 -->
      <el-form  :model="queryParams" ref="queryForm" :inline="true" @submit.native.prevent>
        <el-form-item label="表名称" prop="searchValue">
          <el-input
            v-model="queryParams.searchValue"
            placeholder="请输入表名称"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

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
//删除数组元素,删除索引位开始1个元素
this.form.virtualSaleOrderCreateProductionOrderBomList.splice(index,1)
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
          let startchildrennum=this.productionorder.startchildrennum.replace(/[^0-9]/ig,"")
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

## 字符串拼接


### 文件绑定{{}}中的字符串拼接：直接在{{}}内拼接：

```vue
  <template v-if="userList">
              <div v-for="(item,index) in userList" :key="index">
                {{item.userName+'('+item.userAccount+')'}}
              </div>
 </template>
```
### vue标签属性绑定中的字符串拼接：写法有两种：:title="`字符串${xx}`"   或   :title="'字符串' + xx"  都可以。其中，{}里面可以写js方法。如：

```vue
 <el-option
                  v-for="item in tableData"
                 :key="item.account"
                 :label= '`${item.name}${item.account}`'
                 :value="item.account"
                 :height = "schoolHeight">
               </el-option>
 <el-submenu v-show="item.childList.length > 0" :index="item.id"  :class='`menu${item.id}`'>
 ```
### js中的字符串拼接：

` 是`旁边的符号.  是国际标准万国码的全形抑音符（全宽重音符号） 英文名为【FULLWIDTH GRAVE ACCENT】。位于万国码uFF40。
```
this.personList.forEach(item => {
          item.label = `${item.userName}(${item.account})`;
        });
this.$bus.$emit(`${this.activeName}-reload`, this.searchData);
switchStatus(row) {
      this.$Modal.confirm({
        title: '提示',
        content: `是否确认切换状态为${row.isDelete === 1 ? '否' : '是'}？`,
        onOk: () => {
          row.isDelete = row.isDelete === 0 ? 1 : 0;
        }
      });
    },
```

#### 限制输入数字
```vue
            <el-table-column label="数量" align="center" prop="amount" :width="140">
              <template slot-scope="scope">
                <el-input-number  :precision="2" :controls="false"  v-model="scope.row.amount"
                                  @change="handleChangeDepositBomListTable(scope.row)"
                                 size="small"
                ></el-input-number>
              </template>
            </el-table-column>

            <el-table-column label="行成本" align="center" prop="lineCost">
              <template slot-scope="scope">
                <el-input @input="(val)=>((scope.row.amount=val.match(/^\d*(\.?\d{0,2})/g)[0]) || null)"  v-model="scope.row.lineCost" @change="handleChangeDepositBomListTable(scope.row)"
                ></el-input>
              </template>
            </el-table-column>


                <el-input  @input="(val)=>inputRestrictedDecimal({value:val,rowData:scope.row,attrName:'lineCost',precision:2})"  v-model="scope.row.lineCost" @change="handleChangeDepositBomListTable(scope.row)"
                ></el-input>
```



### 提示输入框
```vue
      this.$prompt('请输入数量', '库存修改', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',

        inputValue:parseInt(row.amount),
        inputPattern: /^\+?[0-9][0-9]*$/,
        inputErrorMessage: '请输入数量'
      }).then(({ value }) => {
        var params={
          inventoryBalanceId:row.inventoryBalanceId,
          amount:parseInt(value),
        }
        editamountInventoryBalance(params).then(res=>{
          console.log(res)
          row.amount=parseInt(value);
          this.msgSuccess('修改成功')
        })
        
      }).catch(() => {
            
      });

```


### 树结构
#### 懒加载
如果 hasChildren: 'hasChildren' 中的hasChildren有值就会启用懒加载
而且为true的行无展开按钮
```
            :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
```
##### 方案1:不启用懒加载
修改 hasChildren 属性名
```
            :tree-props="{children: 'children', hasChildren: 'haveChildren'}"
```

##### 方案2:使用懒加载
需要添加两个参数
```
            :lazy="true"
            :load="loadItemClassificationListChildren"

修改为
            :tree-props="{children: 'child', hasChildren: 'hasChildren'}"
```
并定义加载方法
```

        loadItemClassificationListChildren(tree,treeNode,resole){
            setTimeout(()=>{
                resole(tree.children)
            },200)
        },
```
##### 示例table
```
        <el-table
            v-loading="loading"
            default-expand-all
            :data="ItemClassificationList"
            row-key="itemClassificationId"
            :lazy="true"
            :load="loadItemClassificationListChildren"
            :tree-props="{children: 'child', hasChildren: 'haveChildren'}"
        >
            <el-table-column label="描述" align="center" prop="description" />
            <el-table-column label="分类长描述" align="center" prop="icfLongDesc" />
            <el-table-column label="编号" align="center" prop="icfNum" />
            <el-table-column label="编号分隔符" align="center" prop="icfSeparator" />
            <el-table-column label="分类长编号" align="center" prop="icfLongNum" />
            <el-table-column label="编号位数" align="center" prop="numberOfDigits" />
            <el-table-column label="当前编号" align="center" prop="currentNumber" />
            <el-table-column label="父级" align="center" prop="parentId" />
            <el-table-column label="注释" align="center" prop="comment" />
            <el-table-column label="小记" align="center" prop="notepad" />
            <el-table-column label="备注" align="center" prop="remark" />
            <el-table-column label="部门" align="center" prop="deptId" />
            <el-table-column v-if="isSystem" label="状态" align="center">
                <template slot-scope="scope">
                    <el-switch :disabled="true" v-model="scope.row.status" active-value="0" inactive-value="1"></el-switch>
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button
                        size="mini"
                        type="text"
                        icon="el-icon-plus"
                        @click="handleAdd(scope.row)"
                        v-hasPermi="['inventory:ItemClassification:add']"
                    >增加子级</el-button>
                    <el-button
                        size="mini"
                        type="text"
                        icon="el-icon-edit"
                        @click="handleUpdate(scope.row)"
                        v-hasPermi="['inventory:ItemClassification:edit']"
                    >修改</el-button>
                    <el-button
                        size="mini"
                        type="text"
                        icon="el-icon-delete"
                        @click="handleDelete(scope.row)"
                        v-hasPermi="['inventory:ItemClassification:remove']"
                    >删除</el-button>
                </template>
            </el-table-column>
        </el-table>

```



### 方法中调用过滤器

```
    filters:{
        filterImgUrl(e){
            return e.map(item=>item.url)
        },
        filterDocumentId(e){
            return e.map(item=>item.wbDocumentId)
        },
        numchange(e){
            return (e*100).toFixed(2)
        }
    },
    methods: {
        getDocumentIdList(){
			let documentIdList = this.$options.filters['filterDocumentId'](this.virtualDocumentList)
		},
	}

```


### 临时变量
```vue
{{ void (value1 = item[key], value2 = item2[key]) }}
```
