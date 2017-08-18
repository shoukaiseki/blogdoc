# java多线程关键字

```Java
Runnable   多线程接口 class TestThread implements Runnable//TeseThread 拥有Runnable接口
Thread       多线程类    TestThread t =new TestThread();//声明类t并实例化
                                     Thread a = new Thread(t);//创建Thread对象a
start           开启线程     a.start();
setName    设置线程名  a.setName("asus");//设置该线程名为asus
getName    取线程名     String b = a.getName();//字符串b存放a的线程名
isAlive        取线程运行状态  boolean c = a.isAlive();//布尔值c存放a是否开启线程,结果false或true
sleep          线程休眠    a.sleep(100);//线程休眠100ms
synchronized  多线程时的同步块(方法)设置
join            线程强制运行,即先将该线程运行完毕再运行其它线程a.join();//线程a强制运行
interrupt   中断线程,强行中断在运行的线程,休眠后的线程终端后会出现InterruptedException异常,a.interrupt();//中断线程a
```
