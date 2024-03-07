# nginx转发maximo服务


## 测试后可以正常使用的配置
weblogic
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
	#自动显示目录
	#autoindex on;
	#人性化方式显示文件大小否则以byte显示
    #autoindex_exact_size off;
	#按服务器时间显示，否则以gmt时间显示
    #autoindex_localtime on;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;


    #gzip  on;
	#gzip  on;
    #gzip_min_length  1k;
    #gzip_buffers     4 16k;
    #gzip_http_version 1.0;
    #gzip_comp_level 2;
    #gzip_types       text/plain application/x-javascript text/css application/xml;
    #gzip_vary on;
	
	
    #keepalive_timeout  0;
    #keepalive_timeout  65;
    #keepalive_timeout  0;
	
	#client_max_body_size 8m;
	#client_body_buffer_size 128k;
	
	underscores_in_headers on;
	#server_tokens on;
	
	server {  
		listen 80;
		server_name  test6.shoukaiseki.top;

		location / {
			proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header REMOTE_HOST $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_set_header X-Forwarded-Proto $scheme;
			proxy_set_header X-NginX-Proxy true;
			proxy_read_timeout 700s;
			proxy_pass http://localhost:7001; 
		}
	}
	

}

```
