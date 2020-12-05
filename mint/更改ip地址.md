# 更改IP地址



## 更改IP地址
```
ifconfig enp5s0 192.168.0.6 netmask 255.255.255.0
```

## 更改网关

查看路由信息
```
ip route show
```
不在路由中的ip设置该地址为网关会报错
```
sudo ip route add default via 192.168.0.1 dev enp5s0
```
