# 为Fedora 16设置国内yum源  

为Fedora 16设置国内yum源   

也可查看源自己添加http://mirrors.fedoraproject.org/publiclist/Fedora/
## 1）先删除/etc/yum.repos.d/下的所有文件

```Shell
su
cd /etc/yum.repos.d/
mkdir bak
cp *.* ./bak
rm -rf *.*
```

## 2）添加上海交大源，将以下内容保存为 /etc/yum.repos.d/sjtu.repo

sudo gedit sjtu.repo

```Repo
[Fedora-ftp.sjtu.edu.cn]
name=Fedora 16 – i386
baseurl=http://ftp.sjtu.edu.cn/fedora/linux/releases/16/Fedora/i386/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora
[Everything-ftp.sjtu.edu.cn]
name=Everything 16 – i386
baseurl=http://ftp.sjtu.edu.cn/fedora/linux/releases/16/Everything/i386/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora
[updates-ftp.sjtu.edu.cn]
name=Fedora updates
baseurl=http://ftp.sjtu.edu.cn/fedora/linux/updates/16/i386/
enabled=1
gpgcheck=0
```

## 3）添加163源，将以下内容保存为 /etc/yum.repos.d/163.repo

sudo gedit 163.repo
```Repo

[Fedora-mirrors.163.com]
name=Fedora 16 – i386
baseurl=http://mirrors.163.com/fedora/updates/16/i386/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora file:///etc/pki/rpm-gpg/RPM-GPG-KEY
[Everything-mirrors.163.com]
name=Everything 16 – i386
baseurl=http://mirrors.163.com/fedora/updates/16/i386/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora file:///etc/pki/rpm-gpg/RPM-GPG-KEY
[updates-mirrors.163.com]
name=Fedora updates
baseurl=http://mirrors.163.com/fedora/updates/16/i386/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora file:///etc/pki/rpm-gpg/RPM-GPG-KEY
```

## 4）添加搜狐源

将以下内容保存为/etc/yum.repos.d/Fedora-sohu.repo

```Repo
sudo gedit Fedora-sohu.repo

[Fedora]
name=Fedora $releasever - $basearch - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/releases/$releasever/Everything/$basearch/os/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
enabled=1
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch

[Fedora-debuginfo]
name=Fedora $releasever - $basearch - Debug - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/releases/$releasever/Everything/$basearch/debug/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=fedora-debug-$releasever&arch=$basearch
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch

[Fedora-source]
name=Fedora $releasever - Source - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/releases/$releasever/Everything/source/SRPMS/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=fedora-source-$releasever&arch=$basearch
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch
```



将以下内容保存为/etc/yum.repos.d/Fedora-updates-sohu.repo

```Repo
sudo gedit Fedora-updates-sohu.repo

[updates]
name=Fedora $releasever - $basearch - Updates - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/updates/$releasever/$basearch/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch

[updates-debuginfo]
name=Fedora $releasever - $basearch - Updates - Debug - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/updates/$releasever/$basearch/debug/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=updates-released-debug-f$releasever&arch=$basearch
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch

[updates-source]
name=Fedora $releasever - Updates Source - sohu.com
failovermethod=priority
baseurl=http://mirrors.sohu.com/Fedora/updates/$releasever/SRPMS/
mirrorlist=https://mirrors.Fedoraproject.org/metalink?repo=updates-released-source-f$releasever&arch=$basearch
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Fedora-$basearch

```


5）在终端里依次运行yum clean all 和yum makecache即可
```Shell
yum clean all
yum makecache
```
