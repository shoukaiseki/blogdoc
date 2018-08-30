# 讓vim支持在終端剪貼板共享 

linux mint ubuntu 下按照以下执行

## 卸载 vim

```Shell
sudo apt-get remove --purge vim
```

## 安装相关软件包

```Shell
sudo apt-get install build-essential  
sudo apt-get install ncurses-dev  
sudo apt-get install xorg-dev  
sudo apt-get install libgtk2.0-dev  
```

## 安装vim

```Shell
sudo apt-get install vim vim-scripts vim-gtk vim-gnome  
sudo apt-get install exuberant-ctags cscope  
```

## ranger中通过vim编辑时全局剪贴板无效

### 原因
是使用 sensible-editor 运行的导致

#### 方案一
在ranger中输入命令指定使用vim打开
```
open_with vim
```

### 方案二(推荐)
参考 http://blog.sina.com.cn/s/blog_69e5d8400102wp2k.html

修改ranger配置

即将默认配置文件拷贝到了当前用户的 ~/.config/ranger 文件夹下
```Bash
ranger --copy-config=all

echo 修改配置文件
vim ~/.config/ranger/rifle.conf
```
在最前面填写下句
```Conf
ext php|xml|json|csv|tex|py|pl|rb|js|sh|txt = vim "$@"
```
