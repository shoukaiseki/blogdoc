#

## 登录
```
npm login
username: xxx,
password: 你的登录密码
Email: 你的邮箱
```
### 如果登录出错
如果原先默认源设置的taobao,则会出错,使用以下方式切换源
```
// 全局安装
npm install -g nrm
// 查看当前源
npm config get registry
// 切换淘宝源
nrm use taobao

// 切换npm源
nrm use npm

```

## 发布包

```
npm publish
```

运行时指定端口
```
npm run dev --port=9099
```


## 新建vue项目
### 安装vue-cli
 @vue/cli@5.0.6 

```
sudo npm install -g @vue/cli@4.4.6
```

### 创建项目
```
vue create helloWorld
```

