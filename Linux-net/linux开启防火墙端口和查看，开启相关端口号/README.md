# linux开启防火墙端口和查看，开启相关端口号

linux开启防火墙端口和查看，开启相关端口号

当Linux打开防火墙后，你会发现，从本机登录23端口是没有问题的，但是如果从另一台pc登录该linux系统后，你会发现提示这样的错误： 

不能打开到主机的连接， 在端口 23: 连接失败 

因为linux防火墙默认是关闭23端口的，如果允许远程登录，可以关掉防火墙，也可以开防火墙开放23端口，具体如下： 

即时生效，重启后失效 

开启： service iptables start 

关闭： service iptables stop 

重启后生效 

开启： chkconfig iptables on 

关闭： chkconfig iptables off 

在开启了防火墙时，做如下设置，开启相关端口 

修改/etc/sysconfig/iptables 文件，添加以下内容： 

-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 23 -j ACCEPT

查看防火墙 iptables -L

------------------

```Shell
netstat -nupl (UDP类型的端口)
netstat -ntpl (TCP类型的端口)
```
你可以使用 lsof 命令来查看某一端口是否开放。查看端口可以这样来使用，我就以80端口为例：

lsof -i:80

如果有显示说明已经开放了，如果没有显示说明没有开放。

