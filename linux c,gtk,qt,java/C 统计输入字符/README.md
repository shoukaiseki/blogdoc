# C 统计输入字符

## 程序1
```C
/*
//EOF（end of file ,文件结束）对应的按键是系统定义的
win是Ctrl+Z,linux是Ctrl+D,其中Linux是可以修改的
getchar()是回车按后才开始读取字符的
*/
#include<stdio.h>
long countch();
main()
{
    long n;         
    printf("EOF is %s\n",EOF);// 打印EOF的值
    printf("Please enter a character:");
    n=countch();
    printf("cn=%1d\n",n);
  getch();
  return 0;
 
}
long countch()
{
long cn;
for(cn=0;getchar()!=EOF;cn++);
return cn;
}
 
```
 
 
## 程序2
```C
/*只限字母
*/
#include<stdio.h>
#include<string.h>
 
main()
{
    int i,n,sum=0;
    char a[100];//根据字串的长度适当调整
    char *b;
    printf("Please enter a character:");
    b=&a;//指针应用mov b,#a
    gets(b);//gets(*b)无法正确保存到a,因为该函数是自动添加的b=*b,*b=**b=@(@b)=@a
    n=strlen(a);//n为总字符数
    /*strlen所作的仅仅是一个计数器的工作，
    它从内存的某个位置（可以是字符串开头，
    中间某个位置，甚至是某个不确定的内存区域）开始扫描，
    直到碰到第一个字符串结束符'\0'为止，然后返回计数器值。*/
    puts(a);// 送一字符串到流stdout中
    printf("%s=%d\n",a,n);
    for(i=0;i<=n-1;i++) //减去回车键包含的1字符
    {
        if((65<=a[i]&&a[i]<=90)||(97<=a[i]&&a[i]<=122))
            sum++;
    }
    printf("The number of characters:%d\n",sum);
  getch();
  return 0;
 
}
```
