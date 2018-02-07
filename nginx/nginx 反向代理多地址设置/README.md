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

根据域名前缀解析到本地81端口

http://sksweb.shoukaiseki.top httpd 服务 81端口

http://www.shoukaiseki.top/answerrecorder/ tomcat服务 8080端口

http://www.shoukaiseki.top/maximodecryption/ tomcat服务 8080端口

```

    server {
        listen       80;
        #server_name  localhost;
		
		# http://sksweb.shoukaiseki.top 解析到 81端口
		#参考地址 http://blog.csdn.net/Metropolis_cn/article/details/73613022?locationNum=7&fps=1
		server_name  *.shoukaiseki.top;
		#正则表达式  
		if ($http_host ~* "^(.*?)\.shoukaiseki\.top$") {
			#设置变量 
			set $domain $1; 
        }  
		
        #charset koi8-r;

        #access_log  logs/host.access.log  main;
        location / {
			if ($domain ~* "sksweb") {  
				#域名中有sksweb，转发到3001端口 
				proxy_pass http://localhost:81; 
            }  
            root   html;
            index  index.html index.htm;
        }


	location /answerrecorder {
			proxy_pass http://localhost:8080/answerrecorder;
            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			
        }  


        location /maximodecryption {
			proxy_pass http://localhost:8080/maximodecryption;
            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			
        }  

		

    }
```
