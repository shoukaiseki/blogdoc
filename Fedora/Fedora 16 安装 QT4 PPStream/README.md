# Fedora 16 安装 QT4 PPStream  


### ---QT4.8.1---{{{2
```Shell
tar zxvf qt.tar.gz
 ./configure
 ./configure -release -nomake demos -nomake examples                #减少编译时间
 yum install qt4 qt4-devel libcurl libcurl-devel kernel-devel automake gcc-c++ glibc glibc-devel
 
 #提示Project ERROR: Package gstreamer-app-0.10 not found
 #安装
 yum install qt-gstreamer qt-gstreamer-devel
 
 
 gmake confclean
```
 
 

### ---PPStream---{{{2

```Shell
rpm –ivh PPStream.rpm
```
