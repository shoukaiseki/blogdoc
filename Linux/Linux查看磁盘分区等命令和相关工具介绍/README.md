# Linux查看磁盘分区等命令和相关工具介绍

```Shell
转自http://linux.chinaitlab.com/set/39411.html
一、df 命令；
    df 是来自于coreutils 软件包，系统安装时，就自带的；我们通过这个命令可以查看磁盘的使用情况以及文件系统被挂载的位置；
    举例：
    [root@localhost beinan]# df -lh
    Filesystem            容量  已用 可用 已用% 挂载点
    /dev/hda8              11G  6.0G  4.4G  58% /
    /dev/shm              236M     0  236M   0% /dev/shm
    /dev/sda1              56G   22G   35G  39% /mnt/sda1
    我们从中可以看到,系统安装在/dev/hda8 ；还有一个56G的磁盘分区/dev/sda1挂载在 /mnt/sda1中；
    其它的参数请参考 man df
    二、fdsik
    fdisk 是一款强大的磁盘操作工具，来自util-linux软件包，我们在这里只说他如何查看磁盘分区表及分区结构；参数 -l ，通过-l 参数，能获得机器中所有的硬盘的分区情况；
[root@localhost beinan]# fdisk -l
Disk /dev/hda: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
   Device Boot Start End Blocks Id System
/dev/hda1 * 1 765 6144831 7 HPFS/NTFS
/dev/hda2 766 2805 16386300 c W95 FAT32 (LBA)
/dev/hda3 2806 7751 39728745 5 Extended
/dev/hda5 2806 3825 8193118+ 83 Linux
/dev/hda6 3826 5100 10241406 83 Linux
/dev/hda7 5101 5198 787153+ 82 Linux swap / Solaris
/dev/hda8 5199 6657 11719386 83 Linux
/dev/hda9 6658 7751 8787523+ 83 Linux
    在上面Blocks中，表示的是分区的大小，Blocks的单位是byte ，我们可以换算成M，比如第一个分区/dev/hda1的大小如果换算成M，应该是6144831/1024=6000M，也就是6G左右，其实没有这么麻烦，粗略的看一下把小数点向前移动三位，就知道大约的体积有多大了；
    System 表示的文件系统，比如/dev/hda1 是NTFS格式的；/dev/hda2 表示是fat32格式的文件系统；.
    在此例中，我们要特别注意的是/dev/hda3分区，这是扩展分区；他下面包含着逻辑分区，其实这个分区相当于一个容器；从属于她的有 hda5,hda6,hda7,hda8,hda9 ；
    我们还注意到一点，怎么没有hda4呢？为什么hda4没有包含在扩展分区？一个磁盘最多有四个主分区； hda1-4算都是主分区；hda4不可能包含在扩展分区里，另外扩展分区也算主分区；在本例中，没有hda4这个分区，当然我们可以把其中的一个分区设置为主分区，只是我当时分区的时候没有这么做而已；
    再仔细统计一下，我们看一看这个磁盘是不是还有空间？hda1+hda2+hda3=实际已经分区的体积，所以我们可以这样算 hda1+hda2+hda3=6144831+16386300+39728745 = 62259876 (b)，换算成M单位，小数点向前移三位，所以目前已经划分好的分区大约占用体积是62259.876(M)，其实最精确的计算62259876/1024=60800.67（M）；而这个磁盘大小是80.0 GB （80026361856byte)，其实实际大小也就是78150.744（M）；通过我们一系列的计算，我们可以得出这个硬盘目前还有使用的空间；大约还有18G未分区的空间；
    fdisk -l 能列出机器中所有磁盘的个数，也能列出所有磁盘分区情况；比如：
[root@localhost beinan]# fdisk -l
Disk /dev/hda: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
   Device Boot Start End Blocks Id System
/dev/hda1 * 1 765 6144831 7 HPFS/NTFS
/dev/hda2 766 2805 16386300 c W95 FAT32 (LBA)
/dev/hda3 2806 7751 39728745 5 Extended
/dev/hda5 2806 3825 8193118+ 83 Linux
/dev/hda6 3826 5100 10241406 83 Linux
/dev/hda7 5101 5198 787153+ 82 Linux swap / Solaris
/dev/hda8 5199 6657 11719386 83 Linux
/dev/hda9 6658 7751 8787523+ 83 Linux
Disk /dev/sda: 60.0 GB, 60011642880 bytes
64 heads, 32 sectors/track, 57231 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes
   Device Boot Start End Blocks Id System
/dev/sda1 1 57231 58604528 83 Linux
    通过上面我们可以知道此机器有两块硬盘，我们也可以指定fdisk -l 来查看其中一个硬盘的分区情况；
[root@localhost beinan]# fdisk -l /dev/sda
Disk /dev/sda: 60.0 GB, 60011642880 bytes
64 heads, 32 sectors/track, 57231 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes
   Device Boot Start End Blocks Id System
/dev/sda1 1 57231 58604528 83 Linux
    通过上面情况可以知道，在/dev/sda 这个磁盘中，只有一个分区；使用量差不多是百分百了；
    我们还可以来查看 /dev/hda的
[root@localhost beinan]# fdisk -l /dev/hda
    自己试试看？
    三、cfdisk 来自于util-linux的软件包；
    cfdisk 也是一款不错的分区工具；在有些发行版中，此工具已经从util-linux包中剔除；cfdisk 简单易用是他的特点；和DOS中的fdisk 相似；在本标题中，我们只来解说如何查看机器的中的磁盘分区状况及所用的文件系统等；
    查看磁盘分区的用法 cfdisk -Ps 磁盘设备名；
    比如
[root@localhost beinan]cfdisk -Ps
[root@localhost beinan]cfdisk -Ps /dev/hda
[root@localhost beinan]cfdisk -Ps
Partition Table for /dev/hda
               First Last
 # Type Sector Sector Offset Length Filesystem Type (ID) Flag
-- ------- ----------- ----------- ------ ----------- -------------------- ----
 1 Primary 0 23438834 63 23438835 Linux (83) Boot
 2 Primary 23438835 156296384 0 132857550 Extended (05) None
 5 Logical 23438835 155268224 63 131829390 Linux (83) None
 6 Logical 155268225 156296384 63 1028160 Linux swap (82) None
    我们只用的参数 -Ps，就列出了磁盘的分区情况；目前在Slackware Debian Mandrake 等主流发行版中存在cfdisk ，而fedora 4.0把这个小工具剔除了；有点可惜；这是我在Slackware中操作的；
    如果您这样操作，就更直观了；
    [root@localhost beinan]cfdisk 磁盘设备名
    举例：
    [root@localhost beinan]cfdisk /dev/hda
    您所看到的是如下的模式：

                                        cfdisk 2.12a
                                    Disk Drive: /dev/hda
                              Size: 80026361856 bytes, 80.0 GB
                    Heads: 255 Sectors per Track: 63 Cylinders: 9729
    Name Flags Part Type FS Type [Label] Size (MB)
 -------------------------------------------------------------------------------------------
    hda1 Boot Primary Linux ReiserFS 12000.69
    hda5 Logical Linux ReiserFS 67496.65
    hda6 Logical Linux swap 526.42
     [Bootable] [ Delete ] [ Help ] [Maximize] [ Print ] [ Quit ]
     [ Type ] [ Units ] [ Write ]
                        Toggle bootable flag of the current partition
    您进入了cfdisk 的操作界面；用键盘移动指针到[Quit]就可以退出；
    四、parted 功能不错的分区工具；在Fedora 4.0中有带，可以自己安装上；在此主题中，我们只说如何查看磁盘的分区情况；
    调用方法简单，parted 默认是打开的设备是/dev/hda ，也可以自己指定；比如 parted /dev/hda 或/dev/sda 等；退出的方法是 quit
    [root@localhost beinan]# parted
    使用 /dev/hda
    (parted) p
    /dev/hda 的磁盘几何结构：0.000-76319.085 兆字节
    磁盘标签类型：msdos
Minor 起始点 终止点 类型 文件系统 标志
1 0.031 6000.842 主分区 ntfs 启动
2 6000.842 22003.088 主分区 fat32 lba
3 22003.088 60800.690 扩展分区
5 22003.119 30004.211 逻辑分区 reiserfs
6 30004.242 40005.615 逻辑分区 reiserfs
7 40005.646 40774.350 逻辑分区 linux-swap
8 40774.381 52219.094 逻辑分区 ext3
9 52219.125 60800.690 逻辑分区 reiserfs
    我们在partd 的操作面上，用p就可以列出当前磁盘的分区情况，如果想要查看其它磁盘，可以用 select 功能，比如 select /dev/sda ；
    五、qtparted ，与parted 相关的软件还有qtparted ，也能查看到磁盘的结构和所用的文件系统，是图形化的；
    [beinan@localhost ~]# qtparted
    图形化的查看，一目了然；
Linux查看磁盘分区等命令和相关工具介绍 - Linux Fedora 15 - 蒋カイセキ的博客
点击小图看大图
    六、sfdisk 也是一个分区工具，功能也多多；我们在这里只说他的列磁盘分区情况的功能；
    [root@localhost beinan]# sfdisk -l
    自己看看吧；
    sfdisk 有几个很有用的功能；有兴趣的弟兄不妨看看；
    七、partx 也简要的说一说，有些系统自带了这个工具，功能也简单，和fdisk 、parted、cfdisk 来说不值一提；不用也罢；
    用法： partx 设备名
[root@localhost beinan]# partx /dev/hda
# 1: 63- 12289724 ( 12289662 sectors, 6292 MB)
# 2: 12289725- 45062324 ( 32772600 sectors, 16779 MB)
# 3: 45062325-124519814 ( 79457490 sectors, 40682 MB)
# 4: 0- -1 ( 0 sectors, 0 MB)
# 5: 45062388- 61448624 ( 16386237 sectors, 8389 MB)
# 6: 61448688- 81931499 ( 20482812 sectors, 10487 MB)
# 7: 81931563- 83505869 ( 1574307 sectors, 806 MB)
# 8: 83505933-106944704 ( 23438772 sectors, 12000 MB)
# 9: 106944768-124519814 ( 17575047 sectors, 8998 MB)
    八、查看目前机器中的所有磁盘及分区情况：
[beinan@localhost ~]$ cat /proc/partitions
major minor #blocks name
   3 0 78150744 hda
   3 1 6144831 hda1
   3 2 16386300 hda2
   3 5 8193118 hda5
   3 6 10241406 hda6
   3 7 787153 hda7
   3 8 11719386 hda8
   3 9 8787523 hda9
   8 0 58605120 sda
   8 1 58604528 sda1
   
    九、mac-fdisk 这个工具主要是用在Powerpc版本的Linux中，咱们常用X86版本中没有这个工具；这个只是介绍一下；
```
