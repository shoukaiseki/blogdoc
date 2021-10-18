# js

## 后缀名
```
['.jpg', '.jpeg', '.png', '.gif', '.bmp','.webp'].indexOf(tmp) 
```


## list转另一个list

```
const newList= list&&list.map(item=>(
	{
		label:item.carNumber,
		value:item.carNumber
	}
))
console.log(newList)
```

## list 遍历

```
	dictTypeList.forEach((item)=>{
		dictTypeMap[item.dictType]=item

		queryObjectList.push(sysDictDataTableQueryObject({
			dictType: item.dictType,
		}))
	})

```

## map遍历

```
for (let key of Object.keys(resData)) {
}
```
