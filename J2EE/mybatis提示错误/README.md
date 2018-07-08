# mybatis提示错误

## The content of element type "mapper" must match "(cache-ref|cache|resultMap*|parameterMap*|sql*|insert*|update*|delete*|select*)+".

xml 没问题的,内容如下

```Xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- 为这个mapper指定一个唯一的namespace，namespace的值习惯上设置成包名+sql映射文件名，这样就能够保证namespace的值是唯一的
例如namespace="me.gacl.mapping.userMapper"就是me.gacl.mapping(包名)+userMapper(userMapper.xml文件去除后缀)
-->
<mapper namespace="test.spring.maximo.mobileversion.dao.MobileversionDao">
　<!--
　　在select标签中编写查询的SQL语句， 设置select标签的id属性为getUser，id属性值必须是唯一的，不能够重复,
　　使用parameterType属性指明查询时使用的参数类型，resultType属性指明查询返回的结果集类型
　　resultType="com.hua.saf.User"就表示将查询结果封装成一个User类的对象返回,User类就是t_user表所对应的实体类
　　-->
　　<!-- 根据id查询得到一个user对象-->
　　<select id="getUser" resultType="test.spring.maximo.mobileversion.model.Mobileversion" parameterType="int">
　　　　select * from mobileversion where mobileversionid=#{id}
　　</select>
</mapper>
```

就是错误,后来发现是有中文空字符导致的,在mapper下面的注释中出现的.错误文件为 xml/MobileversionMapper_error001.xml 文件

修改后无错误的为 xml/MobileversionMapper001.xml
