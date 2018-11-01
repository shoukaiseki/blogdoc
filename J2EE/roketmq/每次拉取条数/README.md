# 每次拉取条数


设置了 setConsumeMessageBatchMaxSize 和 setPullBatchSize 之后,你会发现每次MessageListenerOrderly处理的还是32条,实际上参数已经生效了,

开启debug后在 ConsumeMessageOrderlyService 的 361 行[ int consumeBatchSize = ConsumeMessageOrderlyService.this.defaultMQPushConsumer.getConsumeMessageBatchMaxSize();]打断点,能够看到获取到的参数是没问题的

断点处不允许,等个几分钟,就能发现每次处理的就越来越多,向 batchSize 最大值靠近,说明是生效的,消息量达到一定程度就能每次按照峰值处理

```Java

        //消费者的组名
        DefaultMQPushConsumer consumer = new DefaultMQPushConsumer(ucp.getConsumerGroup());

        //指定NameServer地址，多个地址以 ; 隔开
        consumer.setNamesrvAddr(nameServer);
        try {
            //订阅topic下Tag为 * 的消息
            consumer.subscribe(ucp.getTopic(), "*");


            //每个线程的最大消费条数
            consumer.setConsumeMessageBatchMaxSize(ucp.getConsumeMessageBatchMaxSize());

            //rocket控制台中设置 主题 的读队列数量为1,因为默认为4,会出现4个线程,设置为1只有1个线程
//            consumer.setConsumeThreadMin(1);
//            consumer.setConsumeThreadMax(1);

            //检查单队列并行消费允许的最大跨度
//                consumer.setConsumeConcurrentlyMaxSpan(1000);

            //拉取数量 默认为:32
            consumer.setPullBatchSize(ucp.getPullBatchSize());

//            consumer.setPullThresholdForQueue(ucp.getPullBatchSize());


            //拉取间隔为3秒一次[有效]
            consumer.setPullInterval(ucp.getPullInterval());

            //为主题设置拉阈值大小
//            consumer.setPullThresholdSizeForTopic(ucp.getPullBatchSize());

//            consumer.setPullThresholdForTopic(ucp.getPullBatchSize());


//            consumer.setConsumeTimeout(3000);

            //此处使用该模式无效,无法获取消息
//            consumer.setMessageModel(MessageModel.BROADCASTING);

            //设置Consumer第一次启动是从队列头部开始消费还是队列尾部开始消费
            //如果非第一次启动，那么按照上次消费的位置继续消费
            consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);
//            consumer.registerMessageListener(messageListenerConcurrently);
            consumer.registerMessageListener(new ImCreateUserMessageListener());
            consumer.start();
        } catch (Exception e) {
            logger.error("",e);
        }
```
