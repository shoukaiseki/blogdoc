# WPS缺失字体
https://blog.csdn.net/weixin_34366546/article/details/94281728

## 下载缺失字体
```
链接: https://pan.baidu.com/s/1FGwQ-1n6iCLuIGJ_z84WRw  
密码: 9lp0
--来自百度网盘超级会员V8的分享
```

##  安装字体
```shell
tar zxvf  wps_symbol_fonts.tar.gz
sudo mv  wps_symbol_fonts  /usr/share/fonts
```

##  修改字体权限，终端执行以下命令

```sh
cd /usr/share/fonts/
chmod 755 wps_symbol_fonts
cd /usr/share/fonts/wps_symbol_fonts
chmod 644 *
```

## 生成字体索引,终端执行以下命令

```sh
cd /usr/share/fonts/wps_symbol_fonts
sudo mkfontscale
sudo mkfontdir
```
## 更新字体缓存,终端执行以下命令

```sh
sudo fc-cache
```
## 重启WPS
问题解决
