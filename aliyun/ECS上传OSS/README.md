#  ECS上传OSS


```
pip install oss2
```


```
#!/bin/python
# -*- coding: utf-8 -*-
import oss2
import time
auth = oss2.Auth('<yourAccessKeyId>', '<yourAccessKeySecret>')
# 如上描述
#bucket = oss2.Bucket(auth, 'http://oss-cn-hangzhou.aliyuncs.com', '<yourBucketName>')
bucket = oss2.Bucket(auth, 'oss-cn-hangzhou-internal.aliyuncs.com', '<yourBucketName>')

timeStr=time.strftime("%Y-%m-%d_%H_%M_%S", time.localtime())
name='/test/aaa_'+timeStr+'.jar'

# <yourLocalFile>由本地文件路径加文件名包括后缀组成，例如/users/local/myfile.txt
# yourObjectName是上传后的保存地址
bucket.put_object_from_file('<yourObjectName>', '<yourLocalFile>')
```
