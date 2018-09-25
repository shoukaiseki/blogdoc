# 重启后resolv.conf被重置固定IP设置

CentOS-7-x86_64-Minimal-1804.iso

/etc/resolv.conf 文件是系统dns解析使用的服务地址

按照 nameserver  的顺序进行解析域名


## DNS设置

直接修改 /etc/resolv.conf 虽然可以生效,但是重启后或者执行 systemctl restart NetworkManager 之后就会被重置


### 方法一:首先在网卡设置中修改NM_CONTROLLED的值：

修改文件/etc/sysconfig/network-scripts/ifcfg-eth0的内容：

没有则添加

```
NM_CONTROLLED="no"  //是否允许Network Manager管理，设置为no1
```

默认允许Network Manager管理DNS，所以首先设置为no，然后操作DNS设置



### 方法二:设置DNS内容：

修改DNS可以有如下两种方案：



①、修改网卡设置：

在/etc/sysconfig/network-scripts/ifcfg-eth0中修改内容：

```
PEERDNS="yes"
DNS1="xxx.xxx.xxx.xxx"
DNS2="xxx.xxx.xxx.xxx"123
```

这种设置方案是以网卡中设置的DNS为主，resolv.conf中按照网卡设置的DNS内容自动生成，以后想修改DNS，必须修改网卡中的设置才不会在服务器重启之后出现DNS设置失效的问题。

②、直接修改/etc/resolv.conf的值：

PS.需要注意的是，若要使直接修改的DNS内容不会在服务器重启之后丢失，需要设置网卡中PEERDNS的值为no：

```
nameserver xxx.xxx.xxx.xxx
nameserver xxx.xxx.xxx.xxx12
```



3、修改完毕之后重启网卡：

service network restart1

按照上面任意一种方案修改DNS设置之后都不会出现重启服务器DNS设置复原的情况。




## 固定IP设置

执行 ifconfig -a 查看网卡名称

```
[root@localhost ~]# ifconfig -a
ens192: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.200  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::20c:29ff:fe65:48c8  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:65:48:c8  txqueuelen 1000  (Ethernet)
        RX packets 3581  bytes 589967 (576.1 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1732  bytes 673220 (657.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 1115  bytes 217834 (212.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1115  bytes 217834 (212.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[root@localhost ~]# 
```

网卡名为 ens192

```
[root@localhost ~]# cat /etc/sysconfig/network-scripts/ifcfg-ens192
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ens192
UUID=2eede23c-d529-4809-92bf-314e8da9139e
DEVICE=ens192
ONBOOT=yes
PREFIX=24
GATEWAY=192.168.0.1
IPV6_PRIVACY=no
PEERDNS=yes
DNS1=192.168.0.200
DNS2=114.114.114.114
IPADDR=192.168.0.200
NETMASK=255.255.255.0
NM_CONTROLLED=no
```

其中的 BOOTPROTO , IPADDR ,NETMASK,NM_CONTROLLED 几个参数设置好就行

之后执行  systemctl restart network 重启网卡即可



```
如果以上修改完成重启network服务后（service network restart）仍无法联网，可以尝试以下方法：
1. 在ifcfg-ens192文件中修改BOOTPROTO为none，IPADDR为192.168.1.9，GATEWAY为192.168.1.1
2. shell中执行命令（nmcli con mod ens192 ipv4.dns "192.168.0.200 114.114.114.114"）设置DNS
3. 继续执行命令（nmcli con up ens192）是设置生效
4. 重启network服务（systemctl  restart network） 后，使用ping命令查看联网状态。
使用命令设置DNS并使其生效后，ifcfg-ens192文件内容自动修改

BOOTPROTO: 系统启动的地址协议，可选参数static(静态地址)，dhcp(DHCP动态地址)，none(不指定地址)，bootp(BOOTP协议)
IPADDR: IP地址
NETMASK: 子网掩码
NM_CONTROLLED: Network Manager参数，yes(使用Network Manager管理网卡)，no(不适用Network Manager管理网卡)
```


https://blog.csdn.net/w670328683/article/details/61923858

https://blog.csdn.net/rossisy/article/details/77855798
