# VIM用标签页打开 

VIM采用标签页打开:转自 http://blog.sina.com.cn/s/blog_4177fa7f0100tirh.html

下面代码改变VIM目录位置后保存为.reg格式双击导入注册表即可

vim安装后自带的:
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\gvim]
@="{51EEE242-AD87-11d3-9C1E-0090278BBD99}"
```

在自带的基础上修改的:(主要添加了 -p --remote-tab-silent)
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\edit\command]
@="\"D:\\usr_xp\\Vim\\vim73\\gvim.exe\"  -p --remote-tab-silent   \"%1\""
```


自己额外添加的:右键点击文件后后用I键打开文件
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\I 国民党专用－用VIM打开\command]
@="D:\\usr_xp\\Vim\\vim73\\gvim.exe -p --remote-tab-silent \"%1\""
```


多标签页vim中的命令如下:转自http://www.sourcejoy.com/other_dev_tech/vim-tabpage.html

```Vim
//打开新的标签页:
vim -p filename
"最多不能超过"tabpagemax"数量，默认为10

//正常模式下：
gt,gT    "可以直接在tab之间切换，Ctrl+PageUp和Ctrl+PageDown也是一样。


//命令：
:tabnew [++opt选项] ［＋cmd］ 文件            "建立对指定文件新的tab
:tabc       "关闭当前的tab,如果带！，强制关闭当前tab
:tabo       "关闭所有其他的tab
:tabs       "查看所有打开的tab
:tabp      "前一个
:tabn      "后一个

//.vimrc文件有用的设置：
set showtabline=2    "设置标签栏的显示，0永远不显示 1两个以上显示 2 永远显示
```
