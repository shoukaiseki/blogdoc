# Linux格式化磁盘mkfs mkswap fsck  


```Shell
mkfs.ext3 mkfs.reiserfs mkfs.ext2 mkfs.msdos mkfs.vfat mke2fs 的介绍；
我们先说了一个mkfs 工具后，我们再来介绍 mkfs.ext3 mkfs.reiserfs mkfs.ext2 mkdosfs mkfs.msdos mkfs.vfat ，其实mkfs 在执行的命令的时候，也是调用的这个工具，这也是我先把mkfs介绍的主要原因； 
通过文件名，我们就知道这些工具是支持什么文件系统；这些命令为我们提供了更多的方便； 
[root@localhost beinan]# mkfs.ext3 /dev/sda6 注：把该设备格式化成ext3文件系统 
[root@localhost beinan]# mke2fs -j /dev/sda6 注：把该设备格式化成ext3文件系统 
[root@localhost beinan]# mkfs.ext2 /dev/sda6 注：把该设备格式化成ext2文件系统 
[root@localhost beinan]# mkfs.reiserfs /dev/sda6 注：把该设备格式化成reiserfs文件系统 
[root@localhost beinan]# mkfs.vfat /dev/sda6 注：把该设备格式化成fat32文件系统 
[root@localhost beinan]# mkfs.msdos /dev/sda6 注：把该设备格式化成fat16文件系统,msdos文件系统就是fat16； 
[root@localhost beinan]# mkdosfs /dev/sda6 注：把该设备格式化成fat16文件系统，同mkfs.msdos 
... ... 
mkswap 把一个分区格式化成为swap交换区；[root@localhost beinan]# mkswap /dev/sda6 注：创建此分区为swap 交换分区 
[root@localhost beinan]# swapon /dev/sda6 注：加载交换分区； 
[root@localhost beinan]# swapoff /dev/sda6 注：关闭交换分区； 
查看系统已经加载的swap交换分区； 
[root@localhost beinan]# swapon /dev/sda6 注：加载交换分区； 
[root@localhost beinan]# swapon -s 
Filename Type Size Used Priority 
/dev/hda7 partition 787144 0 -1 
/dev/sda6 partition 225144 0 -3 
为什么系统有两个交换分区？因为我用U盘做实验；sda6是我在U盘上建的swap分区； 
如果让swap开机就加载，应该改 /etc/fstab文件，加类似如下一行； 
/dev/sda6 swap swap defaults 0 0 注：把此行中的/dev/hda7 改为您的交换分区就行； 
或者把命令写入 /etc/rc.d/rc.local也行； 
swapon /dev/sda6 
如果您的硬盘不能再分区，可以创建swap文件 
[root@localhost beinan]# dd if=/dev/zero of=/tmp/swap bs=1024 count=524288 注：创建一个大小为512M 的swap 文件，在/tmp目录中；您可以根据自己的需要的大小来创建swap 文件； 
读入了 524288+0 个块 
输出了 524288+0 个块 
[root@localhost beinan]# mkswap /tmp/swap 注：把/tmp/swap 文件，创建成swap 交换区 
Setting up swapspace version 1, size = 536866 kB 
no label, UUID=d9d8645d-92cb-4d33-b36e-075bb0a2e278 
[root@localhost beinan]# swapon /tmp/swap 注：挂载swap 
[root@localhost beinan]# swapon -s 
Filename Type Size Used Priority 
/dev/hda7 partition 787144 888 -1 
/tmp/swap file 524280 0 -2 
注意：其实我们在安装系统的时候，就已经划分了交换分区；查看/etc/fstab，应该swap的行；如果您在安装系统时没有添加swap，可以通过这种办法来添加； 
对文件系统扫描fsck；
fsck扫描，还能修正文件系统的一些问题。值得注意的是fsck 扫描文件系统时一定要在单用户模式、修复模式或把设备umount后进行。 
警告：如果扫描运行中的系统，会造成系统文件损坏
以Fedora 为例，文件系统扫描工具有 fsck fsck.ext2 fsck.jfs fsck.msdos fsck.vfat fsck.ext3 fsck.reiserfs（reiserfsck） 
最好根据文件系统来调用不同的扫描工具，如 fsck.ext2，fsck.jfs，fsck.msdos，fsck.ext3，fsck.reiserfs等。
举例：扫描/dev/hda10分区（基于reiserfs文件系统 ）； 
[root@localhost beinan]# fsck.reiserfs /dev/hda10 
reiserfsck 3.6.19 (2003 www.namesys.com) 
** If you are using the latest reiserfsprogs and it fails ** 
** please email bug reports to reiserfs-list@namesys.com, ** 
** providing as much information as possible -- your ** 
** hardware, kernel, patches, settings, all reiserfsck ** 
** messages (including version), the reiserfsck logfile, ** 
** check the syslog file for any related information. ** 
** If you would like advice on using this program, support ** 
** is available for $25 at www.namesys.com/support.html. ** 
Will read-only check consistency of the filesystem on /dev/hda10 
Will put log info to 'stdout' 
Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes 
reiserfsck --check started at Wed Sep 14 08:54:17 2005 
########### 
Replaying journal.. 
Reiserfs journal '/dev/hda10' in blocks [18..8211]: 0 transactions replayed 
Checking internal tree..finished 
Comparing bitmaps..finished 
Checking Semantic tree: 
finished 
No corruptions found 注：没有发现错误； 
fsck.ext2和fsck.ext3常用选项： 
-p Automatic repair (no questions) 注：自动修复文件系统存在的问题； 
-y Assume "yes" to all questions 注：如果文件系统有问题，会跳出提示是否修复，如果修复请按y； 
-c Check for bad blocks and add them to the badblock list 注：对文件系统进行坏块检查；这是一个极为漫长的过程； 
-n Make no changes to the filesystem 注：不对文件系统做任何改变，只要扫描，以检测是否有问题； 
举例：/dev/hda6 （ext3的），我想扫描并自动修复； 
[root@localhost beinan]# fsck.ext3 -p /dev/hda6 
```
