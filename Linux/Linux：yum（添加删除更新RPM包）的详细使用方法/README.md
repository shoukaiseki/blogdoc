# Linux：yum（添加/删除/更新RPM包）的详细使用方法  

```
yum是什么
yum = Yellow dog Updater, Modified
主要功能是更方便的添加/删除/更新RPM包.
它能自动解决包的倚赖性问题.
它能便于管理大量系统的更新问题
yum特点
可以同时配置多个资源库(Repository)
简洁的配置文件(/etc/yum.conf
自动解决增加或删除rpm包时遇到的倚赖性问题
使用方便
保持与RPM数据库的一致性
yum安装
CentOS自带(yum-*.noarch.rpm)
#rpm -ivh yum-*.noarch.rpm
在第一次启用yum之前首先需要导入系统的RPM-GPG-KEY：
#rpm --import /usr/share/doc/centos-release-3(4)/RPM-GPG-KEY-CentOS-3(4)
yum指令
注:当第一次使用yum或yum资源库有更新时,yum会自动下载所有所需的headers放置于/var/cache/yum目录下,所需时间可能较长.
rpm包的更新
检查可更新的rpm包
#yum check-update
更新所有的rpm包
#yum update
更新指定的rpm包,如更新kernel和kernel source
#yum update kernel kernel-source
大规模的版本升级,与yum update不同的是,连旧的淘汰的包也升级
#yum upgrade
rpm包的安装和删除
安装rpm包,如xmms-mp3
#yum install xmms-mp3
删除rpm包,包括与该包有倚赖性的包
#yum remove licq
注:同时会提示删除licq-gnome,licq-qt,licq-text
yum暂存(/var/cache/yum/)的相关参数
清除暂存中rpm包文件
#yum clean packages
清除暂存中rpm头文件
#yum clearn headers
清除暂存中旧的rpm头文件
#yum clean oldheaders
清除暂存中旧的rpm头文件和包文件
#yum clearn 或#yum clearn all
注:相当于yum clean packages + yum clean oldheaders
包列表
列出资源库中所有可以安装或更新的rpm包
#yum list
列出资源库中特定的可以安装或更新以及已经安装的rpm包
#yum list mozilla
#yum list mozilla*
注:可以在rpm包名中使用匹配符,如列出所有以mozilla开头的rpm包
列出资源库中所有可以更新的rpm包
#yum list updates
列出已经安装的所有的rpm包
#yum list installed
列出已经安装的但是不包含在资源库中的rpm包
#yum list extras
注:通过其它网站下载安装的rpm包
rpm包信息显示(info参数同list)
列出资源库中所有可以安装或更新的rpm包的信息
#yum info
列出资源库中特定的可以安装或更新以及已经安装的rpm包的信息
#yum info mozilla
#yum info mozilla*
注:可以在rpm包名中使用匹配符,如列出所有以mozilla开头的rpm包的信息
列出资源库中所有可以更新的rpm包的信息
#yum info updates
列出已经安装的所有的rpm包的信息
#yum info installed
列出已经安装的但是不包含在资源库中的rpm包的信息
#yum info extras
注:通过其它网站下载安装的rpm包的信息
搜索rpm包
搜索匹配特定字符的rpm包
#yum search mozilla
注:在rpm包名,包描述等中搜索
搜索有包含特定文件名的rpm包
#yum provides realplay
增加资源库
例如:增加rpm.livna.org作为资源库
安装Livna.org rpms GPG key
#rpm --import http://rpm.livna.org/RPM-LIVNA-GPG-KEY
检查GPG Key
# rpm -qa gpg-pubkey*
显示Key信息
#rpm -qi gpg-pubkey-a109b1ec-3f6e28d5
(注:如果要删除Key,使用#rpm -e gpg-pubkey-a109b1ec-3f6e28d5)
添加yum源

添加yum源，可以都放在 /etc/yum.repos.d/ 目录下，一个源一个文件，后缀是repo就可以了。系统本身有两个文件，都是国外的源，比较慢，可以把他们备份，使用国内的源来更新。

这些源互相的差别

单独使用中科大的更新源：是2658个包

单独使用freshrpms，是514个包。

单独rpmforge，是4471个包

那么如果我使用3个源（不包括rpmforge），是2822个包，其中dvd是1784个包。freshrpms是164，其他就是从中科大下载的。

所有可以看出来yum还是很聪明的，自动本地的是最快的，

刚刚又添加了一个rpmforge源，这个源太厉害了，一下子就多了3979个包。这可不是全部啊，这是别的没有，就他有的包啊。

现在我的机器了可以更新的包是6668个包。

rpmforge，这个太牛了，昨天研究pxe安装xp，需要安装cabextract，我到处搜索找这个包都没有找到，最后在cu上找到一个源码包，编译安装，搞了半天才搞定，没有想到，现在我直接yum就搞定了。

rpmforge，这个源的包基本都是独有的，

还有一点就是需要注意的，rhms，一个redhat的邮件解决方案，把把所有需要用到的rpm包下载到本地，再通过yum来安装。非常方便。

六：各种源

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.save

mv /etc/yum.repos.d/CentOS-Media.repo /etc/yum.repos.d/CentOS-Media.repo.save

1：使用本地光驱

mkdir /mnt/dvd

mount /dev/cdrom /mnt/dvd

创建 dvdiso.repo 文件，添加下面内容。

vi /etc/yum.repos.d/dvdiso.repo

[DVDISO]

name=DVD ISO

baseurl=file:///mnt/dvd

enabled=1

gpgcheck=0

2：使用中科大的源

创建ustc.repo 文件

######################

[base]

name=CentOS-5 - Base

repo=os

baseurl=http://centos.ustc.edu.cn/centos/5.2/os/$basearch/

gpgcheck=1

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

[update]

name=CentOS-5 - Updates

baseurl=http://centos.ustc.edu.cn/centos/5.2/updates/$basearch/

gpgcheck=1

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

[addons]

name=CentOS-5 - Addons

baseurl=http://centos.ustc.edu.cn/centos/5.2/addons/$basearch/

gpgcheck=1

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

[extras]

name=CentOS-5 - Extras

baseurl=http://centos.ustc.edu.cn/centos/5.2/extras/$basearch/

gpgcheck=1

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

[centosplus]

name=CentOS-5 - Plus

baseurl=http://centos.ustc.edu.cn/centos/5.2/centosplus/$basearch/

gpgcheck=1

enabled=0

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

[contrib]

name=CentOS-5 - Contrib

baseurl=http://centos.ustc.edu.cn/centos/5.2/contrib/$basearch/

gpgcheck=1

enabled=0

gpgkey=http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-5

###################

rpm --import http://centos.ustc.edu.cn/centos/5.2/os/i386/RPM-GPG-KEY-CentOS-5

使用freshrpms源

创建 freshrpms.repo 文件

[freshrpms]

name=Fedora Linux $releasever - $basearch - freshrpms

baseurl=http://ayo.freshrpms.net/fedora/linux/$releasever/$basearch/freshrpms

gpgcheck=1

rpm --import http://freshrpms.net/packages/RPM-GPG-KEY.txt

使用rpmforge一个源

wget http://dag.wieers.com/rpm/packages/rpmforge-release/rpmforge-release-0.3.6-1.el5.rf.i386.rpm

rpm -Uvh rpmforge-release-0.3.6-1.el5.rf.i386.rpm

下面这个源，可以安装webmin，创建/etc/yum.repos.d/Doylenet.repo

[doylenet]

name=Doylenet custom repository for CentOS

baseurl=http://files.doylenet.net/linux/yum/centos/5/i386/doylenet/

gpgcheck=1

gpgkey=http://files.doylenet.net/linux/yum/centos/RPM-GPG-KEY-rdoyle

enabled=1

yum install webmin


```
