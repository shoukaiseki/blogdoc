# 测试for语法  

```C
/*File is named for.c(for.exe) running error
*/
#include<stdio.h>
#include<string.h>
 
main()
{
    int i,n,sum=0;
    for(i=1;i<=2;i++)  //i=1
    {
     //i<=2 ? yes(Execution next)  no(return)
     sum++;
     //i++  だから for(i=0;i<=2;i++)はエラーが発生です
    }
    printf("The number of characters:%d\n",sum);
  getch();
  return 0;
}
```
