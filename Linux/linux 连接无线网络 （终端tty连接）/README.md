# linux 连接无线网络 （终端tty连接）  

1. 打开无线网卡电源

iwconfig wlan0 txpower on

2. 列出区域内的无线网络

iwlist wlan0 scan

3. 假设要连接到网络guys（即essid为guys的网络，essid就是你设置的名称），那么输入命令

iwconfig wlan0 essid "guys"

如果网络是加密的，密码是0592121314 ，那么就输入命令

iwconfig wlan0 essid "guys" key 0592121314

4. 如果正常的话，输入

iwconfig wlan0

就可以看到连接正常的各项参数了。

5. 启用无线网卡

ifconfig wlan0 up

6. 如果是用DHCP获取IP的，那么用dhclient 或dhcpcd获取ip

dhclient wlan0

或

dhcpcd wlan0

7. ping www.google.com
