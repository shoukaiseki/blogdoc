# java后台

## 反射工具类
ReflectUtils
## UserDetailsService接口实现类
com.ruoyi.framework.web.service.UserDetailsServiceImpl

## 读取资源文件
```
URL url = ClassUtils.getDefaultClassLoader().getResource("sensi_words.txt");



ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
Resource[] resources =resolver.getResources("classpath:sensi_words.txt");
for (Resource resource : resources) {
	byte[] bytes = FileCopyUtils.copyToByteArray(resource.getInputStream());
	String string = new String(bytes,"UTF-8");
	String filename = resource.getFilename();
	logger.debug(string);
	logger.debug(filename);
}

```

## 泛型
```
public class CompanyServiceImpl<T> implements ICompanyService<T>
    @Override
    public  <T>  List<Company> selectCompanyInfoList(final List<? extends T> list, Function<? super T, Long> companyIdFun, CompanyFunction<T> biFunction){
        MultiValueMap<Long, T> idMap = new LinkedMultiValueMap<Long, T>();
        for (T t : list) {
            Long fieldValue=companyIdFun.apply((T)t);
            if(fieldValue!=null&&!Objects.equals(0L,fieldValue)){
                idMap.add(fieldValue,t);
            }

        }
        List<Company> companyList = companyMapper.selectCompanyByIdList(idMap.keySet().toArray(new Long[0]));
        if(biFunction!=null){
            companyList.forEach(company -> {
                List<T> objects = idMap.get(company.getCompanyId());
                if (objects!=null) {
                    objects.forEach((obj)-> {
                        biFunction.apply(obj, company);
                    });
                }
            });
        }
        return companyList;
    }


        List<SysUser> sysUserList = Lists.newArrayList();
//其它类中调用必须设置泛型,否则编译失败
        ((ICompanyService<SysUser>)companyService).selectCompanyInfoList(sysUserList, SysUser::getCompanyId,(sysUser, company) -> {
            System.out.println(company.getCompanyId());
            System.out.println(company.getCompanyName());
            System.out.println(sysUser.getNickName());
        });

//或者功能接口设置泛型传入的类型
        companyService.selectCompanyInfoList(sysUserList,(Function<SysUser,Long>) SysUser::getUserId,(CompanyFunction<SysUser>)(sysUser,company)->{
            System.out.println(company.getCompanyId());
            System.out.println(company.getCompanyName());
            System.out.println(sysUser.getNickName());
        });


```


### key多个值
```java
    public static void test002() {
        // Creating an empty IdentityHashMap
        MultiValueMap<String, Integer> multiValueMap = new LinkedMultiValueMap<String, Integer>();

        // Mapping int values to string keys
        multiValueMap.add("Geeks", 10);
        multiValueMap.add("4", 15);
        multiValueMap.add("Welcomes", 25);
        multiValueMap.add("You", 30);
        multiValueMap.add("Geeks", 20);

        // Displaying the IdentityHashMap
        System.out.println("Initial Mappings are: " +
                multiValueMap);

        // Getting the value of "Geeks"
        System.out.println("The Value is: " +
                multiValueMap.get("Geeks"));

        // Getting the value of "You"
        System.out.println("The Value is: " +
                multiValueMap.get("You"));
    }
```
