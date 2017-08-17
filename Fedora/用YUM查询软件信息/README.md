# 用YUM查询软件信息

```
    yum的参数
            install  (非全名) 安装软件包    info   查看软件包的摘要信息
            remove/erase 删除包 (使用remove时注意,它会删除所有有依赖关系的包)
            groupinstall    安装软件包组  groupinfo   groupremove
            grouplist  查看软件包组
            localinstall 安装本地软件包(yum可解决依赖关系)
            reinstall重新安装        serach 软件包的简要信息(不精确)
            check-update 检查可更新的包  repolist  已安装好yum库
           -y 不询问安装         -q 静默模式安装      -d调试级别
           -t忽略已安装的包(安装多个包时,否则后面的包都不安装)]
           --nogpgcheck指定不需要验证签名信息
        yum两个常用的参数
                  list   all   显示所有软件包(可使用通配符搜索) list "na*"
                         available 所有可安装的包
                         update  可升级的包
                         installed 已安装的包
                         exeras 额外的包(不属于yum库的包)
                         obletes 已过时的包
                         recent 刚加入yum库的包
                clean  all  清空所有信息
                         package 清空软件包信息
                         headers 首部 ,包的依赖关系
                         dbcahe  软件包的元数据信息(数据库)
用YUM查询软件信息
我们常会碰到这样的情况，想要安装一个软件，只知道它和某方面有关，但又不能确切知道它的名字。这时yum的查询功能就起作用了。你可以用yum search keyword这样的命令来进行搜索，比如我们要则安装一个Instant Messenger，但又不知到底有哪些，这时不妨用yum search messenger这样的指令进行搜索，yum会搜索所有可用rpm的描述，列出所有描述中和messeger有关的rpm包，于是我们可能得到gaim，kopete等等，并从中选择。
有时我们还会碰到安装了一个包，但又不知道其用途，我们可以用yum info packagename这个指令来获取信息。
1.使用YUM查找软件包
命令：yum search 
2.列出所有可安装的软件包
命令：yum list
3.列出所有可更新的软件包
命令：yum list updates
4.列出所有已安装的软件包
命令：yum list installed
5.列出所有已安装但不在 Yum Repository ?的软件包
命令：yum list extras
6.列出所指定的软件包
命令：yum list 
7.使用YUM获取软件包信息
命令：yum info 
8.列出所有软件包的信息
命令：yum info
Array.列出所有可更新的软件包信息
命令：yum info updates
10.列出所有已安?的软件包信息
命令：yum info installed
11.列出所有已安?但不在 Yum Repository ?的软件包信息
命令：yum info extras
12.列出软件包提供哪些文件
命令：yum provides 
六、清除YUM缓存
yum会把下载的软件包和header存储在cache中，而不会自动删除。如果我们觉得它们占用了磁盘空间，可以使用yum clean指令进行清除，更精确的用法是yum clean headers清除header，yum clean packages清除下载的rpm包，yum clean all一股脑儿端
1.清除缓存目录(/var/cache/yum)下的软件包
命令：yum clean packages
2.清除缓存目录(/var/cache/yum)下的 headers
命令：yum clean headers
3.清除缓存目录(/var/cache/yum)下旧的 headers
命令：yum clean oldheaders
4.清除缓存目录(/var/cache/yum)下的软件包及旧的headers
命令：yum clean, yum clean all (= yum clean packages; yum clean oldheaders)
附：
由于 Fedora 的 yum
预设的更新主机在外国，也就是 Fedora 的官方更新主机
连线到国外下载，速度之慢，可想而知....
在这里，我们可以修改 yum 的配置文件
把连线主机，改成国内各大学的 Linux 更新主机，如此速度就会比较快
------------------------
/etc/yum.conf
-----------------------
[base]
name=Fedora Core $releasever - $basearch - Base baseurl=http://download.fedora.redhat.com/pub/fedora/linux/core/$releasever/$basearch/os/
[updates-released]
name=Fedora Core $releasever - $basearch - Released Updates baseurl=http://download.fedora.redhat.com/pub/fedora/linux/core/updates/$releasever/$basearch/
注意红色的地方，就是 yum 会去连接的更新主机网址
改成以下，可自由选择搭配
base 主机：
(大小写有差别，请先实际连接测试，看看服务器是否仍存在)
http://ftp.isu.edu.tw/pub/Linux/Fed...core/1/i386/os/
http://linux.nctu.edu.tw/ftp/dists/...core/1/i386/os/
ftp://ftp.isu.edu.tw/pub/Linux/Fedo...core/1/i386/os/
ftp://linux.nctu.edu.tw/dists/fedora/core/1/i386/os/
ftp://linux.sinica.edu.tw/fedora/linux/core/1/i386/os/
updates 主机：
(大小写有差别，请先实际测试连接，看看服务器是否仍存在)
http://ftp.isu.edu.tw/pub/Linux/Fed...updates/1/i386/
http://linux.nctu.edu.tw/ftp/dists/...updates/1/i386/
ftp://ftp.isu.edu.tw/pub/Linux/Fedo...updates/1/i386/
ftp://linux.nctu.edu.tw/dists/fedor...updates/1/i386/
ftp://linux.sinica.edu.tw/fedora/li...updates/1/i386/
路径中的 /1/ 是代表 core 1
如是使用core 2，请自行改成 /2/
改完后保存，不必重启服务，立刻生效
然后 yum 的更新速度就?飞快了
Fedora core 3 和 4 的 yum base 配置设定法：
FC3 和 FC4 的 yum base 配置设定，有别于之前 FC2
并不是在 /etc/yum.conf 中设定
设定方法如下:
cd /etc/yum.repos.d/
vi fedora.repo (设定 base 主机，仅列出需要修改处)
baseurl=http://ftp.isu.edu.tw/pub/Linux/Fedora/linux/core/$releasever/$basearch/os/
#mirrorlist=http://fedora.redhat.com/download/mirrors/fedora-core-$releasever
vi fedora-updates.repo (设定 update 主机，仅列出需要修改处)
baseurl=http://ftp.isu.edu.tw/pub/Linux/Fedora/linux/core/updates/$releasever/$basearch/
#mirrorlist=http://fedora.redhat.com/download/mirrors/updates-released-fc$releasever
```
