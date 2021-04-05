# vxe

## vxe-input

```vue
<vxe-input :immediate="false" v-model="scope.row.quantity"  type="number" min="0" @change="handleChangeQuantity(scope.row)"></vxe-input>
```
immediate=true 时,每输入一个字符都会触发 change 方法
:controls="false" 隐藏上下箭头,需配合  :immediate="false" ,不然每输入一个字符都会触发 change 事件

		<vxe-table-column title="数量" align="center" field="quantity" :min-width="100" width="120"  :edit-render="{}" >
				<template  #default="scope">
					<vxe-input v-model="scope.row.quantity" :immediate="false" :controls="false" type="number" min="0" @change="handleChangeSourceBomTableQuantity(scope.row)">
					</vxe-input>
			</template>
		</vxe-table-column>


## 时间选择器
```vue
<!--       弹不出测试下 :transfer="false" 或 :transfer="false"-->
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
