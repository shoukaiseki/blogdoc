# eclipse自动补全设置  

一般默认情况下，Eclipse ，MyEclipse 的代码提示功能是比Microsoft Visual Studio的差很多的，主要是Eclipse ，MyEclipse本身有很多选项是默认关闭的，要开发者自己去手动配置。如果开发者不清楚的话，就不知道Eclipse ，MyEclipse的代码提示功能一样能像Microsoft Visual Studio的代码提 示功能一样强大。
<br>
先举个简单的例子说明问题所在，例如在Eclipse ，MyEclipse代码里面，打个foreach，switch等这些，是无法得到代码提示的（不信自己试试），其他的就更不用说了，而在Microsoft Visual Studio 里面是得到非常友好的代码提示的。实际上，Eclipse ，MyEclipse代码里面的代码提示功能默认的一般是点“.”，一般是有了点“.”，才会有代码提示。
<br>
   原理：“Auto Activation triggers for java”这个选项就是指触发代码提示的的选项，把“.” 改成“.abcdefghijklmnopqrstuvwxyz(,”的意思，就是指遇到26个字母和.，（这些符号就触发代码提示功能了。（具体后面有说，放心）增强Eclipse ，MyEclipse 的代码提示功能，具体怎么样来配置？下面开始说步骤：
<br>

<br>
1. 打开Eclipse，然后“window”→“Preferences”
<br>
2. 选择“java”，展开，“Editor”，选择“Content Assist”。
<br>
3. 选择“Content Assist”，然后看到右边，右边的“Auto-Activation”下面的“Auto Activation triggers for java”这个选项。其实就是指触发代码提示的就是“.”这个符号.
<br>
4. “Auto Activation triggers for java”这个选项，在“.”后加abc字母，方便后面的查找修改。然后“apply”，点击“OK”。
<br>
5. 然后，“File”→“Export”，在弹出的窗口中选择“General -> Perferences”，点击“下一步”。
<br>
6. 选择导出文件路径，本人导出到桌面，输入“test”作为文件名，点击“保存”。
<br>
7. 在桌面找到刚在保存的文件“test.epf”,右键选择“用记事本打开”。
<br>
8. 可以看到很多配置MyEclipse 6.0.1的信息
<br>
9. 按“ctrl + F”快捷键，输入“.abc”，点击“查找下一个”。
<br>
10. 查找到“.abc”的配置信息.
<br>
11. 把“.abc”改成“.abcdefghijklmnopqrstuvwxyz(,”，保存，关闭“test.epf”。
<br>
12. 回到MyEclipse 6.0.1界面，“File”→“Import”，在弹出的窗口中选择“General -> Perferences”，点击 “下一步”，选择刚在已经修改的“test.epf”文件，点击“打开”，点击“Finish”。该步骤和上面 的导出步骤类似。
<br>
13. 最后当然是进行代码测试了。随便新建一个工程，新建一个类。在代码输入switch，foreach等进行测试。你立即会发现，果然出了提示，而且无论是敲哪个字母都会有很多相关的提示了，很流畅，很方便。
<br>
总结：“Auto Activation triggers for java”这个选项就是指触发代码提示的的选项，把“.”改成 “.abcdefghijklmnopqrstuvwxyz(,”的意思，就是指遇到26个字母和.，（这些符号就触发代码提示功 能了。顺便说一下，修改类名，接口名等以不同颜色高亮的，可以这样配置在“java”→“enditor”→ “syntac”，右边展开“java”→“classes”，勾上“Enable”这个选项，选择自己喜欢的颜色即可。当然还有其他相关的颜色配置。具体就不说啦。其实，在“Preferences”这个东西，有很多可以配置的 东西，使得MyEclipse 优化的，具体的就要各个人根据自己个人喜好去配置了。
<br>
转自：http://www.javaeye.com/topic/627518
<br>

