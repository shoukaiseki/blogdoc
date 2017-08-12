# nginx 反向代理多地址设置

```
 server {
        listen       9080;
        server_name  localhost;
        charset utf-8;

        #access_log  logs/host.access.log  main;

        location /dunanjfinal {
			proxy_pass http://172.16.115.218:8080/dunanjfinal;
            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			
        }  

        location /doclinks {
	    proxy_pass http://172.16.115.218:80/;
            proxy_set_header Host $host:$server_port;
            proxy_set_header   X-Real-IP   $remote_addr;   
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;  
        }
		
		
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }



    }
```

