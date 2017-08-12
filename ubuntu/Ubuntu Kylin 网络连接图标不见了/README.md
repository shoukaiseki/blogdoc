# Ubuntu Kylin 网络连接图标不见了

系统版本为Ubuntu Kylin 14.04

之前用的好好的，突然之间怎么就没网络连接图标了，点了系统设置里面的网络，提示异常
```
vim /etc/NetworkManager/NetworkManager.conf

文件内容如下：
[main]
plugins=ifupdown,keyfile,ofono
dns=dnsmasq

no-auto-default=F4:6D:04:89:86:38,

[ifupdown]
managed=false


ip link set wlan0 up
iwconfig wlan0 txpower on
ifconfig wlan0  up
iwlist wlan0 scanning|grep ESSID

 iwconfig wlan0 essid "CMCC-WEB"

#不支持WPA加密密码
#iwconfig wlan0 essid "CMCC-WEB" key s:1234567890



iwconfig wlan0 ap auto
#自动获取DHCP IP可能需要一些时间
dhclient wlan0

#按照gnome管理工具
```



最后连接上CMCC-WEB，然后浏览器访问到移动wifi登录页面，

淘宝购买了一天的移动wifi帐号，然后重新按照network-manager-gnome，再进行系统更新解决的问题

apt-get install network-manager-gnome network-manager-openvpnnetwork-manager-vp
