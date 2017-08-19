# itoa gcvt sizeof struct

```C
/*
Itoa  #include <stdlib.h>
原 型　char *itoa( int value, char *string,int radix);
功 能　把一整数转换为字符串 只限int类型整数
用 法  itoa(i,num,10);
　　i ----需要转换成字符串的数字
　　num---- 转换后保存字符串的变量
　　10---- 转换数字的基数（即进制）。10就是说按10进制转换数字。
           还可以是2，8，16等等你喜欢的进制类型
函数名: gcvt  #include <stdlib.h>
　　功 能: 把浮点数double转换成字符串char
　　用 法: char *gcvt(double value, int ndigit, char *buf);
value--被转换的值。ndigits--存储的有效数字位数。buf--结果的存储位置
 
*/
#include <string.h>
#include <stdlib.h>
#include <stdio.h>　　　　 //定义输入／输出函数
typedef struct ColPointCloud
{
int CPC_x;
double CPC_y;
} ;
 
main() 
{
char strList[200];
struct ColPointCloud current;
current.CPC_x=23;
current.CPC_y=23.0595;
itoa(current.CPC_x,strList,10);
printf("current.CPC_x=%s.\n",strList);
gcvt(current.CPC_y,sizeof(current.CPC_y),strList);
/*sizeof是C/C++中的一个操作符（operator）,不是函数,是常量
这里是在测double current.CPC_y的数据长度
简单的说其作用就是返回一个对象或者类型所占的内存字节数。*/
printf("current.CPC_y=%s.\n",strList);
 
printf("Good bye!\nPress any key to off exit!");
  getch();
  return 0;
} 
 
```
