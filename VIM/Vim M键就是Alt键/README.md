# Vim M键就是Alt键  

执行下这句命令,然后按Alt+i就知道了

CR 键即为回车键ASCII中命名就是CR
```Vim
map <M-i> a<C-R>=strftime("%c")<CR><Esc>
```

取消按键绑定
```Vim
unmap <M-i>
```
