# 校验

## 角色

```
trigger: 'blur'
blur失去焦点

比如输入框里。校验文本框是否为空

====================================

trigger: 'change'
change数据改变

比如
选择框,选择其它表信息等

没有进行任何输入时，不会触发change，但一定会触发blur事件
```

### 校验角色

```xml
	<el-form :rules="mainRules" ref="form" :model="form" label-width="100px" status-icon>
	</el-form>

```

```vue
mainRules:{
	handlerStaffName: [
		{ required: true, message: '该项不能为空', trigger: 'change' }
	],
	amount: [
		{ required: true, message: '该项不能为空', trigger: 'change' },
		{ required: true,trigger: 'blur' ,validator: isPositiveIntegerAndNotZeroInRuleValidate}
	],
	productCode: [
		{ required: true, message: '该项不能为空', trigger: 'change' },
	],
	produceId: [
		{ required: true, message: '该项不能为空', trigger: 'change' }
	],
}
```
