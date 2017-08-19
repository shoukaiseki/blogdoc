# atof strcpy memcpy strlen

```C
/*
atof将字符串a转换成双精度浮点x
strcpy字符串赋值  因为*a="123abc456\0"是错误的
字符串不能这样赋值
*str其实和str[0]是等效的
另外str是数组，所以这个指针是常量，所以也不能使用类似str="asdf";的方式进行赋值。
你可以用<string.h>中的strcpy()函数，该函数会自动添加\0
 strcpy
#include <string.h>
char *strcpy(char *str1, const char *str2);
把字符串str2(包括'\0')拷贝到字符串str1当中，并返回str1。
memcpy
#include <string.h>
void *memcpy(void *to, const void *from, size_t count);
把from中的count个字符拷贝到to中。并返回to。
 
strlen
#include <string.h>
size_t strlen(const char *str);
返回字符串str的长度，'\0'不算在内。
 
*/
#include <stdlib.h>
#include <string.h>
#include <math.h>　　　　　//定义数学函数
#include <stdio.h>　　　　 //定义输入／输出函数
 
main() 
{
double x;
char a[200]="8008206655";
char b[200];
x=atof(a);//atof将字符串a转换成双精度浮点x
printf("a=%s  x=%lf\n",&a,x);
strcpy(a,"123abc456");
x=atof(a);//atof将字符串a转换成双精度浮点x
printf("a=%s  x=%lf\n",&a,x);
memcpy(b,"123abc456",strlen("123abc456"));
x=atof(b);//atof将字符串a转换成双精度浮点x
printf("b=%s  x=%lf\n",&b,x);
printf("Good bye!\nPress any key to off exit!");
  getch();
  return 0;
} 

```
