# Java调用dll之64bit篇 

http://blog.sciencenet.cn/blog-427394-467382.html

在64bit系统下调用32bit必须使用x86的JDK，这是由于64bit/32bit dll不能混合调用，而x64JDK默认调用64bit dll所致，具体原因如下：
<br>

<br>
（转）64位应用程序的第一条规则是:你绝对不能把32位和64位代码混和在同一个应用程序内。如果你有一个64位应用程序，所有与这个应用程序相关的东西，包括DLL文件，必须是64位的。这就有一个有趣的挑战，因为有时候很多应用程序都依靠一个共同的DLL文件。幸运的是，Windows保持32位的DLL文件和64位的DLL文件处于隔离状态。 
<br>

<br>
　　如果你查看一下在32位操作系统内的\Windows文件夹，你会发现两个子目录:一个名为SYSTEM，还有一个名为SYSTEM32。SYSTEM目录是Windows 3.x遗留下来的，用来保持Windows的对一些旧的应用程序的向下兼容性。一般说来，16位的DLL文件(以及其它的支持文件)被存放在\Windows\System文件夹里，32位DLL文件和不同支持文件被存放在\Windows\System32文件夹里。 
<br>

<br>
　　32位版本的Windows保持16位和32位DLL文件的方式是非常简单的，但是64位版本的Windows保持64位和32位DLL文件的方式就不这么简单了。 
<br>

<br>
理论上说，微软将要创建一个名为\Windows\System64的文件夹来用其存放64位DLL文件，但是取而代之的是，微软创建了一个新的名为SysWOW64的文件夹来存放32位的DLL文件。第一眼看起来，让人感觉这个文件夹应该存放64位应用程序的，但是注意，32位应用程序本来应该存放它们的DLL文件到\Windows\System32文件夹里面。 
<br>

<br>
　　\Windows\System32文件夹在64位版本的Windows内仍然存在。但是微软使用这个文件夹做为64位DLL的仓库，而不是32位DLL文件的。我不清楚微软使用\Windows\System32文件夹来存放64位DLL的原因，但是我听说这么做是为了向下兼容性。 
<br>

<br>
　　那么是不是所有32位应用程序该存放它们的DLL文件到\Windows\System32文件夹呢?这又让事情变得混乱。 
<br>

<br>
　　如我之前所提及的，32位代码不能默认在64位版本的Windows内运行。为了运行32位的应用程序，Windows使用WOW64 emulator，来让这些应用程序还认为它们在32位版本的Windows内运行。 
<br>

<br>
　　当你安装一个32位的应用程序，安装向导通过WOW64 emulato运行。32位和64位代码并不混和。一旦一个应用程序(包括一个安装向导)从WOW64 emulator开始运行，它必须接着在WOW64内继续运行。这意味着当你安装一个应用程序，安装向导并不知道这个程序被安装到64位版本的Windows内，并且和它运行在32位操作系统一样把DLL文件写到\Windows\System32文件夹里面。 
<br>

<br>
　　当然，WOW64知道安装向导通过emulator来运行的32位应用程序。同时也知道64和32位代码不能混合在一起。所以，WOW64 emulator 给\Windows\SysWOW64创建一个别名。这意味着任何时候32位应用程序要写入到\Windows\System32文件夹或者从\Windows\SysWOW64文件夹读取，WOW64 emulator都能使其改道到\Windows\SysWOW64文件夹。 
<br>

<br>
　　所有这些都意味着如果你需要手动操作\Windows\System32文件夹内的内容，你可能要非常的麻烦。我最近了解到一个管理员需要安装一些小的支持脚本到一个已经安装的应用程序，这个脚本的指导上说明这些脚本需要被存放到\Windows\System32文件夹。当然这些脚本的说明假定这个应用程序是在32位操作系统上运行的。 
<br>

<br>
　　这些脚本没有引起系统崩溃。然而Windows给人幻想永远不用进行更新。当管理员运行应用程序，它将被改道到\Windows\SysWOW64文件夹。管理员知道他自己把这些脚本放到\Windows\System32文件夹并且能通过Windows浏览器看到这些脚本，但是不能指出为什么应用程序不能看到这些脚本。考虑到这个问题是和权限相关的，他花费了一些时间来研究这个，所以知道了关于64位版本的Windows保存DLL文件隔离的方法，所以他能够把这些脚本放到\Windows\SysWOW64文件夹。
<br>

<br>
附上一款好用的DLL依赖查看器：Dependence walker（http://www.dependencywalker.com/）
<br>

