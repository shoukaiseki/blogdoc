# python3安装salt

```sh
yum install -y python36-setuptools
easy_install-3.6 pip

pip3 install  pycrypto
pip3 install salt salt-ssh
```

### 错误
如果安装 pycrypto 出错

下载源码解压后执行
```sh
python3 setup.py install
```
进行安装

可以试着执行下 
```sh
sh configure -q
```
#### 如果出现以下错误
```
configure: error: in `/tmp/win/pycrypto-2.6.1':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
```
安装gcc编译器
```sh
yum -y install gcc
```

#### 如果出现以下错误
```
running install
running build
running build_py
running build_ext
running build_configure
warning: GMP or MPIR library not found; Not building Crypto.PublicKey._fastmath.
building 'Crypto.Hash._MD2' extension
gcc -pthread -Wno-unused-result -Wsign-compare -DDYNAMIC_ANNOTATIONS_ENABLED=1 -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv -fPIC -std=c99 -O3 -fomit-frame-pointer -Isrc/ -I/usr/include/python3.6m -c src/MD2.c -o build/temp.linux-x86_64-3.6/src/MD2.o
src/MD2.c:31:20: 致命错误：Python.h：没有那个文件或目录
 #include "Python.h"
                    ^
编译中断。
error: command 'gcc' failed with exit status 1
```

安装python的dev
```sh
#centos 是这个,具体跟
yum  install python36-devel
```
