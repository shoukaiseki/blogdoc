# Ubuntu Kylin 14.04 下安装RabbitVCS  

安装RabbitVCS的方法步骤如下：

1、sudo add-apt-repository ppa:rabbitvcs/ppa  

    #将rabbitvcs的添加到源里面。（次操作会提示是否要添加到源里面，点击ENTER添加，ctrl + c不添加）

2、sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 34EF4A35  

  #导入key  如果第一步自动导入了key的话这步可以不做

3、sudo apt-get update  #执行下更新

4、sudo apt-get install rabbitvcs-cli  rabbitvcs-core rabbitvcs-gedit rabbitvcs-nautilus3 rabbitvcs-thunar thunarx-python

  #安装 如果报错：“破坏依赖关系之类的” 可以使用 新立得 进行安装。一个一个的安装,

先安装rabbitvcs-core，再依次安装rabbitvcs-cli，

rabbitvcs-gedit, rabbitvcs-thunar, thunarx-python, rabbitvcs-nautilus3

如果安装  rabbitvcs-nautilus3 报错这 安装  rabbitvcs-nautilus 即可

5、安装成功之后，需要注销，然后重新登录 找到一个文件目录，看看是不是和windows一样有了带有icon的目录。



原文 http://yjck.iteye.com/blog/1344635


