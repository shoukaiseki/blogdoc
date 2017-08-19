# 判断一个素数能被几个9整除

/*
<br>
很多论坛讨论"判断一个素数能被几个9整除"
<br>
应该是2能被9+9整除,3能被9整除,5能被9+9+9+9+9整除
<br>
不过这样太没意思了,一个数如果是N,肯定能被N个9加起来整除的
<br>
如果是9+10*9+10^2*9+10^3*9.........10^n*9的话也不可能,至少2和5不能被个位是9的数整除
<br>
我记录下算法,执行结果不如任意,算法可贵阿
<br>
*/

```C
#include<stdio.h>
main()

{
     int i,n=1;
unsigned long int sum=9;
printf("Please enter a prime number:i= ");
scanf("%d",&i);
while(sum%i!=0)
{
sum=sum*10+9;
n++;
}
printf("%lu%%%d=0\n%lu has %d 9",sum,i,sum,n);
printf("\nGood bye!\nPress any key to off exit!\n");
return 0;
}

```
