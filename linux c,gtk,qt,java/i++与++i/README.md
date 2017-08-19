# i++与++i  

```C
/*执行顺序
a++;//a=2
b++;//b=3
a+b=5
sum=fun(5,3)=8;
c++;//c=4
换成++c就是
c++;//c=4
sum=fun(5,4)=9
*/
#include <math.h>　　　　　//定义数学函数
#include <stdio.h>　　　　 //定义输入／输出函数
 
fun(int x, int y){return(y+x);}
main() 
{ int a=1,b=2,c=3,sum; 
sum=fun((a++,b++,a+b),c++);//++c(加后再函数),c++为执行此条后再进行自加
 
printf("sum=%d  c=%d\n",sum,c);
  getch();
  return 0;
} 
```
