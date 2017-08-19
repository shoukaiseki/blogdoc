# 枚举enum判断选择switch对齐

```C
/*
 
\t  横向跳格,可用于输出对齐
 
*/
#include<stdio.h>
main()
 
{
   enum weekday
    { sun,mon,tue,wed,thu,fri,sat} month[32],j,imasyuu;
     int i;
     imasyuu=sun;//imasyuu显示输出时起始位置为sunday
     j=mon;//设定本月1号为星期几
     printf("\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\n","sun","mon","tue","wed","thu","fri","sat");
     printf("\t");
     //if(imasyuu!=j)printf("\t");else printf("%d\t",i);
     //j!=imasyuu?printf("\t"):printf("%d\t",i);
     for(i=1;i<=31;)
     {
      month[i]=j;
      if(imasyuu!=j)
         printf("\t");//日期不在该星期显示位置下,主要用于1号不为星期日时的填空
      else
        {printf("%d\t",i);j++;i++;}//显示日期到正确位置
      //for(;getchar()!=EOF;)break;//调试用，每按Ctrl+D就显示一位数，找出死循环原因
         // printf("i=%d\t",i);//调试用， 
      imasyuu++;//显示位置增加一位
      //j!=imasyuu?printf("\t"):printf("%d\t",i);
      if (j>sat) {imasyuu=j=sun;printf("\n\t");}
     }
    printf("\nthe over display:\n");
    for(i=1;i<=31;i++)
      {
     switch(month[i])
         {
          case sun:printf(" %2d %s\t",i,"sun"); break;
          case mon:printf(" %2d %s\t",i,"mon"); break;
          case tue:printf(" %2d %s\t",i,"tue"); break;
          case wed:printf(" %2d %s\t",i,"wed"); break;
          case thu:printf(" %2d %s\t",i,"thu"); break;
          case fri:printf(" %2d %s\t",i,"fri"); break;
          case sat:printf(" %2d %s\t",i,"sat"); break;
          default:break;
          }
       }
printf("Good bye!\nPress any key to off exit!\n");
//getch();//Win系统请缴获该语句，Linux下需取消否则编译错误
  return 0;
}
/*
 
printf("Good bye!\nPress any key to off exit!");
 
getch();
 
return 0; 
 
*/
 
 
 
 
/*
 
\t  横向跳格,可用于输出对齐
 
*/
#include<stdio.h>
main()
 
{
   enum weekday
    { sun,mon,tue,wed,thu,fri,sat} month[32],j,imasyuu;
     int i,a;
     imasyuu=sun;//imasyuu显示输出时起始位置为sunday
     j=mon;//设定本月1号为星期几
     printf("\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\n","sun","mon","tue","wed","thu","fri","sat");
     printf("\t");
     //if(imasyuu!=j)printf("\t");else printf("%d\t",i);
     //j!=imasyuu?printf("\t"):printf("%d\t",i);
     for(;imasyuu!=j;)(printf("\t"),imasyuu++);//日期不在该星期显示位置下,主要用于1号不为星期日时的填空
     for(i=1;i<=31;i++)
     {
      month[i]=j;
      printf("%d\t",i);//显示日期到正确位置
      j++;
      //for(;getchar()!=EOF;)break;//调试用，每按Ctrl+D就显示一位数
         // printf("i=%d\t",i);//调试用， 
      imasyuu++;//显示位置增加一位
      //j!=imasyuu?printf("\t"):printf("%d\t",i);
      if (j>sat) {imasyuu=j=sun;printf("\n\t");}
     }
 
printf("\nGood bye!\nPress any key to off exit!\n");
//getch();//Win系统请缴获该语句，Linux下需取消否则编译错误
  return 0;
}
/*
 
printf("Good bye!\nPress any key to off exit!");
 
getch();
 
return 0; 
 
*/
```
