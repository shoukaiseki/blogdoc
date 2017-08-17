# fedora 17 新內核無法正常啓動  

http://www.shoukaiseki.webuda.com/   免費空間建立的網站,有些字數限制無法發佈的博文可以在這裏查看,因爲國外空間,需要翻牆

昨晚系統自動升級,因爲太晚了,沒有更新完就關機了.結果今天上午開機新內核進不了系統,要工作,還是現放着晚上整吧. 

回到宿舍,先字符界面進吧,也進不去,那就debug模式看下信息吧.
```
May
 23 08:13:56 fedora kernel: [    0.022464] WARNING: at arch/x86/kernel/apic/apic.c:1238 setup_local_APIC+0xee/0x317() May
 23 08:13:56 fedora kernel: [    0.022466] Hardware name: N43SL May
 23 08:13:56 fedora kernel: [    0.022468] Modules linked in: May
 23 08:13:56 fedora kernel: [    0.022470] Pid: 1, comm: swapper Not tainted 3.4.2-4.fc17.i686.PAE #1 May
 23 08:13:56 fedora kernel: [    0.022472] Call Trace: May
 23 08:13:56 fedora kernel: [    0.022476]  [] ? printk+0x2d/0x2f May
 23 08:13:56 fedora kernel: [    0.022480]  [] warn_slowpath_common+0x7c/0x91 May
 23 08:13:56 fedora kernel: [    0.022483]  [] ? setup_local_APIC+0xee/0x317 May
 23 08:13:56 fedora kernel: [    0.022485]  [] ? setup_local_APIC+0xee/0x317 May
 23 08:13:56 fedora kernel: [    0.022488]  [] warn_slowpath_null+0x22/0x24 May
 23 08:13:56 fedora kernel: [    0.022491]  [] setup_local_APIC+0xee/0x317 May
 23 08:13:56 fedora kernel: [    0.022493]  [] ? printk+0x2d/0x2f May
 23 08:13:56 fedora kernel: [    0.022497]  [] ? bigsmp_setup_apic_routing+0x20/0x22 May
 23 08:13:56 fedora kernel: [    0.022502]  [] native_smp_prepare_cpus+0x21a/0x2bc May
 23 08:13:56 fedora kernel: [    0.022505]  [] kernel_init+0x5d/0x13b May
 23 08:13:56 fedora kernel: [    0.022508]  [] ? start_kernel+0x353/0x353 May
 23 08:13:56 fedora kernel: [    0.022511]  [] kernel_thread_helper+0x6/0x10 
```


這個錯誤沒見過,因爲還是菜菜,得上網查查. 

沒有找到相應答案,只能自己整了,先grub2-mkconfig下吧 

既然是內核包有問題,重啓修改grub2的,不對啊,咋的沒有下列語句
```
initrd /boot/initramfs-3.4.2-4.fc17.i686.PAE.img 
```


手動在grub2中編輯就是沒有對應加載img核鏡像,原來如此. 

原來是更新沒完成導致的
```Shell
#列出要卸載的rpm包 
rpm -qa|grep kernel|grep 3.4.2-4 > /tmp/log/111.sh 
#編輯要卸載的文件成shell腳本 
vim /tmp/log/111.sh 
#編輯結果如下 
yum remove  kernel-debug-3.4.2-4.fc17.i686 kernel-PAEdebug-devel-3.4.2-4.fc17.i686 kernel-PAE-3.4.2-4.fc17.i686 kernel-devel-3.4.2-4.fc17.i686 kernel-tools-devel-3.4.2-4.fc17.i686 kernel-debug-devel-3.4.2-4.fc17.i686 kernel-headers-3.4.2-4.fc17.i686 kernel-PAE-devel-3.4.2-4.fc17.i686 kernel-doc-3.4.2-4.fc17.noarch kernel-PAEdebug-3.4.2-4.fc17.i686 kernel-tools-3.4.2-4.fc17.i686
#因爲包名跟yum倉庫一致,還是採用yum remote好,因爲會解決依賴問題 
#移除後重新安裝更新內核下 
yum update 
```

重啓後OK了
