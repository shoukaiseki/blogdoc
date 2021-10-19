# slot插槽
```xml
<template slot="prefix" v-if="$slots.prefix">
</template>
```

## 组建
```xml
	<template>
		<slot :item="item"> </slot>
	</template>
```

### 调用组建
```xml

	<template slot-scope="{item}">
		{{item.saleOrderId}}
	</template>
```
