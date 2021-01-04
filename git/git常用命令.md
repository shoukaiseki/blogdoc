# git常用命令

## git强制覆盖：
```
git fetch --all
git reset --hard origin/master
git pull
```

### 添加全局忽略
```Bash
git config --global core.excludesfile ~/.gitignore
```

### 提交,更新时忽略文件
```Bash
git update-index --assume-unchanged src/main/resources/application-druid.yml
git update-index --assume-unchanged logs/
git config --global core.excludesfile .gitignore
```
#### 个人不需要提交的文件，在.git/info/exclude 自行配置

之后执行

```Bash
git ls-files --others --exclude-from=.git/info/exclude
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
