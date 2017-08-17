# Fedora15、16进入图形界面和进入字符界面 

转自http://blog.sina.com.cn/s/blog_48f9c0840100sswn.html

1.在Fedora15、16中将图形界面改为字符界面
```
[root@15 system]# mv /etc/systemd/system/default.target /
[root@15 system]# ln -s /lib/systemd/system/runlevel3.target /etc/systemd/system/default.target
[root@15 system]# reboot
```
2.在Fedora15、16中将字符界面改为图像界面
```
[root@15 system]# mv /etc/systemd/system/default.target /
[root@15 system]# ln -s /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
[root@15 system]# reboot
```

默认 /etc/systemd/system/default.target

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Fedora/Fedora15%E3%80%8116%E8%BF%9B%E5%85%A5%E5%9B%BE%E5%BD%A2%E7%95%8C%E9%9D%A2%E5%92%8C%E8%BF%9B%E5%85%A5%E5%AD%97%E7%AC%A6%E7%95%8C%E9%9D%A2/img/001.jpg)

  /lib/systemd/system/runlevel3.target与/lib/systemd/system/runlevel5.target
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Fedora/Fedora15%E3%80%8116%E8%BF%9B%E5%85%A5%E5%9B%BE%E5%BD%A2%E7%95%8C%E9%9D%A2%E5%92%8C%E8%BF%9B%E5%85%A5%E5%AD%97%E7%AC%A6%E7%95%8C%E9%9D%A2/img/002.jpg)
 
下面是/etc/systemd/system/default.target的内容
```Target
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.

# See systemd.special(7) for details

[Unit]
Description=Graphical Interface
Requires=multi-user.target
After=multi-user.target
Conflicts=rescue.target
AllowIsolate=yes

[Install]
Alias=default.target
```

下面是/lib/systemd/system/runlevel5.target的内容
```Target
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.

# See systemd.special(7) for details

[Unit]
Description=Graphical Interface
Requires=multi-user.target
After=multi-user.target
Conflicts=rescue.target
AllowIsolate=yes
```
下面是/lib/systemd/system/runlevel3.target的内容
```Target
[Install]
Alias=default.target

#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.

# See systemd.special(7) for details

[Unit]
Description=Multi-User
Requires=basic.target
Conflicts=rescue.service rescue.target
After=basic.target rescue.service rescue.target
AllowIsolate=yes

[Install]
Alias=default.target
```

