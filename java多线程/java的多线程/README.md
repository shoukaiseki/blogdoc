# java的多线程  

查看高亮源码http://hi.baidu.com/jiangxinyi21/blog/item/c6d0a12e80720d0c8b82a14f.html
```Java
/*
结果没有按照顺序递减,但是没有重复,输出也没超标,可能跟双核CPU的关系
*/
public class runnable
{
 public static void main(String [] args)
 {
  TestThread t = new TestThread() ;
 // SetNameThreadDemo tt = new SetNameThreadDemo();
  // 启动了六个线程,并实现了资源共享的目的
  Thread a = new Thread(t);//创建匿名对象并开启线程
  System.out.println("1= "+a.isAlive());
  a.start();
  System.out.println("1 = "+ a.isAlive());
  Thread b = new Thread(t,"2");//设置进程名
  b.start();
  Thread c = new Thread(t);
  c.start();
  c.setName("3");
  new Thread(t,"4").start();
  new Thread(t,"5").start();
  new Thread(t,"6").start();
  
  System.out.println("2 = "+ b.isAlive());
  System.out.println("3 = "+ c.isAlive());
 }
}
/*
很多其它线程比较过了之后再去减1,然后休眠,如果比较时tickets=1,此线程进入休眠,其它线程也继续比较,然后休眠,最后休眠中的线程重新开始执行,导致出现tickets=-1,-2,-3,-4的情况
因此加入同步代码块(synchronized),同步代码块的含义就是,只有一个进程在代码块中执行,就像WC一样,其余人要等待,等他上完才能进去其它人.
还可以同步方法,看下面程序
*/
/*
class TestThread  implements Runnable// extends Thread
{
 private int tickets=200;
 public void run()
 {
  while(true)
  {
   try
   {
    Thread.sleep(100);
   }
   catch(Exception f){}//在同步代码块前线程休眠一段时间,给其它线程执行的机会,不然出现独占严重
   synchronized(this)
   {
    if(tickets>0)
    {
     try//休眠会出现异常,所以需要异常处理
     {
      Thread.sleep(100);//线程休眠100ms
     }
     catch(Exception e){}
     System.out.println(Thread.currentThread().getName()+"="+tickets--);
    }
   }
  }
 }
}
*/
/*
同步方法
*/
class TestThread  implements Runnable// extends Thread
{
 private int tickets=200;
 public void run()
 {
  while(tickets!=0)
  {
   try
   {
    Thread.sleep(100);
   }
   catch(Exception f){}//在调用同步方法前线程休眠一段时间,给其它线程执行的机会,不然出现独占严重
   sale();
  }
 }
 public synchronized void sale()//同步方法
 {
  if(tickets>0)
  {
   try//休眠会出现异常,所以需要异常处理
   {
    Thread.sleep(100);//线程休眠100ms
   }
   catch(Exception e){}
   System.out.println(Thread.currentThread().getName()+"="+tickets--);
  }
 }

}
```

