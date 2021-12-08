## nginx

```
server {
	listen       443 ssl;
	server_name  wb001.shoukaiseki.cn;

	ssl_certificate      /data/server/https/wb001.shoukiseki.cn/5140487_wb001.shoukaiseki.cn.pem;
	ssl_certificate_key  /data/server/https/wb001.shoukiseki.cn/5140487_wb001.shoukaiseki.cn.key;

	ssl_session_cache    shared:SSL:1m;
	ssl_session_timeout  5m;

	ssl_ciphers  HIGH:!aNULL:!MD5;
	ssl_prefer_server_ciphers  on;

	location /wb001-api/ {
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header REMOTE-HOST $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		#代理转发时去除 /wb001-api
		rewrite ^/wb001-api/(.*) /$1 break; 
		proxy_pass   http://127.0.0.1:10001;
		proxy_read_timeout  3600;
	}

	location /wb520-api/ {
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header REMOTE-HOST $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

		#代理转发时去除 /wb520-api
		rewrite ^/wb520-api/(.*) /$1 break; 
		proxy_pass http://localhost:10520/;
		proxy_read_timeout  3600;
	}
}
```
