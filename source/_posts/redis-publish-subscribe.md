---
title: redis 消息的订阅发布 Java 实现 消息生产者 消息消费者
post_url: redis-publish-subscribe
date: 2019-03-22 17:28:33
tags: redis
---

系统的一个简单的边缘功能要用消息系统，不值得再接入各种 mq，redis 也可以实现消息的发布订阅  

## 发布消息（消息生产者 MessageProducer）
```Java
public static final String CHANNEL_KEY = "channel:1";
jedis.publish(CHANNEL_KEY, message);
```

## 订阅消息（消息消费者）
```Java
/**
 * 消息消费者
 *
 * @author hxx
 */
public class MessageConsumer implements Runnable {
 
    /**
     * 频道
     */
    public static final String CHANNEL_KEY = "channel:1";
 
    /**
     * 处理接收消息
     */
    private AlarmJedisPubSub alarmJedisPubSub = new AlarmJedisPubSub();
 
    /**
     * Logger
     */
    private static Logger LOG = LoggerFactory.getLogger(MessageConsumer.class);
 
    @Override
    public void run() {
        Jedis jedis = null;
        try {
            jedis = JedisPoolUtils.getPublicJedis();
            jedis.subscribe(alarmJedisPubSub, CHANNEL_KEY);
        }
        catch (Exception e) {
            LOG.error("消费消息失败：" + e.getMessage(), e);
        }
        finally {
            JedisPoolUtils.returnRes(jedis);
        }
    }
 
    /**
     * 接收到消息后推给前端
     *
     * @author ab
     */
    class AlarmJedisPubSub extends JedisPubSub {
        @Override
        public void onMessage(String channel, String message) {
            LOG.info("接收到来自频道" + channel + "的消息：" + message);
            ResinWebSocketListener.sendToOneUser(JSON.parseObject(message), message, "msg");
        }
    }
 
    /**
     * 测试
     *
     * @param args args
     */
    public static void main(String[] args) {
        MessageConsumer messageConsumer = new MessageConsumer();
        Thread t1 = new Thread(messageConsumer);
        t1.start();
    }
}
```

参考：https://www.cnblogs.com/qlqwjy/p/9763754.html