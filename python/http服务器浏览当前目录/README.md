# http服务器浏览当前目录

``
python3 -m http.server
```
就会在当前目录创建一个http服务，访问127.0.0.1:8000 （默认端口为8000）


```
python3 -m http.server 9000 –directory /home

python3 -m http.server 9000 --bind 192.168.0.200
```


创建端口为9000，制定目录/home

(
windows下，python3改为python 即可，python -m http.server
)
