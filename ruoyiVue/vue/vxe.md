# vxe

## 渲染
自带的 select 渲染存在bug,下拉框被覆盖
使用 element-ui 渲染插件
```
npm install  vxe-table-plugin-element element-ui

import VXETablePluginElement from 'vxe-table-plugin-element'
import 'vxe-table-plugin-element/dist/style.css'
VXETable.use(VXETablePluginElement)

```
```
<vxe-table-column field="var03" title="var03" :edit-render="{name: 'ElSelect',options: taxRateOptions,optionProps:{value:'dictValue',label:'dictLabel'}}"  min-width="180">
</vxe-table-column>

```
值变更事件
```
<vxe-table-column field="taxUnitCost" title="含税单位成本"
				  :edit-render="{name: '$input', props: {type: 'float', digits: 2, placeholder: '请输入数值'},events:{change: handleChangeTaxUnitCost}}"
				  min-width="120">
</vxe-table-column>
```

### 自定义渲染
```
                            <vxe-table-column field="taxRate" title="税率" :edit-render="{autofocus: '.custom-input'}" min-width="180">
                                <template v-slot:edit="{ row }">
                                    <el-select
                                        v-model="row.taxRate"
                                        filterable
                                        clearable
                                    >
<!--                                        <el-option v-for="item in taxRateOptions" :key="item.dictValue" :value="item.dictValue" :label="item.dictLabel" />-->
                                        <el-option v-for="item in taxRateOptions" :key="item.dictValue" :value="item.value" :label="item.label" />
                                    </el-select>
                                </template>
                            </vxe-table-column>
```

## vxe-input

```vue
<vxe-input :immediate="false" v-model="scope.row.quantity"  type="number" min="0" @change="handleChangeQuantity(scope.row)"></vxe-input>

<vxe-input v-model="form.companyCost" placeholder="请输入" type="float" :immediate="false" :controls="false" min="0"></vxe-input>


immediate=true 时,每输入一个字符都会触发 change 方法
:controls="false" 隐藏上下箭头,需配合  :immediate="false" ,不然每输入一个字符都会触发 change 事件

		<vxe-table-column title="数量" align="center" field="quantity" :min-width="100" width="120"  :edit-render="{}" >
				<template  #default="scope">
					<vxe-input v-model="scope.row.quantity" :immediate="false" :controls="false" type="number" min="0" @change="handleChangeSourceBomTableQuantity(scope.row,scope,...arguments)">
					</vxe-input>
			</template>
		</vxe-table-column>

        handleChangeSourceBomTableQuantity(row,scope,args){
            const {value,$event}=args
            // console.log("handleChangeInventoryMoveOrderBomTableQuantity",JSON.stringify(args))
            // {"value":"122","$event":{"type":"check"}}
            // {"value":"122","$event":{"isTrusted":true}}
            //会触发两次change事件,只取成功的提交
            if($event.isTrusted){
                const data={
                    inventoryBomId: row.inventoryBomId,
                    quantity: row.quantity,
                }
                updateTargetBom(data).then(response=>{
                    this.msgSuccess("修改成功")
                    // this.$refs.inventoryMoveOrderBomTableRef.updateStatus(scope)
                }).catch(error=>{
                    this.msgError("修改失败,列表将重新刷新")
                    // this.initPage();
                })
            }
        },
		
```


## 时间选择器
```vue
<!--       弹不出测试下 :transfer="false" 或 :transfer="true"-->
<vxe-input
	:disabled="globalReadonly(form)"
	v-model="form.actualStartTime"
	placeholder="日期和时间选择" type="datetime" :transfer="false">

</vxe-input>
```

## 默认不显示列
```vue
<vxe-table-column v-if="isAdmin"  title="创建者" align="center" field="createUserId"  :visible="false"/>
```



## 展开子表
```vue
            <vxe-table-column type="expand" width="80" fixed="right">
                <template #content="{ row }">
                    <vxe-toolbar custom>
                        <template #buttons>
                            <vxe-button status="primary" >选择销售订单中的产品</vxe-button>

                        </template>
                    </vxe-toolbar>
                    <vxe-table :data="row.childData">
                        <vxe-table-column title="库房" align="center" field="location"  min-width="120"/>
                    </vxe-table>
<!--                    <vxe-grid :columns="row.childCols" :data="row.childData">-->
<!--                    </vxe-grid>-->
                </template>
            </vxe-table-column>

        loadContentMethod  ({ row }) {
            return new Promise(resolve => {
                setTimeout(() => {
                    let childData = [
                        { location: 'TEST1', role: 'Develop', age: 20, sex: '女' },
                        { location: 'TEST2', role: 'Develop', age: 22, sex: '女' },
                        { location: 'TEST3', role: 'Develop', age: 24, sex: '男' },
                        { location: 'TEST4', role: 'Develop', age: 26, sex: '女' },
                        { location: 'TEST5', role: 'Develop', age: 28, sex: '男' },
                        { location: 'TEST6', role: 'Develop', age: 30, sex: '男' }
                    ]
                    row.childData = childData
                    resolve()
                }, 500)
            })
        },

```





## table
vxe-pager 有bug,编辑模式下切换下一页刷新了整个页面
```
```

### 分页
```
                <vxe-pager
                    align="right"
                    v-show="unAllocatedRequestTable.total>0"
                    :current-page.sync="unAllocatedRequestTable.queryParams.pageNum"
                    :page-size.sync="unAllocatedRequestTable.queryParams.pageSize"
                    :total="unAllocatedRequestTable.total"
                    :layouts="['PrevJump', 'PrevPage', 'JumpNumber', 'NextPage', 'NextJump', 'Sizes', 'FullJump', 'Total']"
                    @page-change="listUnAllocatedRequest()"
                />
```
