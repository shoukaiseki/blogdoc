# spring


## 类型转换
#### 转数字类型
```
        Long l=org.springframework.util.NumberUtils.parseNumber("1000", Long.class);
```

## MessageSource国际化

不会扫描其它包中的国际化资源文件

## 参数验证
@Validated：可以用在类型、方法和方法参数上。但是不能用在成员属性（字段）上
@Valid：可以用在方法、构造函数、方法参数和成员属性（字段）上
### service中参数验证
在service的class注解上添加@Validated，然后在接口入参上添加@Valid 注解。


service 加注解即可, impl实现类加不加无所谓
```java
@Validated
public interface IProcessActionService {

    public void nextProcess(@Valid OwnerInfo ownerInfo);
}
```

```java

@Service
public class ProcessActionServiceImpl implements IProcessActionService {

    @Override
    public void nextProcess(OwnerInfo ownerInfo) {
	}
	
}
```
