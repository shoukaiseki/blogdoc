# 网易博客已被封,解封很麻烦,删除日志不进回收站,刷新网页又回来了,只能彻底删除,而彻底删除之后也就个空号了

# 300多篇日志现在都迁移过来了,毕竟maximo资料太少,给大家做点贡献吧

# ---------------------------------------蒋カイセキ(蒋校长) 笔











# 博客转移为markdown语法

```plantuml
@startuml
"生成本次操作缓存key\n缓存value变量" -down-> "查询缓存key是否有对应值"
if "查询缓存key成功" then
	-->[true] if "查询缓存key是否有成功" then
	  -down->[true] "证明lpop成功但是业务未处理"
	  --> "处理业务"
	  if "删除缓存key成功" then
	     -->[true] (*)
	  else
	     -->[false] "保存到本地缓存删除key队列"
	  endif
	  --> (*)
	else
	  -down->[false] "使用获取第一个元素\nwatch key\nlindex key 0"
	  --> "缓存value变量=lindex获取的值"
	  --> "multi\nlpop key\nset 缓存key 缓存value\nexec"
	  if "事务执行返回成功" then
	     -->[true] "处理业务"
	  else
	     -->[false] "查询缓存key是否有对应值"
	  endif
	endif
else
  -->[false] "查询出错"
  --> "缓存value变量不为空"
  "缓存value变量不为空" -->[true] "保存到本地缓存业务处理队列"
	  --> (*)
  "缓存value变量不为空" -->[false] (*)
endif
@enduml
```


```Java
public static void main(String[] age){
   System.out.println("Hello world");
}
```

## 目录1
- ![#c00000](https://placehold.it/15/c00000/000000?text=+) `1=#c00000`

## 目录2

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/websphere/websphere/websphere LDAP 验证缓存超时设置/img/001.png)
