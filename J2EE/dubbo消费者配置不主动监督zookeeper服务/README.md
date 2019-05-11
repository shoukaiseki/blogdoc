# dubbo消费者配置不主动监督zookeeper服务

### 注意
两种方式不能同时使用,会造成配置冲突,起步了服务

## 方法一:springboot yml配置方式
```yaml
dubbo:
  consumer:
    retries: '0'
    check: 'true'
```


### consumer完整dubbo配置
```yaml
dubbo:
  consumer:
    retries: '0'
    check: 'true'
  registry:
    address: zookeeper://zookeeper.shoukaiseki.top:2181?client=curator
    id: test-app
  application:
    qos-enable: 'false'
    name: test-app
```

### provider完整dubbo配置
```yaml
dubbo:
  registry:
    address: zookeeper://zookeeper.shoukaiseki.top:2181?client=curator
    id: test-provider
  protocol:
    port: '-1'
  application:
    qosEnable: 'false'
    name: test-provider
  provider:
    filter: exceptionfilter
    retries: '0'
  scan:
    basePackages: org.shoukaiseki
  consumer:
    retries: '0'
```

## 方法二:springboot 类配置方式
```java
package org.shoukaiseki.springboot.plugin.dubbo.config;

import com.alibaba.dubbo.config.ConsumerConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * dubbo生产者未启动也能启动服务
 * <br>
 * com.hkedou.orighere.buyersystem.plugin.DubboConsumerConfig
 * <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  19-1-7 下午6:06<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
@Configuration
public class DubboConsumerIgnoreProducerConfig {

    /**
     * 消费者配置不主动监督zookeeper服务
     *
     * @return
     */
    @Bean
    public ConsumerConfig consumerConfig() {
        ConsumerConfig consumerConfig = new ConsumerConfig();
        consumerConfig.setCheck(false);
        //默认重试次数
        consumerConfig.setRetries(0);
//        consumerConfig.setTimeout(5000);
        return consumerConfig;
    }
}


```
