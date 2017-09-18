# GitTortoiseGit 操作记住密码

在GitBash中 输入 

```Bash
git config --global credential.helper store 
```

执行完后去查看 %HOME%\.gitconfig 这个文件，发现多了一项： 

```Conf
[credential] 
helper = store 
```

完成之后输入了密码就好保存了
