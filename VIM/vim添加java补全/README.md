# vim添加java补全

javacomplete         http://www.vim.org/scripts/script.php?script_id=178 5

linux下               http://blog.csdn.net/wangran51/article/details/7248945

linux下测试正常了

win下我习惯放到 D:\usr_xp\Vim\vimfiles\autoload 目录，结果不行

应该放到 D:\usr_xp\Vim\vim73\autoload下，可以了，放到home下不好备份，毕竟win是个容易崩溃的系统，

所以我一般不考虑“C:\Documents and Settings\Administrator\vimfiles\autoload”

_vimrc先所有加了再说，可以用了慢慢调。
```Vim
setlocal omnifunc=javacomplete#Complete
autocmd Filetype java set omnifunc=javacomplete#Complete
autocmd Filetype java set completefunc=javacomplete#CompleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
autocmd Filetype java,javascript,jsp inoremap <buffer>  .  .<C-X><C-O><C-P>
```

我一般不设置Classpath和path，因为好几个jdk混着用.

```Bat
@echo off
set JAVA_170=d:\usr_xp\Java\jdk1.7.0
set JAVA_HOME=%JAVA_170%
set PATH=%JAVA_HOME%\bin;%PATH%
set CLASSPATH=%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;D:\usr_xp\Vim\vim73\autoload;E:\Eclipse\Workspace\hello\bin;
start /B D:\usr_xp\Vim\vim73\gvim.exe -p --remote-tab-silent "%~f1"
echo exit
```

选中文件->Ctrl+F10->i键用VIM打开文件
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\I 国民党专用－用VIM打开\command]
@="D:\\usr_xp\\Vim\\vim73\\tab_vim.bat %1
```
