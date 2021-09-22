# 若依vue
###
const genTable = Object.assign({}, basicForm.model, genForm.model);

### el-button
按钮禁用时也能够提示,button外层加个  div
```vue
		<el-tooltip class="item" effect="dark" content="点击行中任何位置,行底色变化之后才能点击" placement="top">
			<div>
				<el-button :disabled="!selectedItem" class="uni-button" type="primary" @click="update">修改</el-button>
			</div>
		</el-tooltip>
```


### el-tabs禁止点击
```vue
                <el-tabs  readonly @input="resetInventoryHistory()" v-model="queryParamsTabPaneFilterValue">
                    <el-tab-pane
                        :disabled="inventoryHistoryTable.loading"
                        v-for="(item, index) in queryParamsTabPanelOptionList"
                                 :label="item.dictLabel"
                                 :name="''+item.dictValue">
                    </el-tab-pane>
                </el-tabs>

```
#### table选项
el-tabs要使用 @tab-click 因为 @input 会触发2次
```
      <el-row>
          <el-col :span="24">
              <el-tabs @tab-click="handleQuery()" v-model="queryParamsTabPaneFilterValue">
                  <el-tab-pane v-for="(item, index) in queryParamsTabPanelOptionList"
                               :label="item.dictLabel"
                               :name="''+item.dictValue">
                  </el-tab-pane>
              </el-tabs>
          </el-col>
      </el-row>

        // 查询参数
        queryParamsTabPaneFilterValue: "1",
        queryParamsTabPanelOptionList: [
            {
                dictValue: 0,
                dictLabel: '全部'
            },
            {
                dictValue: 1,
                dictLabel: '待处理生产不合格'
            },
            {
                dictValue: 2,
                dictLabel: '待处理采购不合格'
            },
        ],
	  

        queryParams.ownerName=undefined
        switch (Number(this.queryParamsTabPaneFilterValue)) {
            case 0:
                //全部
                queryParams.ownerName='production_order';
                break;
            case 1:
                //生产不合格
                queryParams.ownerName='production_order';
                break;
            case 2:
                //任务订单
                // proType in ('outside','inside')
                queryParams.lookupBitFilter=2
                break;
            default:
                //这里是没有找到对应的值处理
                break
        }

```

#### 默认显示边框

```vue
Element.Table.props.border={
    default: true,
    type: Boolean
}
```

#### 列默认居中

```vue
Element.TableColumn.props.align={
    type: String,
    default: 'center',
}
```

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


## 问题
### element-ui中dialog和el-image组件冲突问题
dialog编辑框中点击小图片预览图片被dialog框覆盖遮挡的BUG, BUG本质是如果el-image-viewer组件在el-dialog里面，el-dialog的层级是优先的, 所以解决的关键在于提高el-iage-viewer的层级, 直接在对应的el-image组件添加属性:zIndex=“9999”, 因为el-image是允许传入zIndex参数的, 但是官方文档没有提及

```
<el-image  :zIndex="99999999" style="width: 100px; height: 100px;" :src="form.avatar" fit="contain" :preview-src-list="[form.avatar]"></el-image>
```
