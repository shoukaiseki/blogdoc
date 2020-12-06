#  docker配置国内源

## DockerToolbox
windowns server 2008
```
docker-machine ssh
```

然后在docker终端执行
```shell
sudo sed -i "s|EXTRA_ARGS='|EXTRA_ARGS='--registry-mirror=http://hub-mirror.c.163.com |g" /var/lib/boot2docker/profile
```
##### 设置完查看是否修改成功
```
cat /var/lib/boot2docker/profile
```
##### 成功后重启docker
```
 docker-machine restart default
```
