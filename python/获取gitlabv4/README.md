# 获取gitlabv4


## python 3.6

## 安装依赖包
```shell
 pip install urllib3
```


```python
#!/usr/bin/python3.6
import time
import urllib3
import requests
import json
import os

tarGzTemp="/tmp/win"
pathTemp="/media/worktemplinux/gitlab_bak"

#  忽略警告：InsecureRequestWarning: Unverified HTTPS request is being made. Adding certificate verification is strongly advised.
requests.packages.urllib3.disable_warnings()
# 一个PoolManager实例来生成请求, 由该实例对象处理与线程池的连接以及线程安全的所有细节
http = urllib3.PoolManager()
# 通过request()方法创建一个请求：

headers = {
'PRIVATE-TOKEN': 'W9QfD9YL-UrFGRu5vnqN'
}



r = http.request('GET', 'http://192.168.0.199/api/v4/projects?per_page=500',headers=headers)
print(r.status) # 200

# 获得html源码,utf-8解码
json_response = (r.data.decode())

print(json_response)
#
dict_json = json.loads(json_response)
#
print(dict_json)

for value in dict_json:
    print(value)
    savePath=pathTemp+"/"+value['path_with_namespace']
    exists = os.path.exists(savePath)
    print("%s=%s" %(exists,savePath))
    if not exists:
        os.makedirs(savePath)


    if os.path.exists(savePath+"/.git"):
        execStr=("git -C %s pull %s" %(savePath,value['http_url_to_repo']))
        print (execStr)
        os.system(execStr)
    else:
        execStr="git clone %s %s" %(value['http_url_to_repo'],savePath)
        print (execStr)
        os.system(execStr)
execStr="tar -zcvf %s/%s.tar.gz --exclude=*.svn --exclude=*.git --exclude=*.repo %s" %(tarGzTemp,time.strftime("%Yy%mm%dd%H%M%S", time.localtime()),pathTemp)
print (execStr)
os.system(execStr)
```
