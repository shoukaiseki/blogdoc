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
