# nginx多个react服务根据域名前缀访问不同服务


```
user root;
worker_processes auto;
pid /run/nginx1.pid;

events {
    worker_connections  1024;
}
http{
	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	server {
		listen 9001;
		server_name bms.hongkedou.com;
		#server_name  *.hongkedou.com;

		index index.html index.htm;
		root /disk1/jenkins/data/workspace/html/dist;

		location / {
			try_files $uri $uri /index.html;
		}


#		location ^~ /assets/ {
#			gzip_static on;
#			expires max;
#			add_header Cache-Control public;
#		}
		error_page 500 502 503 504 /500.html;
		client_max_body_size 20M;
		keepalive_timeout 10;
	}

	server {
		listen 9001;
		server_name sms.hongkedou.com;
		#server_name  *.hongkedou.com;

		index index.html index.htm;
		root /disk1/jenkins/data/workspace/html/shangjia;

		location / {
			try_files $uri $uri /index.html;
		}


#		location ^~ /assets/ {
#			gzip_static on;
#			expires max;
#			add_header Cache-Control public;
#		}
		error_page 500 502 503 504 /500.html;
		client_max_body_size 20M;
		keepalive_timeout 10;
	}
}
```
