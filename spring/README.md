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

### 验证

##### @NotBlank
CharSequence子类型 
验证注解的元素值不为空(不为null、去除首位空格后长度为0)，不同于@NotEmpty，@NotBlank只应用于字符串且在比较时会去除字符串的首位空格
##### @Length(min=下限, max=上限)
CharSequence子类型 
验证注解的元素值长度在min和max区间内

##### @NotEmpty
CharSequence子类型、Collection、Map、数组 
验证注解的元素值不为null且不为空(字符串长度不为0、集合大小不为0)

##### @Range(min=最小值, max=最大值)

BigDecimal,BigInteger,CharSequence, byte, short, int, long等原子类型和包装类型

验证注解的元素值在最小值和最大值之间

##### @Email(regexp=正则表达式,

flag=标志的模式)

CharSequence子类型(如String)

验证注解的元素值是Email，也可以通过regexp和flag指定自定义的email格式

##### @Pattern(regexp=正则表达式,

flag=标志的模式)

String，任何CharSequence的子类型

验证注解的元素值与指定的正则表达式匹配

##### @Valid

任何非原子类型

指定递归验证关联的对象；

如用户对象中有个地址对象属性，如果想在验证用户对象时一起验证地址对象的话，在地址对象上加@Valid注解即可级联验证

### RequestBody,RequestParam 混合使用
```java
    public ProcessActionInfo actionProcess(@RequestBody ActionInfo actionInfo, OwnerInfo tmp)
    {
		return null;
	}

```


## 事务
@Transactional

```
/**
 * 自动编号Service业务层处理
 * 
 * @author wb
 * @date 2021-01-09
 */
@Service
public class AutoNumberServiceImpl implements IAutoNumberService 
{
    @Autowired
    private AutoNumberMapper autoNumberMapper;

    @Transactional
    @Override
    public Integer nextNumber(String site, String ownerName, Integer year, Integer month, Integer day,Integer startNewNumber){
        Integer integer = baseNextNumber(site, ownerName, year, month, day, startNewNumber);
        return integer;
    }

    @Transactional
    @Override
    public Integer nextNumber(String site, String ownerName, Integer year, Integer month, Integer day){
        Integer integer = baseNextNumber(site, ownerName, year, month, day, null);
        return integer;
    }



    @Transactional
    public Integer baseNextNumber(String site, String ownerName, Integer year, Integer month, Integer day,Integer startNewNumber){
        Integer startNewNumberTmp=startNewNumber!=null?startNewNumber:1;
        AutoNumber autoNumber ;

        int i = autoNumberMapper.updateAutoNumberCurrentNumber(site, ownerName, year, month, day);
        if(i==1){
            autoNumber = autoNumberMapper.selectAutoNumberByOwner(site, ownerName, year, month, day);
//            return autoNumber.getCurrentNumber();
            throw new MessageVirtualException("");
        }
        autoNumber=new AutoNumber();
        autoNumber.setSite(site);
        autoNumber.setOwnerName(ownerName);
        autoNumber.setYear(year);
        autoNumber.setMonth(month);
        autoNumber.setDay(day);
        autoNumber.setCurrentNumber(startNewNumberTmp);
        BaseEntity.setCreate(autoNumber,TokenUserUtils.getUserName(),DateUtils.getNowDate());
        i = autoNumberMapper.insertAutoNumber(autoNumber);
        if(i==1){
            return startNewNumberTmp;
        }
        throw new MessageVirtualException("保存失败,请重试");
    }

    @Override
    public String formatNextNumberYearMonthDay( String site, String ownerName, int numberOfDigits) {
        return formatNextNumber(DateUtils.getNowDate(),site,ownerName,true,true,true,numberOfDigits);
    }

    public String formatNextNumber(Date date, String site, String ownerName, boolean showYear, boolean showMonth, boolean showDay, int numberOfDigits){
        Calendar cal= Calendar.getInstance();
        cal.setTime(date);
        Integer year=null;
        StringBuilder sb=new StringBuilder();
        if(showYear){
            year= cal.get(Calendar.YEAR);
            sb.append(String.format("%d",year));
        }
        Integer month=null;
        if(showMonth){
            month = cal.get(Calendar.MONTH)+1;
            //不足2位则补零
            sb.append(String.format("%02d",month));
        }
        Integer day=null;
        if(showDay){
            day = cal.get(Calendar.DAY_OF_MONTH);
            //不足2位则补零
            sb.append(String.format("%02d",day));
        }

//        @Resource
//        IAutoNumberService autoNumberService;
        //如果使用方法1
        //autoNumberService.formatNextNumberYearMonthDay,调用没有事务功能
        //autoNumberService.formatNextNumber,调用有事务功能
        //证明事务只支持2层调用,3层调用会失效
        //采用方法2使用代理执行,调用时会有事务功能
//        方法1
//        Integer num = nextNumber(site,ownerName, year, month, day);
//        方法2
        Integer num = ((AutoNumberServiceImpl)AopContext.currentProxy()).nextNumber(site,ownerName, year, month, day);
        sb.append(String.format("%0"+numberOfDigits+"d",num));
        return sb.toString();
    }

}
```


