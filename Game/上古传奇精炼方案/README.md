# 上古传奇精炼方案  

```JavA
package test;

import java.util.Arrays;
import java.util.Comparator;

public class test {
 /* 十个整数的和为91,最小值为1,最大值为10
  * 
  * */
 public static void main(String args[]) 

 {
  int jlnumber = 10;//精炼次数
  int n=0;//组合种数
  int thesum=91;//精炼后总值
  int themax=10;//精炼一次最高加的值
  int thissum = 0;//计算总和用
  int lzmax=0;//合成所需最高价值
  int lzmin=0;//合成所需最低价值
  int lzsum =0;//需要一级龙珠的个数
  int lzcompare[]=new int[jlnumber];//排序专用
  int lzthemin[]=new int[jlnumber];//保存排列后的最小值
  int lzlzmin[]=new int[jlnumber];//保存精炼价值的最小值
  int lzlzmax[]=new int[jlnumber];//保存精炼价值的最大值
  int a[] =new int[jlnumber];//共10颗龙珠,该数组存放龙珠的各星级数,即精炼次数
  int test =0;
  boolean asustest = false;//
  for(int i=0;i<a.length;i++)
  {
   a[i]=1;//先赋予装备的龙珠最小值
   lzthemin[i]=themax;//排列后的最小值,先赋予装备最高精炼值
  }
  System.out.println("装备精炼次数为: "+jlnumber+" 次,精炼后总和为: +"+thesum+" 以下为精炼方案!");//3的8次方
   for(;a[a.length-1]<=themax;)//数组最后一位不得超过精炼最高值
   {
    for(int j=1;j<=themax;j++)//数组最低位递加,到达上限是向高位进1
    {
     a[0]=j;
     thissum = 0;//每次清零,存放数组的和
     for(int k=0;k<a.length;k++)
     {
      thissum +=a[k];
     }
//     if (thissum>test) {
//      test=thissum;
//      System.out.println(test);//测试输出
//     }
//     
     if (thissum==thesum)
     {
//      for(int ib=0;ib <a.length;ib++)//复制数组
//      {
//      lzcompare[ib] = a[ib];
//      }
      System.arraycopy(a,0,lzcompare,0,a.length);
      Arrays.sort(lzcompare);//数组排序,从小到大
//      int x,y,z;
//      for(x=0;x<lzcompare.length;x++)
//      {
//       //数组排序,从大到小
//       for(y = x + 1;y<lzcompare.length;y++)
//        if(lzcompare[x]<lzcompare[y])
//        {
//         z=lzcompare[x];lzcompare[x]=lzcompare[y];lzcompare[y]=z;
//        }
//      } 
      asustest = false;
//      System.out.println(asustest);
      for (int i = lzcompare.length-1; i >=0; i--)
      {
       if (lzthemin[i]>lzcompare[i]) 
       {
        asustest =true;
//        System.out.println(asustest);
       }
       else 
       {
        if (lzthemin[i]<lzcompare[i]) {
         break;
        }
       }
      }
//      System.out.println(asustest);
      if (asustest) 
      {
       n++;
       System.out.print("第"+n+"种组合为: ");
       for(int ia=0;ia <a.length;ia++)//最小值数组
       {
        lzthemin[ia] = lzcompare[ia];
       }
        lzsum =0;//需要一级龙珠的个数
        for(int k=0;k<lzcompare.length;k++)
        {
         System.out.print(lzcompare[k]+"  ");
         lzsum+=Math.pow(3, lzcompare[k]+1);
        }

       int lzprice=1;//龙珠价格
       int lztatallprice=lzsum*lzprice;
       if (lzmax<lztatallprice||lzmax==0) 
       {
        lzmax=lztatallprice;//使用金币最大值
        for(int ib=0;ib <lzcompare.length;ib++)
        {
        lzlzmax[ib] = lzcompare[ib];
        }
       }
       if (lzmin>lztatallprice||lzmin==0) {
        lzmin=lztatallprice;//使用金币最小值
        for(int ic=0;ic <lzcompare.length;ic++)
        {
        lzlzmin[ic] = lzcompare[ic];
        }
       }
       System.out.println("共需要一级龙珠"+lzsum+"颗,按照每颗"+lzprice+"万计算的的话,龙珠价值为"+lztatallprice+"万金币");

      }
      
     }
    }
    a[0]++;//向高位进位
    for (int j2 = 0; j2 < a.length; j2++)
    {
     if(a[j2]==11)
     {
      a[j2]=1;
      if (j2!=(a.length-1)) {
       a[j2+1]+=1;
      }
      else {
       a[j2]=themax+1;
      }
     }
    }
   } 
  System.out.println("合成此值的最低价格为"+lzmin+"万金币.合成方式为: ");
  for(int k=0;k<lzcompare.length;k++)
  {
   System.out.print(lzlzmin[k]+"  ");
  }
  System.out.println();
  System.out.println("合成此值的最高价格为"+lzmax+"万金币.");
  for(int k=0;k<lzcompare.length;k++)
  {
   System.out.print(lzlzmax[k]+"  ");
  }
  System.out.println();
  System.out.println("The calculation is complete");
  
 }
}

```
