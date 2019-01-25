# 定时任务

## 安装crontab服务
```
yum install crontabs
```

## 编辑任务
```
crontab -e
```

```
* * * * *  echo `date` >>/tmp/cron_crontest.txt
0 12,23 * * *  /disk1/servers/bin/jarbak.sh
```

### 查看任务列表
```
crontab -l
```

## 重载定时任务

```
systemctl restart crond
```
