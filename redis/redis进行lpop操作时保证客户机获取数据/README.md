# redis进行lpop操作时保证客户机获取数据
预防灾难如下:

当客户机进行lpop操作时,命令已经提交给redis,按时redis返回数据时出现网络状况,客户机获取到的是nil,但是实际上redis第一个元素已经被删除了

业务场景事例: 有A,B,C三人,A是任务处理人员,B是A的委托人,C是任务分发人

A委托B去C那里取任务档案,C有很多任务档案,是按照顺序分发的,直接给了B一个档案,但是B在回去向A复命过程中遇到台风,档案被台风刮走了,这时B回去告诉A档案没了,然而C也没备份,双方都懵了

那么这种情况怎么预防突发事件呢?先对任务档案进行复制一份,一份C存放到指定地点,一份给B带回,A收到任务档案之后C再进行销毁


### 设计逻辑图如下

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/redis/redis%E8%BF%9B%E8%A1%8Clpop%E6%93%8D%E4%BD%9C%E6%97%B6%E4%BF%9D%E8%AF%81%E5%AE%A2%E6%88%B7%E6%9C%BA%E8%8E%B7%E5%8F%96%E6%95%B0%E6%8D%AE/img/001.png)

plantuml模型源码

```uml
@startuml
"生成本次操作缓存key\n缓存value变量" -down-> "查询缓存key是否有对应值"
if "查询缓存key成功" then
	-->[true] if "查询缓存key是否有成功" then
	  -down->[true] "证明lpop成功但是业务未处理"
	  --> "处理业务"
	  if "删除缓存key成功" then
	     -->[true] (*)
	  else
	     -->[false] "保存到本地缓存删除key队列"
	  endif
	  --> (*)
	else
	  -down->[false] "使用获取第一个元素\nwatch key\nlindex key 0"
	  --> "缓存value变量=lindex获取的值"
	  --> "multi\nlpop key\nset 缓存key 缓存value\nexec"
	  if "事务执行返回成功" then
	     -->[true] "处理业务"
	  else
	     -->[false] "查询缓存key是否有对应值"
	  endif
	endif
else
  -->[false] "查询出错"
  --> "缓存value变量不为空"
  "缓存value变量不为空" -->[true] "保存到本地缓存业务处理队列"
	  --> (*)
  "缓存value变量不为空" -->[false] (*)
endif
@enduml
```

java代码

```Java

package testredis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.Response;
import redis.clients.jedis.Transaction;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TestRedis {

    public static void main(String[] args)  {
        new TestRedis().test();

    }

    public void test(){
        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
        for (int i = 0; i < 10; i++) {
            cachedThreadPool.execute(new TestRunnable(i));
        }
        cachedThreadPool.shutdown();
    }


    public  class TestRunnable implements Runnable{

        int i;

        public TestRunnable(int i){
            this.i=i;
        }

        @Override
        public void run() {
            Thread.currentThread().setName("tr-"+i);

            Jedis jedis = new Jedis("localhost");

            while (true){
                jedis.watch("jishu");
                Transaction multi = jedis.multi();
                Response<String> beforejishu = multi.get("jishu");
                multi.incrBy("jishu",i);
                Response<String> afterjishu = multi.get("jishu");
                List<Object> exec = multi.exec();
                if(exec.size()>0){
                    System.out.println(Thread.currentThread().toString()+".exec."+exec);
                    System.out.println(Thread.currentThread().toString()+beforejishu.get());
                    System.out.println(Thread.currentThread().toString()+afterjishu.get());
                    break;
                }
            }
        }
    }

}


```
