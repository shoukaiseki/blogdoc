# Yum使用插件来加速 

### 1，使用axel来作为下载工具。
```
yum install axel
[luyao@localhost btdown]$ wget http://wilmer.gaast.net/downloads/axel-1.0b.tar.gz
[luyao@localhost btdown]$ tar zxvf axel-1.0b.tar.gz
[luyao@localhost btdown]$ cd axel-1.0b
[luyao@localhost btdown]$ ./configure --i18n=1
[luyao@localhost btdown]$ make
[root@localhost btdown]# make install 
[luyao@localhost btdown]$ wget http://cnfreesoft.googlecode.com/svn/trunk/axelget/axelget.conf
[luyao@localhost btdown]$ wget http://cnfreesoft.googlecode.com/svn/trunk/axelget/axelget.py
[root@localhost btdown]# cp axelget.conf /etc/yum/pluginconf.d/
[root@localhost btdown]# cp axelget.py /usr/lib/yum-plugins/
```

### 2，使用fastmirror让它自动匹配最快的源
```
[root@localhost yum.repos.d]# yum install yum-fastestmirror
```

### 3，尝试更新一下，OK，所用的插件都正常。
```
[root@localhost luyao]# yum list
Loaded plugins: axelget, fastestmirror, refresh-packagekit
Loading mirror speeds from cached hostfile
........
```
