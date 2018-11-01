package com.hkedou.messagequeue.mq.im.api.config;

import org.springframework.boot.context.properties.ConfigurationProperties;


/**
 * com.hkedou.messagequeue.mq.im.api.MQImUserCreateProperties <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2018-10-30 13:58:03<br>
 * ブログ http://www.shoukaiseki.top/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/

@ConfigurationProperties(prefix = "hkedou.mq.im.group.user.create",ignoreUnknownFields = true)
public class MQImUserCreateProperties {

    private String topic;

    private String consumerGroup;

    private Long pullInterval=3000L;

    /**
     * 每次拉取数量,每次拉取后分N个线程取处理
     */
    private Integer pullBatchSize=50;

    /**
     * 每个线程的最大每次消费条数
     */
    private Integer consumeMessageBatchMaxSize=50;

    public Integer getConsumeMessageBatchMaxSize() {
        return consumeMessageBatchMaxSize;
    }

    public void setConsumeMessageBatchMaxSize(Integer consumeMessageBatchMaxSize) {
        this.consumeMessageBatchMaxSize = consumeMessageBatchMaxSize;
    }

    public Long getPullInterval() {
        return pullInterval;
    }

    public void setPullInterval(Long pullInterval) {
        this.pullInterval = pullInterval;
    }

    public Integer getPullBatchSize() {
        return pullBatchSize;
    }

    public void setPullBatchSize(Integer pullBatchSize) {
        this.pullBatchSize = pullBatchSize;
    }

    public String getConsumerGroup() {
        return consumerGroup;
    }

    public void setConsumerGroup(String consumerGroup) {
        this.consumerGroup = consumerGroup;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }
}
