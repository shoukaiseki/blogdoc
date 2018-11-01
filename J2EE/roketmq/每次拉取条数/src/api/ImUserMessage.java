package com.hkedou.messagequeue.mq.im.api;


import lombok.Data;
import lombok.ToString;
import org.apache.rocketmq.common.message.Message;

/**
 * <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  18-10-30 下午1:08<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
@Data
@ToString
public class ImUserMessage  {

    /**
     * 手机号
     */
    private String phone;

    /**
     * 昵称
     */
    private String nickname;

}
