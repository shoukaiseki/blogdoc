# Mozilla Firefox配置  

取消 Alt+F1 ,让maximo在Mozilla Firefox正常使用
```
"1.0b6 (created: 2011/03/09 09:25:18)

loadplugins '\.(js|penta)$'
group user

map A <Nop>
map <C-q> <Nop>
map <C-o> <Nop>
map <C-i> <Nop>
map <C-p> <Nop>
map ZQ <Nop>
map ZZ <Nop>

map -m n,v,i,c,t <C-a> <Pass>
map -m n,v,i,c,t <A-F1> <Pass>
map -m n,v,i,c,t <F1> <Pass>
map -m n,v,i,c,t <C-c> <Pass>
map -m i,c,t <C-v> <Pass>
map -m i,c,t <C-x> <Pass>
map -m i,c,t <C-z> <Pass>
```
