# 修改GURB菜单让Linux直接进入字符界面

grub的话kernel那一行行未直接加个空格3

例如:

原
```Shell
kernel /boot/vmlinuz-2.6.38.8-32.fc15.i686.PAE ro root=UUID=3c179835-52a2-4d6a-b525-6c06771bdbaa rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
```
修改后
```Shell
kernel /boot/vmlinuz-2.6.38.8-32.fc15.i686.PAE ro root=UUID=3c179835-52a2-4d6a-b525-6c06771bdbaa rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet 3
```
gurb2的话在linux那一行添加即可

例如:

原
```Shell
 linux /boot/vmlinuz-3.1.0-7.fc16.i686.PAE root=UUID=3e0dd140-a3e8-47f5-b747-e7011e001711 ro rd.md=0 rd.lvm=0 rd.dm=0  KEYTABLE=us quiet rhgb LANG=zh_CN.UTF-8 rd.luks=0
```
修改后

 linux /boot/vmlinuz-3.1.0-7.fc16.i686.PAE root=UUID=3e0dd140-a3e8-47f5-b747-e7011e
```
