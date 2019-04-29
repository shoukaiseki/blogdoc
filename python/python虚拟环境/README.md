# pipenv

## 安装pip
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

## 更改国内源
```
mkdir ~/.pip
vim ~/.pip/pip.conf
```
### 内容如下
```
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```

## 安装虚拟环境管理器
```
sudo pip3 install pipenv
```

## 安装虚拟环境
```
pipenv install
```

## 激活虚拟环境
```
pipenv shell
```

## 安装依赖
```
pipenv install
```

## 查看依赖
```
pipenv graph
```


