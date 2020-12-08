# dockertoolbox安装gitlab
windows server 2008 R2

## 安装docker初始默认镜像
```
docker-machine.exe create --engine-registry-mirror=https://266nd9tm.mirror.aliyuncs.com --driver virtualbox default
```
其中的镜像地址 --engine-registry-mirror=https://266nd9tm.mirror.aliyuncs.com 使用自己阿里云帐号的镜像加速器地址

查看虚拟机的配置
```
docker-machine.exe env default
```
把这几句在命令行执行一次
```
SET DOCKER_TLS_VERIFY=1
SET DOCKER_HOST=tcp://192.168.99.105:2376
SET DOCKER_CERT_PATH=C:\Users\Administrator\.docker\machine\machines\default
SET DOCKER_MACHINE_NAME=default
SET COMPOSE_CONVERT_WINDOWS_PATHS=true
```
系统的环境变量 DOCKER_HOST 也要改下，不然下次docker就无法运行


## 将本地gitlab数据保存路径挂在到docker主镜像中(正确的方式)
https://cloud.tencent.com/developer/ask/41906
打开virtualbox，default虚拟机是docker的主镜像服务

选择default，点击 显示 , 控制 -> 设置 -> 共享文件夹 新增

共享文件夹路径：  E:\gitlab
共享文件夹名称:   e/gitlab
自动挂载和自动分配勾选上
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/docker/docker/img/001.png)

重启docker
```
docker-machine restart default
```
进入docker终端
```
docker-machine ssh default
cd /e/gitlab
ls
```
## 错误的方式
### 接着安装vbox增强工具
设备 -> 安装增强功能

在docker终端执行
```
sudo mkdir /media
sudo mkdir /media/cdrom
sudo mount  /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
sudo mkdir /e
sudo mkdir /e/gitlab
mount -t vboxsf e/gitlab /e/gitlab
```
然后在win中的E:\gitlab文件夹中新建一个文件，在docker中使用
```
ls /e/gitlab
```
看下文件是不是存在，如果存在证明共享成功

设备 -> 分配光驱 选择 boot2docker.iso 不选docker虚拟机启动不了

重启docker
```
docker-machine restart default
```
结果是重启之后之前做的操作全没了

最后只能执行删除
```
docker-machine rm default
```
重新安装初始镜像,采用正确的方式


## 安装gitlab
```shell
docker pull gitlab/gitlab-ce
```
查看镜像id(IMAGE ID)
```
docker images -a

REPOSITORY          TAG                 IMAGE ID            CREATED
SIZE
gitlab/gitlab-ce    latest              05a6354fcece        20 hours ago
2.07GB
```
最后一个根据镜像id替换
```
docker run --privileged=true -d -p 9443:443 -p 9080:80 -p 9880:8080 -p 9022:22 --name=gitlab -v /e/gitlab/config:/etc/gitlab -v /e/gitlab/logs:/var/log/gitlab -v /e/gitlab/data:/var/opt/gitlab 05a6354fcece
```
查看创建的容器
```
D:\usr\DockerToolbox>docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED STATUS                            					PORTS 																				NAMES
9efc4493b81a        05a6354fcece        "/assets/wrapper"   10 seconds ago Up 9 seconds (health: starting)   0.0.0.0:9022->22/tcp, 0.0.0.0:9080->80/tcp, 0.  0.0.0:9443->443/tcp, 0.0.0.0:9880->8080/tcp   gitlab
```

可以根据 CONTAINER ID 进行操作,也可以根据 name操作

##### 停止
```
docker stop 9efc4493b81a 
docker stop  gitlab
```

##### 删除
```
docker rm 9efc4493b81a 
```

##### 启动
```
docker start 9efc4493b81a 
docker start  gitlab
```

##### 查看日志
```
docker logs 9efc4493b81a 
```


### 进入容器shell
```
docker exec -it gitlab /bin/bash
```

##### 终端补全不要用就用桌面的  Docker Quickstart Terminal 进入

如果启动了 gitlab 之后用
```
docker ps -a
```
查看又停止了，那么就先停止docker
```
docker-machine stop default
```
在virtual box中增加虚拟机的内存到 3072MB

再启动
```
docker-machine start default
```

使用 docker-machine.exe env 查看的IP访问 gitlab

http://192.168.99.100:8080


