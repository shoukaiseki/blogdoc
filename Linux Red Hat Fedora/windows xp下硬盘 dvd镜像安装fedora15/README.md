# windows xp下硬盘 dvd镜像安装fedora15  

windows xp下硬盘 dvd镜像安装fedora15

映像：Fedora-15-i386-DVD.iso

原系统：windows xp sp3

安装注意：
	一、grub4dos软件。
	二、把fedora映像放在fat32分区，且本分区一定是主分区，不能是逻辑分区。

 安装步骤：
### 1、在c盘根目录下边的boot.ini文件中添加，C:\grldr="install fedora15"这一行。（注意要去除本文件的只读属性才能保存）。
### 2、解压grub4dos中的grldr和menu.lst文件到c盘根目录。
### 3、将fedora15镜像放到fat32某分区根目录（必须为主分区）。（最重要）
### 4、解压fedora15的镜像中的initrd.img、vmlinuz文件到c盘根目录。
### 5、在menu.lst文件中添加以下四行（注意必须添加linux askmethod，在安装时，它将提供给你选择硬盘安装fedora15的选择机会）：
```
     title "install fedora 15"
     kernel (hd0,0)/vmlinuz linux askmethod
     initrd (hd0,0)/initrd.img
     boot
```
### 6、重启电脑，选择“install fedora 15”开始吧。
 
下图是fedoraproject官方的硬盘安装时的要求：
 
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Linux%20Red%20Hat%20Fedora/windows%20xp%E4%B8%8B%E7%A1%AC%E7%9B%98%20dvd%E9%95%9C%E5%83%8F%E5%AE%89%E8%A3%85fedora15/img/001.jpg)
 
本文来自:http://hi.baidu.com/396954504/blog/item/0bf3dc084dd412c862d986a6.html

