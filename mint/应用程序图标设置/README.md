# 应用程序图标设置

自定义命令，或者解压直接运行的应用程序绑定图标

例如 IntelliJ IDEA 设置图标

```Bash
sudo vim /usr/share/applications/idea.desktop
```

输入内容

```Desktop
[Desktop Entry]
Encoding=UTF-8
Name=IntelliJ IDEA 
Exec=idea
Icon=/media/linuxdata/data/opt/idea-IU-182.4129.33/bin/idea.png
Terminal=false
Type=Application
Categories=Development;
```

