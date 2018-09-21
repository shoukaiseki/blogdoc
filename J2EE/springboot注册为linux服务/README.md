# springboot注册为linux服务

sh -x $WORKSPACE/jenkins.sh


/etc/init.d


## linux mint

使用 systemctl 管理服务

官网文档 https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-services


```bash
sudo vim /lib/systemd/system/test.service
```


```properties

[Unit]
Description=test 

[Service]
WorkingDirectory=/usr/local/test
PrivateTmp=true
Restart=always
Type=simple
ExecStart= /usr/bin/java -Dlogging.path=/usr/local/test/logs/  -jar /usr/local/test/springboot-centos-server.jar 
ExecStop=/usr/bin/kill -15  $MAINPID

[Install]
WantedBy=multi-user.target

```

复制jar到服务配置目录

```bash
sudo cp target/springboot-centos-server.jar /usr/local/test/springboot-centos-server.jar
```

###  systemctl 管理，让配置生效。若是修改配置文件，需要reload

```bash
sudo systemctl daemon-reload

sudo systemctl enable test.service

systemctl start test
```


#### 查看日志

```bash
sudo journalctl -f -u test.service
```

查看该时间段之后的所有日志

```bash
sudo journalctl --since "2018-09-21 17:15:00" -u test.service
```

清空日志

```bash
sudo sh -c 'cat  /dev/null > logs/spring.log '
```


## 服务配置说明


[Unit] 
Description : 服务的简单描述 
Documentation ： 服务文档 
After= : 依赖，仅当依赖的服务启动之后再启动自定义的服务单元

[Service] 
Type : 启动类型simple、forking、oneshot、notify、dbus

Type=simple（默认值）：systemd认为该服务将立即启动。服务进程不会fork。如果该服务要启动其他服务，不要使用此类型启动，除非该服务是socket激活型。 
Type=forking：systemd认为当该服务进程fork，且父进程退出后服务启动成功。对于常规的守护进程（daemon），除非你确定此启动方式无法满足需求，使用此类型启动即可。使用此启动类型应同时指定 PIDFile=，以便systemd能够跟踪服务的主进程。 
Type=oneshot：这一选项适用于只执行一项任务、随后立即退出的服务。可能需要同时设置 RemainAfterExit=yes 使得 systemd 在服务进程退出之后仍然认为服务处于激活状态。 
Type=notify：与 Type=simple 相同，但约定服务会在就绪后向 systemd 发送一个信号。这一通知的实现由 libsystemd-daemon.so 提供。 Type=dbus：若以此方式启动，当指定的 BusName 出现在DBus系统总线上时，systemd认为服务就绪。

PIDFile ： pid文件路径 
ExecStartPre ：启动前要做什么，上文中是测试配置文件 －t 
ExecStart：启动 
ExecReload：重载 
ExecStop：停止 
PrivateTmp：True表示给服务分配独立的临时空间

[Install] 
WantedBy：服务安装的用户模式，从字面上看，就是想要使用这个服务的有是谁？上文中使用的是：multi-user.target ，就是指想要使用这个服务的目录是多用户。「以上全是个人理解，瞎猜的，如有不当，请大家多多指教」每一个.target实际上是链接到我们单位文件的集合,当我们执行：

$sudo systemctl enable nginx.service

就会在/etc/systemd/system/multi-user.target.wants/目录下新建一个/usr/lib/systemd/system/nginx.service 文件的链接。

