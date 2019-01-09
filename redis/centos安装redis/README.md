# centos安装redis


```shell
systemctl start redis

sudo -u redis /usr/local/bin/redis-server /etc/redis/redis.conf
 ```

### 权限设置
如果启动服务出现权限错误,以下命令进行授权


```shell
chown -R redis.redis /etc/redis
chown -R redis.redis /var/log/redis
```



### 停止服务
 ```shell
 redis-cli shutdown
 ```
