# nginx不同路径不同页面

```
  server {
        listen       801;
        server_name  0.0.0.0;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }
		
		
	    #静态html
	   location /h5 {
		 alias E:/temp/sks/jyy001/jthtml/;#最右边需要有个'/'
		#alias /www/wwwroot/jyy001web/jthtml/;
	   }


        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

     
		
    }
```


http://localhost:801/h5/

