package com.hkedou.messagequeue.im;

import com.alibaba.fastjson.JSONObject;
import com.hkedou.common.logger.Logger;
import com.hkedou.common.logger.LoggerFactory;
import com.hkedou.messagequeue.mq.im.api.ImUserMessage;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerConcurrently;
import org.apache.rocketmq.common.message.MessageExt;
import org.apache.rocketmq.spring.starter.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.starter.core.RocketMQListener;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  18-10-30 上午11:32<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
//@Service
//@RocketMQMessageListener(topic = "${hkedou.mq.im.group.topic}",selectorExpress = "imUserCreate", consumerGroup = "${hkedou.mq.im.group.consumerGroup}")
//public class GroupImCreateUserConsumer
////        implements RocketMQListener<ImUserMessage>
//    implements  MessageListenerConcurrently
//{
//    public final static Logger logger= LoggerFactory.getLogger("com.hkedou.orighere.mq.im");
//
////    @Override
////    public void onMessage(ImUserMessage imUserMessage) {
////        logger.debug("imUserMessage={}", JSONObject.toJSONString(imUserMessage));
////    }
//
//    @Override
//    public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> list, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
//        logger.debug("list={}", JSONObject.toJSONString(list));
//        System.out.println("list="+JSONObject.toJSONString(list));
//        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
//    }
//}
