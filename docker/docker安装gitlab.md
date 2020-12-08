# docker安装gitlab

# windows server 2008

```shell
docker pull gitlab/gitlab-ce
```



## 创建容器
### 首先配置将本地磁盘共享给virtualbox
https://blog.csdn.net/weixin_43343144/article/details/89350580?utm_medium=distribute.pc_relevant_bbs_down.none-task--2~all~first_rank_v2~rank_v28-1.nonecase&depth_1-utm_source=distribute.pc_relevant_bbs_down.none-task--2~all~first_rank_v2~rank_v28-1.nonecase

共享文件夹路径：  E:\gitlab
共享文件夹名称:   e/gitlab
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/docker/docker/img/001.png)
设置之后重启docker
```
docker-machine restart default
```

#### virtualbox共享文件夹如果不生效
##### 安装vbox增强组建
设备-》安装增强功能

```bash
sudo mkdir /media
sudo mkdir /media/cdrom
sudo mount  /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
```

##### 分配光驱，把bootdocker2.iso 选回来，不然无法启动docker

再重启docker
```
docker-machine restart default
```
#### 进入docker终端
```
sudo mkdir /e
sudo mkdir /e/gitlab
mount -t vboxsf e/gitlab /e/gitlab
```
接下来再创建gitlab容器

#### windows server 2008以下方式没法指定存储路径
```
docker volume create gitlab-logs
docker volume create gitlab-config
docker volume create gitlab-data
```


### 根据image创建容器
```shell
docker run --privileged=true -d -p 9443:443 -p 9080:80 -p 9022:22 --name=gitlab --restart=always -v /e/gitlab/config:/etc/gitlab -v /e/gitlab/logs:/var/log/gitlab -v /e/gitlab/data:/var/opt/gitlab 9a53eb68aeeb
```


```
docker ps -a

D:\usr\DockerToolbox>docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                        PORTS                     NAMES
05d07e65a0ac        9a53eb68aeeb        "/assets/wrapper"   13 minutes ago      Up 13 minutes (unhealthy)     22/tcp, 80/tcp, 443/tcp   unruffled_ritchie
95d0f1e0413b        9a53eb68aeeb        "/assets/wrapper"   42 minutes ago      Exited (137) 25 minutes ago                             gitlab
```
可以根据 CONTAINER ID 进行操作

##### 停止
```
docker stop 05d07e65a0ac 
```

##### 删除
```
docker rm 05d07e65a0ac 
```

##### 启动
```
docker start 05d07e65a0ac 
```

##### 查看日志
```
docker logs 05d07e65a0ac 
```


### 进入容器shell
```
docker exec -it gitlab /bin/bash
```
## virtualbox 中的 default 至少要配2G内存才能运行gitlab

使用 docker-machine.exe env 查看的IP访问 gitlab
http://192.168.99.100:8080




访问如果出现502,不要着急，先在gitlab容器内执行 free -m 看看，多执行几次，如果空闲内存(free)一直在减少，那么有些进程还在启动，除非free值一点都没有了，那就是内存不够有些进程没法启动。
如果有空闲内存，那么多等候就能正常访问了。
