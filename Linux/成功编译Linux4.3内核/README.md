# 成功编译Linux4.3内核  

Google-chrome 新版本不支持旧的内核,没办法,只能更新下内核了

我的系统:Fedora 18  内核 3.11.10-100.fc18.i686.PAE

```Shell
cd /tmp
[root@fedora tmp]#wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.3.tar.xz
[root@fedora tmp]#xz -d linux-4.3.tar.xz

[root@fedora tmp]#tar -xvf linux-4.3.tar -C /usr/src/kernels

[root@fedora tmp]#cd /usr/src/kernels/linux-4.3

[root@fedora linux-4.3]#make mrproper

[root@fedora linux-4.3]#cp /boot/config-3.11.10-100.fc18.i686.PAE -r ./.config

[root@fedora linux-4.3]#make menuconfig

#见下图

[root@fedora linux-4.3]#make -j8

[root@fedora linux-4.3]#make modules_install -j8 

[root@fedora linux-4.3]#make install
```



这样就完成了,OK了

重启之后选择新内核启动吧


使用左右箭头调到Load处按回车读取配置

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Linux/%E6%88%90%E5%8A%9F%E7%BC%96%E8%AF%91Linux4.3%E5%86%85%E6%A0%B8/img/001.png)

选择OK回车

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Linux/%E6%88%90%E5%8A%9F%E7%BC%96%E8%AF%91Linux4.3%E5%86%85%E6%A0%B8/img/002.png)

,然后自己需要调整内核功能自己选择,最后调到EXIT处回车,提示退出保存

 选择YES回车即可报错配置

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Linux/%E6%88%90%E5%8A%9F%E7%BC%96%E8%AF%91Linux4.3%E5%86%85%E6%A0%B8/img/003.png)
 


