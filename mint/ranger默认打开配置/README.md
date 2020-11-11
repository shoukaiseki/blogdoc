# ranger默认打开置

https://wiki.archlinux.org/index.php/ranger_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E9%85%8D%E8%89%B2%E6%96%B9%E6%A1%88


运行select-editor根据数字选择打开方式就可以了


Ranger 使用自己的文件打开程序，名为rifle，它的配置文件为 ~/.config/ranger/rifle.conf。如果该文件不存在，可运行 ranger --copy-config=rifle 生成。


html用select-editor(vim)打开,放在其他 x?html? 前面
```
ext x?html?, has vim,             terminal = ${VISUAL:-$EDITOR} -- "$@"
```

例如，如下的代码指定 kile 为打开 tex 文件的默认程序。

```
ext tex = kile "$@"
```

使用 xdg-utils 来打开所有文件，设置 $EDITOR 和 $PAGER:

```
else = xdg-open "$1"
label editor = "$EDITOR" -- "$@"
label pager  = "$PAGER" -- "$@"
```


