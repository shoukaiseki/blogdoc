# 指定boot2docker镜像

### 指定镜像创建
```
docker-machine.exe create --driver virtualbox --virtualbox-boot2docker-url=boot2docker.iso default
```

### 删除虚拟机
```
docker-machine.exe rm default
```

### 运行虚拟机
```
docker-machine.exe env default
```

