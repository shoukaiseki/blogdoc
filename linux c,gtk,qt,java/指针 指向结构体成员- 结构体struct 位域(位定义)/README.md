# 指针* 指向结构体成员-> 结构体struct 位域(位定义) 

```C
/*
-> 为指向结构体成员,当一个指针指向结构体时,
如果要这个指针指向这个结构体的某个成员时,使用->
*/
int main(void) 
{ 
struct bs 
{ 
unsigned a: 1; 
unsigned b: 3;
unsigned c: 4;
}bit, *pbit; 
bit.a = 1; 
bit.b = 7; 
bit.c = 15;//赋值时不可超过该位域的允许范围,否则可能会影响其它位域的数据
printf(" bit.a =%d     bit.b =%d     bit.c =%d\n", bit.a, bit.b, bit.c);
pbit = &bit;//指针指向bit
pbit->a = 0;//相当于bit.a = 0;
pbit->b &= 3;//b=b&3=3
pbit->c |= 1;//c=c|1=15
printf("pbit->a=%d    pbit->b=%d    pbit->c=%d\n", pbit->a, pbit->b, pbit->c);
 
printf("Good bye!\nPress any key to off exit!");
getch();
return 0; 
}

```
