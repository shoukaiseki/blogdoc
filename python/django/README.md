# Django

### python 3.6


## 安装mysqlclient
```sh
sudo apt-get install libmysqlclient-dev
sudo pip3 install mysqlclient==1.4.2.post1
```







```sh
django-admin startproject ManageAdmin
```

### 启动服务
```sh
python3 manage.py runserver 0.0.0.0:8000
```



### 数据库
#### 创建模型
```
django-admin startapp UserManage
```


#### 创建表结构
```
python3 manage.py migrate
python3 manage.py makemigrations
python3 manage.py migrate
```



#### 创建管理员密码
```
python3 manage.py createsuperuser
```
