# mozillaFirefox Pentadactyl默认搜索引擎  

使用说明
```
重定义t和o：
如果有文字链接被选中，则直接打开链接；如果被选中的是一般文字，则用默认搜索引擎搜索；否则打开:tabopen或者:open命令行，手动输入关键字搜索。

对于有很多搜索引擎的用户，可能希望搜索时能够指定一下引擎。
这两行命令映射S键：弹出搜索引擎列表，可以指定引擎搜索选中内容。
 :siteseach asus   搜索本站点内asus关键字
 :set defsearch=baidu 设置百度为默认查找引擎
 修改右键搜索引擎 首先在地址栏里输入：about:config，回车，选择“我保证……”然后找到browser.search.defaultenginename 接着右键修改将后面的 =Google 改为=百度 即可 。我的就是这样修改的，祝LZ成功。
 :pin 将该标签页定义为应用
 :unpin 
 :tabmove n 移动当前标签页到指定把手
 :[n]b     切换到指定标签页

 f/F:  进入QuickHint模式（f=当前标签，F=新标签）
 ;{mode}:进入extended hint模式（不同的{mode}会导致不同的结果）
    
 B:显示所有buffer 选项卡
    b:跳转到指定buffer 选项卡


 //http://blog.sina.com.cn/s/blog_6db083ff0100r7lt.html
 :history — 命令如其名，这个命令显示的是Vimperator 历史，这些历史项目是彩色的、可卷动的，同时也是可点击的。
 :emenu — 通过命令行连接Firefox 的菜单项目。


  :xall — 离开并保存为下次打开保存当前浏览会话，默认方式
 :qall — 离开而不保存会话


 :dialog searchengines打开“管理搜索引擎列表”对话框，其中默认搜索引擎为 Google，其关键字为“google”，在这里，关键字是可改的，我为图方便，把关键字改成了”go”，这样使用Google搜索时我就可以直接:open go linux了。对其他的几个搜索引擎我也这样处理，比如 wikipedia 改 成wi，yahoo 改 成ya。


//补全框
tab  选择,pgup翻页
Shift tab  选择,pgdn翻页

//剪切内容http://www.linuxdiyf.com/viewarticle.php?id=188429
i 按i进入insert模式，不过貌似只能移动光标…
v  …然后按v进入可视模式，移动光标选择文本，
y 复制选择的文本到剪贴板


//查找
:set hlfind    所有的匹配都会高亮
:set nohlfind 只高亮当前匹配

自定义一个命令hl用来toggle高亮
【☆推荐】

:command! hl set hlf!
```




配置,在VIM增加Pentadactyl配置文件的高亮
```
" Vim script
au BufNewFile,BufRead _pentadactylrc,*.vim,*.vba,.exrc,_exrc setf vim
```

俺(おれ)[我]の(no)[的]コンフィグ(konnfigu)[配置]

其它精品配置

http://www.slimeden.com/2011/03/firefox/pentadactyl
```
"1.0b6 (created: 2012年4月30日13时04分15秒)
"注释不能跟功能同一行

loadplugins '\.(js|penta)$'
group user



map A <Nop>
map <C-q> <Nop>
map <C-w> <Nop>
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



" 此项功能是自动补全.在命令行下的自动补全.
" set wop=auto
"命令行下拉菜单最多显示的条目数

set maxitems=6
"所有的匹配都会高亮
set hlfind  

"在所有的标签页上显示编号
set guioptions+=n

"默认的设定（y: 复制当前页的url到剪贴板。Y：复制选中文字到剪贴板）很不合理，应该交换一下。如下配置竟能生效。
noremap y Y
noremap Y y

"重定义t和o：
"如果有文字链接被选中，则直接打开链接；如果被选中的是一般文字，则用默认搜索引擎搜索；否则打开:tabopen或者:open命令行，手动输入关键字搜索。

map t -js content.getSelection().toString()!=""?dactyl.execute(":tabopen "+ content.getSelection()):CommandExMode().open("tabopen ")
map o -js content.getSelection().toString()!=""?dactyl.execute(":open "+ content.getSelection()):CommandExMode().open("open ")

"对于有很多搜索引擎的用户，可能希望搜索时能够指定一下引擎。
"这两行命令映射S键：弹出搜索引擎列表，可以指定引擎搜索选中内容。

com! -nargs=? -complete=search engineSelect exe 't <args> ' + content.getSelection()
map S :engineSelect<Space>

"设置百度为默认查找引擎
set defsearch=baidu 


"定义一个Ex命令 – sitesearch，用google站内搜索API搜索当前站点
"com! -nargs=* sitesearch exe "t http://www.google.com/search?q=" + encodeURIComponent("<args>") + "&sitesearch=" + window.content.location.hostname

"对应baidu的
com! -nargs=* sitesearch exe "t http://www.baidu.com/s?ie=utf-8&word=" + encodeURIComponent("<args> site:" + window.content.location.hostname);

``` 

