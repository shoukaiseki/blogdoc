# LinuxMint/Ubuntu 关机重启等待 90 秒问题的解决办法

## 方法1
### 1.安装 watchdog
sudo apt install watchdog

### 2.开启 watchdog 服务
sudo systemctl enable watchdog.service

### 3.马上启用 watchdog 服务
sudo systemctl start watchdog.service


## 方法2
### 编辑/etc/systemd/system.conf
增加两行配置
```
DefaultTimeoutStartSec=10s
DefaultTimeoutStopSec=10s
```

之后执行
```
systemctl daemon-reload
```
