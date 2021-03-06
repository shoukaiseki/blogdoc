# linux rm命令参数及用法详解---linux删除文件或目录命令  

```Shell
linux下rm命令使用详解---linux删除文件或目录命令

用户可以用rm命令删除不需要的文件。该命令的功能为删除一个目录中的一个或多个文件或目录，它也可以将某个目录及其下的所有文件及子目录均删除。对于链接文件，只是断开了链接，原文件保持不变。

 

rm命令的一般形式为：rm [选项]... 目录... 删除指定的<文件>(即解除链接)。

-d      --directory    删除可能仍有数据的目录 (只限超级用户)

-f      --force          略过不存在的文件，不显示任何信息

-i      --interactive 进行任何删除操作前必须先确认

-r/R --recursive    同时删除该目录下的所有目录层

-v      --verbose     详细显示进行的步骤

          --help            显示此帮助信息并离开

         --version      显示版本信息并离开

要删除第一个字符为&lsquo;-’的文件 (例如‘-foo’)，请使用以下其中一种方法：
rm -- -foo

rm ./-foo

请注意，如果使用 rm 来删除文件，通常仍可以将该文件恢复原状。如果想保证
该文件的内容无法还原，请考虑使用 shred。

范例：

删除所有rb语言程序档；删除前逐一询问确认 :
rm -i *.rb

将 Finished 子目录及子目录中所有档案删除 :
rm -r Finished

将 Finished 子目录及子目录中所有档案删除,并且不用--确认 :

rm -rf Finished
```
