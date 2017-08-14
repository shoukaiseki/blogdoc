# MAXIMO客户机与服务器不同语言环境导致数据库配置保存错误  

检查你要保存的表属性中 DEFAULTVALUE( 缺省值)的值是否有存在 &DATETIME& 之类的,因为不同语言环境只检查以下设置

```
&AUTOKEY& &SYSDATE& &USERNAME& &APPNAME& &MBONAME& &OWNERNAME& &PERSONID& &SEQUENCE& 
```

除此之外的不同语言环境下就会出现保存错误


而处理方式可以是在psdi.app.configure.MaxAttributeCfg类里面的 getMboValueData(String attribute)方法中修改
<br />
修改后的信息如下:

```Java
 MboValueData mvd = super.getMboValueData(attribute);
        if(!firstDefaultvalueGet || toBeAdded() || !attribute.toUpperCase().equals("DEFAULTVALUE"))
            return mvd;
        String rawValue = mvd.getDataAsObject().toString();
        Locale systemLocale = MXServer.getMXServer().getSystemUserInfo().getLocale();
        TimeZone systemTimeZone = MXServer.getMXServer().getSystemUserInfo().getTimeZone();
        Locale userLocale = getUserInfo().getLocale();
        TimeZone userTimeZone = getUserInfo().getTimeZone();
        String userValue = null;
        if(rawValue.equals("&DATETIME&")
                ||rawValue.equals("&DATETIME&")
                ){
            userValue=rawValue;
        }else{
            userValue=((ConfigureService)getMboServer()).convertToLocale(rawValue, getString("maxtype"),
            systemLocale, systemTimeZone, userLocale, userTimeZone);
        }
```
原方法里是在 psdi.app.configure.ConfigureService 类里的 convertToLocale方法里面做的判断,而我是提前做了判断,效果是一样的

原来的判断代码如下所示:

```Java
public String convertToLocale(String inputValue, String maxtype, Locale fromLocale, TimeZone fromTimeZone, 
 Locale toLocale, TimeZone toTimeZone)
        throws MXException, RemoteException
    {
        if(inputValue == null || inputValue.equals(""))
            return inputValue;
        if(maxtype.equals("ALN") || maxtype.equals("UPPER") || maxtype.equals("LOWER") ||
        maxtype.equals("CLOB") || maxtype.equals("BLOB") || maxtype.equals("CRYPTO") || 
        maxtype.equals("CRYPTOX") || maxtype.equals("YORN") || maxtype.equals("GL") || 
        maxtype.equals("LONGALN"))
            return inputValue;
        if(fromLocale.equals(toLocale))
            return inputValue;
        if(inputValue.equals("&AUTOKEY&") || inputValue.equals("&SYSDATE&") || inputValue.equals("&USERNAME&")
        || inputValue.equals("&APPNAME&") || inputValue.equals("&MBONAME&") || inputValue.equals("&OWNERNAME&")
        || inputValue.equals("&PERSONID&") || inputValue.equals("&SEQUENCE&"))
            return inputValue;
```

 这个原因是因为不同的功能模块由不同人员开发导致的,开发团队内部人员未及时沟通吧
