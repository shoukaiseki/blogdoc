# nginx根据二级域名代理到不同服务


```
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        #server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

		# http://sksweb.shoukaiseki.cn 解析到 81端口
		#参考地址 http://blog.csdn.net/Metropolis_cn/article/details/73613022?locationNum=7&fps=1
		server_name  *.shoukaiseki.cn;
		#正则表达式  
		if ($http_host ~* "^(.*?)\.shoukaiseki\.cn$") {
			#设置变量 
			set $domain $1; 
        }  
		
        #charset koi8-r;

        access_log  logs/host.access.log  main;
        location / {
			set $is_matched 0;
				proxy_set_header   X-Real-IP $remote_addr;
				proxy_set_header   Host      $http_host;
			if ($domain ~* "sksweb") {  
				#域名中有sksweb，转发到3001端口 
				proxy_pass http://localhost:81; 
				set $is_matched 1;
            }  
			# http://api.shoukaiseki.cn 解析到 8182端口
			if ($domain ~* "api") {  
				#域名中有api，转发到3001端口 
				proxy_pass http://localhost:8182; 
				set $is_matched 1;
			}  
			# 没有匹配到，跳转到默认页面
			if ($is_matched = 0) {
				root   html;
				#index  index.html index.htm;.
			}
			#default_type    application/json;
			#return 502 '{"status":502,"msg":"服务正在升级，请稍后再试…… http_host=$http_host domain=$domain is_matched=$is_matched"}';
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

    }

}
```
