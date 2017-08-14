# Linux下运行Warcraft需要打开的端口  

```Shell
#!/bin/sh
#warcraft
iptables -I INPUT -p tcp --dport 6112 -j ACCEPT
iptables -I INPUT -p udp --dport 6112 -j ACCEPT
iptables -A INPUT -p tcp --dport 6112 -j ACCEPT
iptables -A INPUT -p udp --dport 6112 -j ACCEPT
service iptables save
service iptables start
chkconfig iptables on
#wine /media/usr/game/wc/Warcraft\ III.exe  -opengl
#wine d:/game/wc/Warcraft\ III.exe  -opengl
su fedora -c 'wine d:/game/wc/Frozen\ Throne.exe  -opengl'
```
