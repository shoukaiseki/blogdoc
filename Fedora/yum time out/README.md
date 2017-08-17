# yum time out  

http://mirrors.163.com/fedora/releases/17/Everything/i386/os/repodata/repomd.xml: [Errno 12] Timeout on http://mirrors.163.com/fedora/releases/17/Everything/i386/os/repodata/repomd.xml: (28, '')
<br>
尝试其他镜像。
<br>
換成其它鏡像也一樣,鬱悶到極點,瀏覽器都訪問網絡好好的,咋怎的.
<br>
瀏覽器訪問http://mirrors.163.com/fedora/releases/17/Everything/i386/os/repodata/repomd.xm都正常的

科学技术大学的額外包也超時,瀏覽器訪問也都正常,還是該wget吧


```Shell
su -c 'yum localinstall --nogpgcheck http://mirrors.ustc.edu.cn/fedora/rpmfusion/free/fedora/rpmfusion-free-release-stable.noarch.rpm \
http://mirrors.ustc.edu.cn/fedora/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm'
get  http://mirrors.ustc.edu.cn/fedora/rpmfusion/free/fedora/rpmfusion-free-release-stable.noarch.rpm \
```

http://mirrors.ustc.edu.cn/fedora/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm 盡然顯示目標地址 107.21.201.72:8087 一查這IP,是美國的,原來是代理惹得禍,原先在google-chrome安裝過Proxy Switchy!汉化版,這垃圾插件,無法代理,鳥用都沒有,直接卸載,後來裝了 Proxy SwitchyPlus汉化版 ,哪知道原先哪個設置的是系統代理
<br>
之後直接刪除
```
~/.gconf/system/http_proxy/%gconf.xml 
```
OK了.
<br />
代理設置還有個文件在~/.gconf/system/proxy目錄下
