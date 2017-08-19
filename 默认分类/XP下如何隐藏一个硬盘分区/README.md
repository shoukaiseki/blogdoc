# XP下如何隐藏一个硬盘分区 

?具体操作：1运行“gpedit.msc”进入组策略编辑器。依次展开“本地计算机-用户配置-管理模板-WINDOWS组件-WINDOWS资源管理器”，从右边窗口中找到“隐藏我的电脑中的这些指定的驱动器”，双击打开设置窗口，在设置标签中选择“已启用”，并在下方下拉菜单中设置为“仅限制驱动器X（X为想要隐藏的分区）”就可以了。
<br>

<br>

<br>
windows xp下通常隐藏硬盘分区的方法不外以下两种，因为我装的是英文版的xp，方法1里没有对应的资源管理器选项，只能用方法2，但是方法2一次只能设置一个NoDrives，也就是说它只能隐藏一个硬盘分区，而我想把其他硬盘分区全部隐藏掉，请问有没有什么好的方法呢?
<br>
谢谢！
<br>

<br>
方法1：   开始——运行——GPEDIT.MSC，打开组策略——用户配置——管理模板——WINDOWS组件——WINDOWS资源管理器——右侧找到——在我的电脑中隐藏这些驱动器——打开——选择仅D盘就可以，如果想禁止访问，下面一条策略就可以实现，同样的道理。
<br>

<br>

<br>
方法2：   在[开始]-->[运行]-->键入[Regedit]-->[HKEY_CURRENT_USER]--> [Software]-->[Microsoft]-->[Windows]-->[CurrentVersion]-->[Policies] -->[Explorer]-->增加一个 DWORD 值[NoDrives]的数值数据请使用十进制及如下设定：隐藏 A 盘为[1]，隐藏 B 盘为 A 盘的一倍即[2]，隐藏 C 盘为 B 盘的一倍即[4]，如此类推，如全部隐藏则为[67108863]。
<br>
另在[HKEY_LOCAL_MACHINE]-->[Software]-->[Microsoft]-->[Windows]--> [CurrentVersion]-->[Policies]-->[Explorer]-->增加一个 DWORD 值，[NoDrives]的数值数据请使用十进制及如下设定：隐藏 A 盘为[1]，隐藏 B 盘为 A 盘的一倍即[2]，隐藏 C 盘为 B 盘的一倍即[4]，如此类推，如全部隐藏则为[67108863]。
<br>

<br>
本人设置时新建[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]的即可了
<br>
修改注册表后无法生效,最高计算好一次成功,失败后用组策略先禁用所有驱动器再显示所有驱动器,也可能要注销
<br>
NoDrives
<br>
另外本人开发了一个小程序xphp.exe下载地址: http://u.115.com/file/bhugrlek(包含C源码)
<br>

<br>
点击查看C源码
<br>

<br>
运行之后输入要隐藏的分区,例:输入klmn回车即可出现00003C00
<br>
Results hex(no 0x) is :
<br>
16进制隐藏 K L M N盘  值为 3C00
<br>
二进制转16进制表
<br>
0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
<br>
 0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
<br>
转换为二进制查看为
<br>
11111111111111111111111111111111
<br>
    ZYXWVUTSRQPONMLKJIHGFEDCBA
<br>
1为隐身 0为显示所以全部隐身为
<br>
00000011111111111111111111111111  = 0x03FFFFFF
<br>
如果选择编辑二进制数据它是排列是
<br>
11111111111111111111111111111111
<br>
HGFEDCBAPONMLKJIXWVUTSRQ    ZY
<br>

<br>

<br>

<br>

<br>
组策略编辑器无法打开,提示"MMC无法创建管理单元"
<br>
regsvr32 wsecedit.dll  最后执行这个就可以打开GPEDIT.MSC了
<br>
(regsvr32 gedit.dll wsecedit.dll   网上google的是这个,不过我这样加载dll出错)
<br>

<br>
如果执行regsvr32 wsecedit.dll错误:
<br>
将Framedyn.dll文件从windowssystem32wbem目录下拷贝到windowssystem32目录下，再重新注册一下gpedit.dll就可以打开gpedit.msc了。
<br>
copy 
<br>

