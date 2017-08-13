# 讓vim支持在終端剪貼板共享 

來自http://basiccoder.com/vim-copy-paste-related.html

查看Vim是否支持clipboard和xterm_clipboard
```Shell
[root@fedora fedora]# vim --version|grep clipboard
-clientserver -clipboard +cmdline_compl +cmdline_hist +cmdline_info +comments 
 -xterm_clipboard -xterm_save 



#可以看出不支持這兩個功能


[root@fedora fedora]# gvim --version|grep clipboard
+clientserver +clipboard +cmdline_compl +cmdline_hist +cmdline_info +comments 
+xsmp_interact +xterm_clipboard -xterm_save 



#gvim是支持的
```

到http://www.vim.org/download.php下載源碼重新編譯,我下載的是vim-7.3.tar.bz2
```Shell
./configure --prefix=/usr \
--sysconfdir=/etc \
--enable-tclinterp \
--enable-pythoninterp \
--enable-perlinterp \
--enable-rubyinterp \
--enable-cscope \
--enable-multibyte \
--enable-xim \
--enable-gtk2-check \
--enable-fontset \
--with-x

[root@fedora vim73]# make

[root@fedora vim73]# make install
```

好了,這樣在終端就可以使用"+y進行複製了,跟gvim一樣
