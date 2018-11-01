package com.hkedou.messagequeue.im;

import com.hkedou.common.logger.Logger;
import com.hkedou.common.logger.LoggerConstants;
import com.hkedou.messagequeue.mq.im.api.config.MQImUserCreateProperties;
import com.hkedou.messagequeue.mq.im.logging.FixedLoggers;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.common.consumer.ConsumeFromWhere;
import org.apache.rocketmq.common.protocol.heartbeat.MessageModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;

/**
 * <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  18-10-30 下午7:39<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
@Component
public class GroupImCreateUserConsumerConcurrently {

    private SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    static final Logger logger= FixedLoggers.MQ_IM_LOGGER;


    @Resource
    MQImUserCreateProperties ucp;

    /**
     * NameServer 地址
     */
    @Value("${spring.rocketmq.nameServer}")
    private String nameServer;



    @PostConstruct
    public void defaultMQPushConsumer() {
        logger.debug("{}defaultMQPushConsumer", LoggerConstants.PREFIX);


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

            consumer.setMessageModel(MessageModel.BROADCASTING);


            //设置Consumer第一次启动是从队列头部开始消费还是队列尾部开始消费
            //如果非第一次启动，那么按照上次消费的位置继续消费
            consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);
//            consumer.registerMessageListener(messageListenerConcurrently);
            consumer.registerMessageListener(new ImCreateUserMessageListener());
            consumer.start();
        } catch (Exception e) {
            logger.error("",e);
        }

    }

//    MessageListenerConcurrently messageListenerConcurrently=new MessageListenerConcurrently(){
//
//        @Override
//        public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> list, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
//            logger.debug("dt={}",sdf.format(new Date()));
//            try {
//
//                List<Object> list2= Lists.newArrayList();
//                for (MessageExt messageExt : list) {
//                    //输出消息内容
////                            System.out.println("messageExt: " + messageExt);
//
//                    String messageBody = new String(messageExt.getBody(), RemotingHelper.DEFAULT_CHARSET);
//                    ImUserMessage imUserMessage;
//                    try {
//                        imUserMessage = JSONObject.parseObject((messageBody),ImUserMessage.class);
//                        list2.add(imUserMessage);
//                    }catch (Exception e){
//                        e.printStackTrace();
//
//                    }
//
//                    //输出消息内容
////                        System.out.println("消费响应：msgId : " + messageExt.getMsgId() + ",  msgBody : " + messageBody);
//                    //输出消息内容
////                        System.out.println("消费响应：msgId : " + messageExt.getMsgId() + ",  msgBody : " + messageBody);
//                }
//                System.out.println("list.imUserCreate="+JSONObject.toJSONString(list2));
//            } catch (Exception e) {
//                logger.error("",e);
//                //稍后再试
//                return ConsumeConcurrentlyStatus.RECONSUME_LATER;
//            }
//            //消费成功
//            return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
//        }
//    };

}
