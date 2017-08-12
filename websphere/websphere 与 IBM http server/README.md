# websphere 与 IBM http server

IBM http server 可以理解为 跟 windows 自带的 http 服务一样,但是强大的是自带websphere插件,比如websphere有个maximo应用,

使用 127.0.0.1:9081/maximo 访问的,

IBM http server 服务是用 127.0.0.1:80 访问

而用IBM http server 访问 127.0.0.1:80/maximo 时访问的应该是 对应

而在 IBM http server中配置了 websphere 插件后 访问 127.0.0.1:80/maximo  相当于访问 127.0.0.1:9081/maximo 了

IBM http server配置文件为  D:\ibm\HTTPServer\conf\httpd.conf

在该文件中的 WebSpherePluginConfig "D:\IBM\HTTPServer/Plugins/config/webserver2/plugin-cfg.xml"  为websphere插件配置信息

websphere配置文件路径

D:\ibm\WebSphere\AppServer\profiles\ctgAppSrv01\config\cells\ctgCell01\nodes\ctgNode01\serverindex.xml
