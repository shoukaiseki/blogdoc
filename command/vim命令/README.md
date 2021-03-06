# vim命令  

```Vim
:%s/./&/g   //统计字符,执行完成以后会显示字数和行数,利用了替换的副作用 %是指对全文每一行都应用
:g/^$/d //删除空行
:%s/\n//g //删除换行符(按J键也是删除换行符) \n 换行符 \r 回车符(GB2312编码文件中看到的行末^M) $行末 ^行首
:%s/</\r</g //在<前面添加回车键
:set fileencoding    在Vim 中可以直接查看文件编码
 
Vim 中简单得模式匹配 元字符 和常用模式匹配

元字符	描述
.点	匹配任何单个字符。例如正则表达式r.t匹配这些字符串：rat、rut、r t，但是不匹配root。
$	匹配行结束符。例如正则表达式weasel$ 能够匹配字符串"He's a weasel"的末尾 
但是不能匹配字符串"They are a bunch of weasels."
^	匹配一行的开始。例如正则表达式^When in能够匹配字符串"When in the course of human events"的开始，但是不能匹配"What and When in the"
*	匹配0或多个正好在它之前的那个字符。例如正则表达式 .* 意味着能够匹配任意数量的任何字符。比如<T>.*</T> 可以匹配<T>不管是什么</T>
\	这是引用符，用来将这里列出的这些元字符当作普通的字符来进行匹配。例如正则表达式\$被用来匹配美元符号，而不是行尾，类似的，正则表达式\.用来匹配点字符，而不是任何字符的通配符。
[ ] 
[c1-c2] 
[^c1-c2]	匹配括号中的任何一个字符。例如正则表达式r[aou]t匹配rat、rot和rut，但是不匹配ret。可以在括号中使用连字符-来指定字符的区间，例如正则表达式[0-9]可以匹配任何数字字符；还可以制定多个区间，例如正则表达式[A-Za-z]可以匹配任何大小写字母。另一个重要的用法是“排除”，要想匹配除了指定区间之外的字符——也就是所谓的补集——在左边的括号和第一个字符之间使用^字符，例如正则表达式[^269A-Z] 将匹配除了2、6、9和所有大写字母之外的任何字符。
\< \>	匹配词（word）的开始（\<）和结束（\>）。例如正则表达式\<the\>能够匹配字符串"for the wise"中的"the"，但是不能匹配字符串"otherwise"中的"the"。注意：这个元字符不是所有的软件都支持的。
\( \)	将 \( 和 \) 之间的表达式定义为“组”（group），并且将匹配这个表达式的字符保存到一个临时区域（一个正则表达式中最多可以保存9个），它们可以用 \1 到\9 的符号来引用。
|	将两个匹配条件进行逻辑“或”（Or）运算。例如正则表达式(him|her) 匹配"it belongs to him"和"it belongs to her"，但是不能匹配"it belongs to them."。注意：这个元字符不是所有的软件都支持的。
+	匹配1或多个正好在它之前的那个字符。例如正则表达式9+匹配9、99、999等。注意：这个元字符不是所有的软件都支持的。
?	匹配0或1个正好在它之前的那个字符。注意：这个元字符不是所有的软件都支持的。
{i} 
{i,j}	匹配指定数目的字符，这些字符是在它之前的表达式定义的。例如正则表达式A[0-9]{3} 能够匹配字符"A"后面跟着正好3个数字字符的串，例如A123、A348等，但是不匹配A1234。而正则表达式[0-9]{4,6} 匹配连续的任意4个、5个或者6个数字字符。注意：这个元字符不是所有的软件都支持的。
常用的正则表达式主要有以下几种：

　　匹配中文字符的正则表达式： [\一-\龥]
　　评注：匹配中文还真是个头疼的事，有了这个表达式就好办了哦
　　获取日期正则表达式：\d{4}[年|\-|\.]\d{\1-\12}[月|\-|\.]\d{\1-\31}日?
　　评注：可用来匹配大多数年月日信息。
　　匹配双字节字符(包括汉字在内)：[^\x00-\xff]
　　评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
　　匹配空白行的正则表达式：\n\s*\r
　　评注：可以用来删除空白行
　　匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</>|<.*? />
　　评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
　　匹配首尾空白字符的正则表达式：^\s*|\s*$
　　评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
　　匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
　　评注：表单验证时很实用
　　匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
　　评注：网上流传的版本功能很有限，上面这个基本可以满足需求
　　匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
　　评注：表单验证时很实用
　　匹配国内电话号码：\d{4}-\d{7}|\d{3}-\d{8}
　　评注：匹配形式如 0511 - 4405222 或 021 - 87888822
　　匹配腾讯QQ号：[1-9][0-9]\{4,\}
　　评注：腾讯QQ号从1000 0 开始
　　匹配中国邮政编码：[1-9]\d{5}(?!\d)
　　评注：中国邮政编码为6位数字
　　匹配身份证：\d{17}[\d|X]|\d{15}
　　评注：中国的身份证为15位或18位
　　匹配ip地址：((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)。
　　评注：提取ip地址时有用
　　匹配特定数字：
　　^[1-9]\d*$　//匹配正整数
　　^-[1-9]\d*$ //匹配负整数
　　^-?[1-9]\d*$　//匹配整数
　　^[1-9]\d*|0$　//匹配非负整数（正整数 + 0）
　　^-[1-9]\d*|0$　//匹配非正整数（负整数 + 0）
　　^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$　//匹配正浮点数
　　^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$　//匹配负浮点数
　　^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$　//匹配浮点数
　　^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$　//匹配非负浮点数（正浮点数 + 0）
　　^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$　//匹配非正浮点数（负浮点数 + 0）
　　评注：处理大量数据时有用，具体应用时注意修正
　　匹配特定字符串：
　　^[A-Za-z]+$　//匹配由26个英文字母组成的字符串
　　^[A-Z]+$　//匹配由26个英文字母的大写组成的字符串
　　^[a-z]+$　//匹配由26个英文字母的小写组成的字符串
　　^[A-Za-z0-9]+$　//匹配由数字和26个英文字母组成的字符串
　　^\w+$　//匹配由数字、26个英文字母或者下划线组成的字符串

```
