# Linux  

```Shell
chmod +x 赋予用户执行权限
halt      普通用户关机命令
lsmod  查看加载的模块  lsmod >>ls.txt   信息输出到文件
lxtask  LXDE 计划的轻量级任务管理器
nautilus 打开主文件夹
system-config-users   管理用户及组群
which sh  查看sh命令路径
whereis sh 查看sh的来源
netstat -tlnp |grep smb   查看监听名包含smb的信息
su -oracle -c "lsnrctl start"    用oracle用户执行lsnrctlstart命令
ssh -l root 192.168.1.2      远程登录192.168.1.2

df -h  查看磁盘
ifconfig -a 查看网卡
watch -n 1 "/sbin/ifconfig eth0 | grep bytes" 查看网络流量,eth0为网卡
watch -n 1 -d netstat -ant   -d, --differences[=cumulative]       高亮显示变动 -n, --interval=<seconds>              周期(秒)
watch -d ' ping 10.0.0.185 | awk 'NR!=1{ intv=substr($7, 6); print 64/intv, "KB/s" }' '
watch -d free -m
uname -a 系统类型((uname)),查看内核版本(uname -r),SMP多处理器,当前时间,架构方式.具体uname --help
env 显示所有环境变量
top 终端下显示CPU使用率
ps -ef 终端查看进程
kill PID 杀死进程(PID为top中看到的PID)
pwd 显示当前目录位置
mount -t ntfs -o nls=utf8,umask=000 /dev/sda6 /media/usr
wine /media/usr/game/wc/Warcraft\ III.exe  -opengl

cp -f     覆盖不提示,如果提示可能之前执行过alias cp='cp -i'    unalias cp取消即可.  cp -r 递归

chkconfig iptables on   开启防火墙,重启后生效
chkconfig iptables off  关闭防火墙,重启后生效
service iptables start  开启防火墙,即时生效，重启后失效
service iptables stop  关闭防火墙,即时生效，重启后失效
```
