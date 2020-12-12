# git常用命令

## git强制覆盖：
```
git fetch --all
git reset --hard origin/master
git pull
```


## git开源项目提交更改请求合并
forck一个开源项目到自己的仓库,修改后提交到自己的仓库

点击 + Pull Request 进行填写信息申请合并



##  LF将被CRLF替换

禁用自动转换
```
git config --global core.autocrlf false
```

关闭警告
```
git config --global core.safecrlf false
```
