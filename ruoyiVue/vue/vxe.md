# vxe

## vxe-input

```vue
<vxe-input :immediate="false" v-model="scope.row.quantity"  type="number" min="0" @change="handleChangeQuantity(scope.row)"></vxe-input>
```
immediate=true 时,每输入一个字符都会处罚 change 方法
