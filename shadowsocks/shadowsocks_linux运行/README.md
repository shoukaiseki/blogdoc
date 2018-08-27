# linux运行shadowsocks

## 安装

shadowsocks连接服务器采用的是加密算法,开的默认代理是socks5协议的，而yum，wget，curl都只支持http，更方便的使用就是配个socks5转http的软件(privoxy)。

### 安装shadowsocks 客户端

```Bash
sudo apt install shadowsocks
```

vim /etc/shadowsocks/client.conf  #把下面内容写进去，这个和shadowsocks的服务端对应。

```Json
{

"server":"x.x.x.x",

"server_port":1443,

"local_address":"127.0.0.1",

"local_port":1080,

"password":"xxxxxx",

"timeout":600,

"method":"aes-256-cfb"

}
```

 
#### 运行客户端代理

```Bash
nohup /usr/bin/python /usr/bin/sslocal -c /etc/shadowsocks/config.json >> /var/log/sslocal.log 2>&1 &   #启动shadowsocks client
```

或者

```Bash
sudo sslocal -c /etc/shadowsocks/client.conf 
```

#### 安装privoxy

```Bash
sudo apt install privoxy



sudo vim /etc/privoxy/conf
```
##### 添加下面内容

```
forward-socks5 /          127.0.0.1:1080 .
```

##### 启动privoxy

```Bash
systemctl start privoxy.service 
```

#### 设置代理


```Bash
vim ~/.bashrc 
```

##### 添加下面内容

```Bash
export http_proxy=http://127.0.0.1:8118/

export https_proxy=http://127.0.0.1:8118/

export ftp_proxy=http://127.0.0.1:8118/
```

##### 生效

```Bash
source ~/.bashrc 
```
