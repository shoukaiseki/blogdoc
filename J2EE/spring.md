# spring

## MessageSource国际化

不会扫描其它包中的国际化资源文件

## 参数验证
### service中参数验证
在service的class注解上添加@Validated，然后在接口入参上添加@Valid 注解。

```java
@Service
@Validated
@Slf4j
public class MessageService {

    @Autowired
    private MessageDao messageDao;
    /**
     * 消息发布
     * @param bean
     * @return
     */
    public DataResult sendMessage(@Valid MessageDTO bean) {
        DataResult result =  new DataResult();
        try {
            messageDao.sendMessage(bean);
            result.setSuccess(true);
            result.setMsg("消息发布成功");
        } catch (Exception e) {
            String trace = "消息发布失败："+e.getMessage();
            log.error(trace,e);
            result.setSuccess(false);
            result.setMsg("消息发布失败");
        }
        return result;
    }
}
```
