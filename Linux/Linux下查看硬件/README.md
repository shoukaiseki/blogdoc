# Linux下查看硬件 

```Shell
lspci|grep -i vga  查看检测到的显卡
dmesg|tail -2  用tail输出启动信息(dmesg查看)中的最后两行
```
