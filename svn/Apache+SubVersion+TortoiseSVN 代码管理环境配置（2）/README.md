# Apache+SubVersion+TortoiseSVN 代码管理环境配置（2）  

转自 http://hi.baidu.com/mrprogrammer/blog/item/abe04c1666ab7b01c83d6d60.html#0

4．添加删除文件等操作

 

客户端删除库中文件的操作是：

点击右键-> TortoiseSVN子菜单->Repo-Browser，

 

 

通过图中的右键菜单，可以对服务器上SVN库中的文件进行日志检查(Show Log), 导出(Checkout)，创建文件夹（Create Folder），添加文件(Add File)， 添加文件夹(Add Folder)，删除文件(Delete)等等操作。

使用Repo-Browser菜单具有很强大的功能，它是直接在对服务器上的库进行操作。

5．冲突处理

 

对于库中的同一文件，如果有两个人都对其中的同一部分进行了修改，那么后提交的人就会在提交时获得该文件要求更新的警告，在更新以后，TortoiseSVN会提示当前工作的版本与服务器中的文件相冲突。这时文件的图标是一个感叹号。这时在该文件上点击右键，进入TortoiseSVN子菜单->Edit Conflicts(已解决的),会弹出如图的编辑框TortoiseMerge：如图

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/snv/Apache+SubVersion+TortoiseSVN%20%E4%BB%A3%E7%A0%81%E7%AE%A1%E7%90%86%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE%EF%BC%882%EF%BC%89/img/001.bmp)
  

左上部是显示的服务器的文件，右上部是显示的本地文件，在下边是你处理合并后的文件，在TortoiseMerge中做的修改会反应到本地文件中，然后就可以提交。当然，你可以选择别的编辑工具编辑本地文件，以使其与服务器上的文件避开冲突。

6．锁定文件

 

为了防止冲突，TortoiseSVN提供了对文件的锁定功能。顾名思义，锁定文件以后，只能允许持有锁的用户才能对文件进行提交，其他用户在提交时会被提示文件被其他用户锁定，无法完成提交。使用锁定功能的方法是，在欲锁定的文件上点击右键，进入TortoiseSVN子菜单->Get Lock…，

 

 

在上部的输入框中输入你锁定文件的原因，在下边选择欲锁定的文件，然后点击OK即可。

当然，如果持有锁的人有事出差你不好问他的用户和密码，又必须修改他锁定的文件，TortoiseSVN在上图中提供了Steal the locks。选择该复选框后，你即可以变成该文件的锁持有者，当然，你要准备好对原来的锁持有者回来后进行解释的充足理由。

7．恢复版本

 

有时由于提交了错误的修改，如果不想重新提交而是恢复到原来的版本时，可以在欲恢复为原来版本的文件上点击右键，使用TortoiseSVN子菜单->Update to Revision…功能，

 

 

在文本输入框中输入你想恢复的版本号即可。

8．其他

 

TortoiseSVN提供了完善的日志记录，即经常可以见到的按钮Show Log，可以随时查看、关注某文件的修改记录。如果你还有精确到某文件的每一行被什么人、什么时间修改过，可以在该文件点击右键，进入TortoiseSVN子菜单->Blame…。TortoiseSVN会用最详尽的方式为你提供参考。

TortoiseSVN子菜单->Settings对话框保含了对TortoiseSVN的常用配置，包括图标风格和配置服务器代理等等。
