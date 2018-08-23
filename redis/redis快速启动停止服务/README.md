# \redis快速启动停止服务

shell配合expect实现自动输入密码启动redis服务

/bin/redis-start

```Shell
#!/usr/bin/expect
spawn echo "redis start now"
set timeout 100
set password "sudo之后的密码"
spawn sudo redis-server /etc/redis/redis.conf
send "$password\n"
interact
spawn echo "redis start success"
```


/bin/redis-stop

```Shell
#!/usr/bin/expect

spawn echo "redis stop now"
set timeout 100
set password "sudo之后的密码"
spawn sudo killall -9 redis-server
send "$password\n"

spawn sudo killall -9 redis-start
send "$password\n"
interact
spawn echo "redis stop success"

```

