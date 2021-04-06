# velocity
## 语法缩进导致输出
```
如果这样输出,结果会出现不美观

#foreach( $column in $columns )##
#if ($column.columnID != "id")##
		#if ($column.isColumnAnIdentifier)##
		#end
		#if ($column.isColumnValueGenerated)##

可以用velocity的注释来进行缩进

#foreach( $column in $columns )##
#**##if ($column.columnID != "id")##
#*    *##if ($column.isColumnAnIdentifier)##
#*    *##end
#*    *##if ($column.isColumnValueGenerated)##
```

## 转移$
```velocity
this.#[[$]]#refs
```

输出
```velocity
this.$refs
```

