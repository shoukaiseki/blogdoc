# bitFlag使用指南



## VUE
### 提交表单
```
            <el-form-item label="外加工单" prop="bitFlag1">
              <el-select v-model="form.bitFlag1" placeholder="是否为外加工单" clearable size="small">
                <el-option v-for="(item, index) in bitFlag1ArrayOptions" :key="index" :label="item.label"
                           :value="item.value" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="标识2" prop="bitFlag1">
              <el-select v-model="form.bitFlag2" placeholder="标识2" clearable size="small">
                <el-option v-for="(item, index) in bitFlag1ArrayOptions" :key="index" :label="item.label"
                           :value="item.value" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
```
### 获取详情
```

      bitFlag1ArrayOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      },
      ],
      queryParams: {
        bitFlag2: null,
        bitFlag1: null,
		}  


    reset() {
      this.formBitFlag1=0;
      this.form = {
	    //必须加,0或null都可
        bitFlag2: 0,
        bitFlag1: null,
	  }
	},


    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加销售订单";
      // this.form.ifComplete=0
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const saleOrderId = row.saleOrderId || this.ids
      getSaleOrder(saleOrderId).then(response => {
        //可用方法:
        //获取到的 response.data 中 bitFlag1 不存在,必须在赋值给form之前设置bitFlag1变量才行
        //必须在赋值给form之前初始化 bitFlag1 的值,才能成功绑定变量
        response.data.bitFlag1=(response.data.bitFlag&1)?1:0;
        response.data.bitFlag2=(response.data.bitFlag&2)?1:0;
        this.form = response.data;
        //有问题方法: 下拉选择框无法选择,因为之前给form赋值时表单绑定的变量不存在,相当于没有绑定变量,所以无效
        // this.form.bitFlag1=(this.form.bitFlag&1)?1:0;
        // this.form.bitFlag2=(this.form.bitFlag&2)?1:0;
        this.open = true;
        this.title = "修改销售订单";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.bitFlag=this.form.bitFlag!=undefined?this.form.bitFlag:0
          if(this.form.bitFlag1){
            //只将第一位置1,不影响其他位
            this.form.bitFlag=this.form.bitFlag|1
          }else{
            //只将第一位置0,不影响其他位
            this.form.bitFlag=this.form.bitFlag&(~1)
          }
          if(this.form.bitFlag2){
            //只将第二位置1,不影响其他位
            this.form.bitFlag=this.form.bitFlag|2
          }else{
            //只将第二位置0,不影响其他位
            this.form.bitFlag=this.form.bitFlag&(~2)
          }
          if (this.form.saleOrderId != null) {
            updateSaleOrder(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addSaleOrder(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    }
```


### 搜索

#### 前端

```
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="外加工单" prop="bitFlag1">
        <el-select v-model="queryParams.bitFlag1" placeholder="是否为外加工单"  size="small">
        <el-option v-for="(item, index) in bitFlag1ArrayOptions" :key="index" :label="item.label"
                   :value="item.value" :disabled="item.disabled"></el-option>
        </el-select>

      </el-form-item>
	  <!-- select中的清除 clearable 无效果,重置才可以 -->
      <el-form-item label="标识2" prop="bitFlag2">
        <el-select v-model="queryParams.bitFlag2" placeholder="标识2"  size="small">
          <el-option v-for="(item, index) in bitFlag1ArrayOptions" :key="index" :label="item.label"
                     :value="item.value" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="cyan" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>


            <el-table-column label="外加工" align="center" prop="bitFlag" width="120">
              <template slot-scope="scope">
                <span v-if="scope.row.bitFlag&1">是</span>
                <span v-else>否</span>
              </template>
            </el-table-column>
            <el-table-column label="标识2" align="center" prop="bitFlag" width="120">
              <template slot-scope="scope">
                <span v-if="scope.row.bitFlag&2">是</span>
                <span v-else>否</span>
              </template>
            </el-table-column>
	
	  

      // 查询参数
      queryParams: {
        bitFlag2: null,
        bitFlag1: null,
	  }

    /** 查询销售订单列表 */
    getList() {
      this.loading = true;
      let queryParams = addDateRangeToParams(this.queryParams, this.dateRange,"ContractTime")

      queryParams.bitFlagTrue=0
      queryParams.bitFlagFalse=0
      if(this.queryParams.bitFlag1!=undefined){
        if(this.queryParams.bitFlag1){
          queryParams.bitFlagTrue=(queryParams.bitFlagTrue|1)
        }else{
          queryParams.bitFlagFalse=(queryParams.bitFlagFalse|1)
        }
      }
      if(this.queryParams.bitFlag2!=undefined){
        if(this.queryParams.bitFlag2){
          queryParams.bitFlagTrue=(queryParams.bitFlagTrue|2)
        }else{
          queryParams.bitFlagFalse=(queryParams.bitFlagFalse|2)
        }
      }
      queryParams.bitFlag=null;
      listSaleOrder(queryParams).then(response => {
        this.SaleOrderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
```
#### 后端
##### SaleOrder
```java
    /**
     * 例如: &1 为 外加工
     */

    /**
     * 位标志为true的位
     */
    private Integer bitFlagTrue;

    /**
     * 位标识为false的位
     */
    private Integer bitFlagFalse;

    /**
     * companyId对应的客户
     */
    private Company virtualCompany;

```
##### mybatis
```xml
    <select id="selectSaleOrderList" parameterType="SaleOrder" resultMap="SaleOrderResult">
        <include refid="selectSaleOrderVo"/>
        <where>
             del_flag=0
            <if test="bitFlagTrue != null and bitFlagTrue != 0">
                <![CDATA[
             and (bit_flag & #{bitFlagTrue})=#{bitFlagTrue}
             ]]>
            </if>
            <if test="bitFlagFalse != null and bitFlagFalse != 0">
                <![CDATA[
             and !(bit_flag & #{bitFlagFalse})
             ]]>
            </if>
        </where>
    </select>
```
