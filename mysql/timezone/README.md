# timezone

mybatis插入会按照时区进行调整后插入数据，而 jackson.time-zone: GMT+8 会按照读取时候进行格式化显示，而datagrip等数据库管理工具基本插入/修改/查询时候不会进行时区转换，处理的都是数据库实际存储的数据

所以 serverTimezone 设置在mybatis是插入生效的，设置错误会导致insert时候的值与datagrip查询出来不同


```
# mysql安装在linux系统
serverTimezone=UTC 
# mysql安装在时区为+8区的win系统
serverTimezone=GMT%2B8
```

serverTimezone设置不正确虽然在前端看到的和新增/修改的时间一致，但是在使用 between 等查询时就会发现查询出来数据不对
```Sql
-- 前端字符串传递过来的时间进行查询会出现错误
create_time between CONCAT(#{beginCreateTime},' 00:00:00') and CONCAT(#{endCreateTime},' 23:59:59')
-- 或者
create_time between '2020-11-19 00:00:00' and '2020-11-19 23:59:59'
```

除非使用jdbc中的Timestap参数进行查询，虽然未测试改方案，但是可行性很高，不过得修改好多东西，所以就没有测试
```Sql
create_time between ? and ?
```

## mybatis中设置的serverTimezone=UTC为数据库服务器的时间
数据库服务器为linux情况下，基本都是用 serverTimezone=UTC 

而如果你的mysql是在windows运行的，那么必须按照数据库服务器所在的时区格式进行设置，国内基本使用 serverTimezone=GMT%2B8 也就是+8区，实际自行查看

```
serverTimezone=GMT%2B8
```
### 注意
windows是设值UTC存在一定误区,网上说的修改注册表（方法如下），只是使用硬件UTC计时方式,时区还是需要手动去修改时区为  （UTC)+00:00圣多美 

而修改时候服务器时间就会变成少了8小时,那是UTC标准时间，你不能去调整这个时间,只能习惯这个时间，时间不一致会导致一定的问题
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]

"RealTimeIsUniversal"=dword:00000001
```

my.ini
```ini
[mysql]
 
# 设置mysql客户端默认字符集
 
default-character-set=utf8
 
[mysqld]
 
# 设置3306端口
 
port=3306
 
# 设置mysql的安装目录
 
basedir=D:\usr\mysql-8.0.21-winx64\
 
# 设置mysql数据库的数据的存放目录
 
datadir=D:\usr\mysql-8.0.21-winx64\data
 
# 允许最大连接数
 
max_connections=200
 
# 服务端使用的字符集默认为8比特编码的latin1字符集
 
character-set-server=utf8
 
# 创建新表时将使用的默认存储引擎
 
default-storage-engine=INNODB

default-time-zone='+08:00'
```

## mybatis在插入时间时会使用对比springboot运行的服务器时间与数据库时间，进行时间差转换
原理是mybatis会将Date转换为Timestamp进行设置值，而Timestamp是存在时区转换的







```
-Duser.timezone=Asia/Shanghai
```


## springboot
thymeleaf 中的 th:value="${#dates.format(testTime, 'yyyy-MM-dd HH:mm:ss')}"  是按照系统时区进行格式化的

而jackson是按照配置的 spring.jackson.time-zone: GMT+8 进行格式化的

### TestController 代码
```Java
package com.ruoyi.project.wzcxs.test;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 *
 **/
@Controller("TestControllerTest001")
@RequestMapping("/wzcxs/test")
public class TestController {

    private String prefix = "wzcxs/test";

    @GetMapping("/test001")
    public String test001(ModelMap mmap)
    {
//        Dates dates=new Dates();
        Date testTime = new Date();
        mmap.put("testTime", testTime);
//        String format = dates.format(testTime, "yyyy-MM-dd HH:mm:ss");
//        mmap.put("testTimeFormat", format);

        Calendar cal = Calendar.getInstance();
        int offset = cal.get(Calendar.ZONE_OFFSET);
        cal.add(Calendar.MILLISECOND, -offset);
        Long timeStampUTC = cal.getTimeInMillis();
        Long timeStamp = System.currentTimeMillis();
        Long timeZoneLong = (timeStamp - timeStampUTC) / (1000 * 3600);
        System.out.println(timeZoneLong.intValue());

        TimeZone defaultTimeZone = TimeZone.getDefault();

        StringBuffer sb= new StringBuffer("timeZone="+timeZoneLong.intValue() +",defaultTimeZone="+defaultTimeZone.getID());


        TimeZone timeZone = TimeZone.getDefault();
        String pattern="yyyy-MM-dd HH:mm:ss";

        Calendar c = Calendar.getInstance(timeZone);
        c.setTime(testTime);

        Locale locale=Locale.getDefault();
        SimpleDateFormat sdf = new SimpleDateFormat(pattern, locale);
        sdf.setTimeZone(timeZone);
        sb.append("\n");
        sb.append("timeZone.id=").append(timeZone.getID());
        sb.append(",timeZone.time=").append(sdf.format(c.getTime()));
        System.out.println(timeZone.getID());
        System.out.println(sdf.format(c.getTime()));


        timeZone=TimeZone.getTimeZone("+01:00");
        sdf.setTimeZone(timeZone);
        sb.append("\n");
        sb.append("timeZone.id=").append(timeZone.getID());
        sb.append(",timeZone.time=").append(sdf.format(c.getTime()));
        System.out.println(timeZone.getID());
        System.out.println(sdf.format(c.getTime()));


        timeZone=TimeZone.getTimeZone("Asia/Tokyo");
        sdf.setTimeZone(timeZone);
        sb.append("\n");
        sb.append("timeZone.id=").append(timeZone.getID());
        sb.append(",timeZone.time=").append(sdf.format(c.getTime()));
        System.out.println(timeZone.getID());
        System.out.println(sdf.format(c.getTime()));

        mmap.put("str", sb.toString());
        return prefix + "/test001";
    }

}
```

test001.html代码
```html
<!DOCTYPE html>
<html lang="zh" xmlns:th="http://www.thymeleaf.org" >
<head>
    <th:block th:include="include :: header('测试')" />
    <th:block th:include="include :: datetimepicker-css" />
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content animated fadeInRight ibox-content">
        <form class="form-horizontal m" id="form-test" >
            <div class="form-group">
                <label class="col-sm-3 control-label">时间：</label>
                <div class="col-sm-8">
                    <div class="input-group date">
                        <input id="contractTime" name="contractTime" th:value="${#dates.format(testTime, 'yyyy-MM-dd HH:mm:ss')}" class="form-control"  type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">CET：</label>
                <div class="col-sm-8">
                    <div class="input-group date">
                        <input id="contractTime02" name="contractTime" th:value="${#dates.format(#calendars.createForTimeZone(#calendars.year(testTime), #calendars.month(testTime), #calendars.day(testTime), #calendars.hour(testTime), #calendars.minute(testTime),'CET'), 'yyyy-MM-dd HH:mm:ss')}" class="form-control"  type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">PST：</label>
                <div class="col-sm-8">
                    <div class="input-group date">
                        <input id="contractTime03" name="contractTime" th:value="${#dates.format(#calendars.createForTimeZone(#calendars.year(testTime), #calendars.month(testTime), #calendars.day(testTime), #calendars.hour(testTime), #calendars.minute(testTime),'PST'), 'yyyy-MM-dd HH:mm:ss')}" class="form-control"  type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">GMT：</label>
                <div class="col-sm-8">
                    <div class="input-group date">
                        <input id="contractTime04" name="contractTime" th:value="${#dates.format(#calendars.createForTimeZone(#calendars.year(testTime), #calendars.month(testTime), #calendars.day(testTime), #calendars.hour(testTime), #calendars.minute(testTime),'GMT'), 'yyyy-MM-dd HH:mm:ss')}" class="form-control"  type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">GMT+8：</label>
                <div class="col-sm-8">
                    <div class="input-group date">
                        <input id="contractTime05" name="contractTime" th:value="${#dates.format(#calendars.createForTimeZone(#calendars.year(testTime), #calendars.month(testTime), #calendars.day(testTime), #calendars.hour(testTime), #calendars.minute(testTime),'GMT+8'), 'yyyy-MM-dd HH:mm:ss')}" class="form-control"  type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">str：</label>
                <div class="col-sm-8">
                    <textarea rows="10" name="str" th:text="${str}" class="form-control" type="text" />
                </div>
            </div>
        </form>
    </div>
    <th:block th:include="include :: footer" />
    <th:block th:include="include :: datetimepicker-js" />
    <script th:inline="javascript">
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            laydate.render({
                elem: '#contractTime',
                type: 'datetime',
                trigger: 'click'
            });
        });
    </script>
</body>
</html>
```


