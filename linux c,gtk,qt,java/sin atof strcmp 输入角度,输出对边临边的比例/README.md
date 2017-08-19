# sin atof strcmp 输入角度,输出对边/临边的比例  

```C
/*
输入角度,输出对边/临边的比例
输入exit退出计算
调用格式： 〈双精度小数型〉 求正弦 （双精度小数型 欲进行计算的角） - 系统核心支持库->算术运算
    英文名称：sin   #include <math.h>
    返回指定角的正弦值。本命令为初级命令。
    参数<1>的名称为“欲进行计算的角”，类型为“双精度小数型（double）”。所使用单位为弧度。为了将角度转换成弧度，请将角度乘以 #pi / 180。为了将弧度转换成角度，请将弧度乘以 180 / #pi。如果参数值大于等于 2 的 63 次方，或者小于等于 -2 的 63 次方，将导致计算溢出。
 
 atof
#include <stdlib.h>
double atof(const char *str);
把字符串str转换成double类型。等价于：strtod(str, (char**)NULL)。
 
strcmp
#include <string.h>
int strcmp(const char *str1, const char *str2);
按字典顺序比较两个字符串，返回整数值的意义如下：
小于0，str1小于str2； 
等于0，str1等于str2； 
大于0，str1大于str2； 
 
*/
#include <stdlib.h>
#include <math.h>
#include "stdio.h"
#include "conio.h"
#define PI 3.141592
main()
{
double x,s;
char a[200];
printf("Hello,welcome to PC!\n");
printf("Please enter the calculation of the angle:");
while(1)
{
//sc%lf",&x);
scanf("%s",a);    
x=atof(a);//atof将字符串转换成双精度浮点
 
printf("sine of %lf \n",x);
printf("a is %s\n",&a);
//if(sscanf(a, "exit")!=1)
//if(a[0]!="e")
if(strcmp(a, "exit")!=0)
/*  */
 
{
s=sin(x*PI/180);//x为角度, s为对边/临边的比例
printf("sine of %lf is %lf\n",x,s);
printf("Please enter the calculation of the angle:");
}
else
{printf("\nto exit!\n");
break;//退出循环
}
}
 
printf("Good bye!\nPress any key to off exit!");
getch();
return(0);
}
```

