package com.hkedou.messagequeue.im;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.hkedou.common.logger.Logger;
import com.hkedou.messagequeue.mq.im.api.ImUserMessage;
import com.hkedou.messagequeue.mq.im.logging.FixedLoggers;
import org.apache.rocketmq.client.consumer.listener.ConsumeOrderlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeOrderlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerOrderly;
import org.apache.rocketmq.common.message.MessageExt;
import org.apache.rocketmq.remoting.common.RemotingHelper;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  18-10-31 下午3:53<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class ImCreateUserMessageListener implements MessageListenerOrderly
{
    private SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    static final Logger logger= FixedLoggers.MQ_IM_LOGGER;

    @Override
    public ConsumeOrderlyStatus consumeMessage(List<MessageExt> list, ConsumeOrderlyContext context) {
        context.setAutoCommit(true);
        logger.debug("dt={}",sdf.format(new Date()));
        try {

            List<Object> list2= Lists.newArrayList();
            for (MessageExt messageExt : list) {
                //输出消息内容
//                            System.out.println("messageExt: " + messageExt);

                String messageBody = new String(messageExt.getBody(), RemotingHelper.DEFAULT_CHARSET);
                ImUserMessage imUserMessage;
                try {
                    imUserMessage = JSONObject.parseObject((messageBody),ImUserMessage.class);
                    list2.add(imUserMessage);
                }catch (Exception e){
                    e.printStackTrace();

                }

                //输出消息内容
//                        System.out.println("消费响应：msgId : " + messageExt.getMsgId() + ",  msgBody : " + messageBody);
                //输出消息内容
//                        System.out.println("消费响应：msgId : " + messageExt.getMsgId() + ",  msgBody : " + messageBody);
            }
            System.out.println("list.imUserCreate="+JSONObject.toJSONString(list2));

        } catch (Exception e) {
            logger.error("",e);
            //稍后再试
            return ConsumeOrderlyStatus.ROLLBACK;
        }
        //消费成功
        return ConsumeOrderlyStatus.SUCCESS;
    }
}
