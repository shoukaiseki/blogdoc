# Linux加载模块命令 

```Shell
安装模块
　　insmod *.ko
　　卸载模块
　　rmmod *.ko
　　查看已经安装的模块
　　lsmod
　　cat /proc/modules
　　查看模块输出
　　tail /var/log/messages
　　//
　　1．编译工具make
　　实际上，make 工具通过一个称为 Makefile 的文件来完成并自动维护编译工作。Makefile 需要按照某种语法进行编写，其中说明了如何编译各个源文件并连接生成可执行文件，并定义了源文件之间的依赖关系。下面给出2.6 内核模块的Makefile模板（请参看Makefile的写法）
　　# Makefile2.6
　　obj-m += hellomod.o # 产生hellomod 模块的目标文件
　　CURRENT_PATH := $(shell pwd) #模块所在的当前路径
　　LINUX_KERNEL := $(shell uname -r) #Linux内核源代码的当前版本
　　LINUX_KERNEL_PATH := /usr/src/linux-headers-$(LINUX_KERNEL) #Linux内核源代码的绝对路径
　　all:
　　make -C $(LINUX_KERNEL_PATH) M=$(CURRENT_PATH) modules #编译模块了
　　clean:
　　make -C $(LINUX_KERNEL_PATH) M=$(CURRENT_PATH) clean #清理
　　注意： 在每个命令前（例如make命令前）要键入一个制表符（按TAB键产生）
　　有了Makefile,执行make命令，会自动形成相关的后缀为.o和.ko文件。
　　到此，模块编译好了，该把它插入到内核了：
　　如：$insmod hellomod.ko
　　当然，要以系统员的身份才能把模块插入。
　　成功插入后，可以通过dmesg命令查看，屏幕最后几行的输出就是你程序中输出的内容：Hello,World! from the kernel space…
```
