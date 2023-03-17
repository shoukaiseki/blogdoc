# maximo登录使用rsa方式加密用户名和密码
以下在maximo7.6中测试通过
## 1.将 jsencrypt.min.js 和 jquery-3.6.1.min.js 复制到 MAXIMO.ear\maximouiweb.war\webclient\javascript

## 2.修改  MAXIMO.ear\maximouiweb.war\webclient\login\login.jsp
添加的代码 start与 添加的代码 end  之间的是添加的代码
此处为原有代码 start 和 此处为原有代码 end 直接的是源代码所在位置,部分代码中存在 ...... 代表源代码


### 此处修改1
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/001.png)
```jsp
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache"); 
```

### 此处修改2
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/002.png)
```jsp
	if (message != null)
	{
		message = WebClientRuntime.removeQuotes(message);
		message = message.replace("\\n"," ");
	}
	if(request.getAttribute("errormsg")!=null&&!request.getAttribute("errormsg").toString().isEmpty()){
		message=request.getAttribute("errormsg").toString();
	}
//HTML 5 doctype 
```
### 此处修改3
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/003.png)
```jsp
<head> 
.......

    <script type="text/javascript" src="<%=basePath%>/webclient/javascript/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/webclient/javascript/jsencrypt.min.js"></script>

</head>

<body <%=(tokenExpire?"":"onload=\"checkForRefresh()\"")%>>
.....
</body>
```
	
	
### 此处修改4
找到登录form表单的位置,将 <form> 中的  action="<%=url%>"  改成 action="<%=path%>/login/rsalogin"

将用户密码输入框绑定的name去掉(提交时不提交输入的用户名和密码),固定input的id绑定


#### 修改前代码
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/004a.png)
```jsp

								<form id="loginform" name="loginform" method="post" action="<%=url%>" onsubmit="loginSetup();" autocomplete="off">
									<input type="hidden" name="allowinsubframe" value="<%=HTML.encode(allowInSubFrame)%>"/>
									<input type="hidden" name="mobile" id="mobile" value="<%=isMobile%>"/>
									<input type="hidden" name="login" id="loginjsp" value="jsp"/>
									<input type="hidden" name="localStorage" id="localStorage" value=""/>
									<input type="hidden" name="loginstamp" id="loginstamp" value="<%=timestamp%>" /><%								if (wcs != null)
								{									
%>									<input type="hidden" name="<%=WebClientSessionManager.CSRFTOKEN%>" id="csrftoken" value="<%=wcs.getCSRFToken()%>" />
<%								}
								if(Integer.parseInt(debug) > 0)
								{
%>									<input type="hidden" name="debug" value="<%=debug%>"/>
<%								}
								%><label for="<%=userFieldName%>" dir="<%=direction%>"><%=labels.username%></label><br />
<%								String attrs = "";
								if(BidiUtils.isBidiEnabled())
								{
									attrs = BidiUtils.buildTagAttribute("",BidiUtils.getMboTextDirection("MAXUSER","LOGINID",true),"",true);
									attrs += "onkeyup='processBidiKeys(null,this)' onfocus='input_bidi_onfocus(null, this)' onblur='input_bidi_onblur(null, this)' onchange='input_bidi_onfocus(null, this)' ";
								}
%>									<input <%=attrs%> style="width:<%=isMobile?145:195%>px" name="<%=userFieldName%>" id="<%=userFieldName%>" langcode="<%=langcode%>" type="text" value="<%=HTML.encode(userName)%>"  onchange="document.getElementById('forgot_<%=userFieldName%>').value = this.value;"/>
									<br /><br />
									<label for="<%=passwordFieldName%>" dir="<%=direction%>"><%=labels.password%></label><br />
									<input style="width:<%=isMobile?145:195%>px" name="<%=passwordFieldName%>" id="<%=passwordFieldName%>" type="password"  value="" autocomplete="off"/>
									<br /><br />
								<%  if(mtEnabled)
									{ %>
									<div id="tenantinfo" style="display:none" aria-hidden="true">
										<label for="<%=tenantFieldName%>"><%=labels.tenantId%></label>
										<br />
									 	<input <%=attrs%> style="width:<%=isMobile?145:195%>px" name="<%=tenantFieldName%>" id="<%=tenantFieldName%>" langcode="<%=langcode%>" type="text" value="<%=HTML.encode(tenant)%>"/>
										<br /><br />
									</div>
								<%	} %>										
									<div style="text-align: <%=reverseAlign%>">
										<button class="tiv_btn" type="submit" id="loginbutton" value="1"><%=labels.loginButton%></button>
									</div>
								</form>
```
#### 修改后代码

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/004b.png)
```jsp
<form id="loginform" name="loginform" method="post" action="<%=path%>/login/rsalogin" onsubmit="loginSetup();">
									<input type="hidden" name="allowinsubframe" value="<%=HTML.encode(allowInSubFrame)%>"/>
									<input type="hidden" name="mobile" id="mobile" value="<%=isMobile%>"/>
									<input type="hidden" name="login" id="loginjsp" value="jsp"/>
									<input type="hidden" name="localStorage" id="localStorage" value=""/>
									<input type="hidden" name="loginstamp" id="loginstamp" value="<%=timestamp%>" /><%								if (wcs != null)
								{									
%>									<input type="hidden" name="<%=WebClientSessionManager.CSRFTOKEN%>" id="csrftoken" value="<%=wcs.getCSRFToken()%>" />
<%								}
								if(Integer.parseInt(debug) > 0)
								{
%>									<input type="hidden" name="debug" value="<%=debug%>"/>
<%								}
								%><label for="<%=userFieldName%>" dir="<%=direction%>"><%=labels.username%></label><br />
<%								String attrs = "";
								if(BidiUtils.isBidiEnabled())
								{
									attrs = BidiUtils.buildTagAttribute("",BidiUtils.getMboTextDirection("MAXUSER","LOGINID",true),"",true);
									attrs += "onkeyup='processBidiKeys(null,this)' onfocus='input_bidi_onfocus(null, this)' onblur='input_bidi_onblur(null, this)' onchange='input_bidi_onfocus(null, this)' ";
								}
%>									<input <%=attrs%> style="width:<%=isMobile?145:195%>px"  id="sourceusername" langcode="<%=langcode%>" type="text"   onchange="document.getElementById('forgot_<%=userFieldName%>').value = this.value;"/>
									<br /><br />
									<label for="<%=passwordFieldName%>" dir="<%=direction%>"><%=labels.password%></label><br />
									<input style="width:<%=isMobile?145:195%>px"  id="sourcepassword" type="password"  value=""/>
									<br /><br />
								<%  if(mtEnabled)
									{ %>
									<div id="tenantinfo" style="display:none" aria-hidden="true">
										<label for="<%=tenantFieldName%>"><%=labels.tenantId%></label>
										<br />
									 	<input <%=attrs%> style="width:<%=isMobile?145:195%>px" name="<%=tenantFieldName%>" id="<%=tenantFieldName%>" langcode="<%=langcode%>" type="text" value="<%=HTML.encode(tenant)%>"/>
										<br /><br />
									</div>
								<%	} %>										
									<div style="text-align: <%=reverseAlign%>">
									    <input type="hidden" name="username" id="username1" value="" />
									    <input type="hidden" name="password" id="password1" value="" />
										<button class="tiv_btn" type="submit" id="loginbutton" value="1"><%=labels.loginButton%></button>
									</div>
								</form>
```

### 此处修改5
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aximo%E7%99%BB%E5%BD%95%E4%BD%BF%E7%94%A8rsa%E6%96%B9%E5%BC%8F%E5%8A%A0%E5%AF%86%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81/image/img/005.png)
```jsp
function loginSetup()
	{
		showWait();
		//此处为添加的代码 start
		console.log("login");
		let pwd=$("#sourcepassword").val();
		let un=$("#sourceusername").val();
		console.log("",pwd);
		if(pwd!= undefined){
		 var pkey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKEnFfgtVH5jR51goNfJ/P+dMVG4vZfmPU+RJ/xRfSfnwANHAmYHTF7DRlPekQIyQEdoaaVzw2rjErA59tilvhMCAwEAAQ==";//可以到 https://uutool.cn/rsa-generate/ 网站生成 公钥和私钥,
          var encrypt = new JSEncrypt();
          encrypt.setPublicKey(pkey);
          var encPassword = encrypt.encrypt(pwd);
          var encUsername = encrypt.encrypt(un);
          console.log("encUsername=" + encUsername);
          console.log("encPassword=" + encPassword);
		  $("#username1").attr("value",encUsername);
		  $("#password1").attr("value",encPassword);
		}else{
		  $("#username1").attr("value","");
		  $("#password1").attr("value","");
		}
		//此处为添加的代码 end
<%		if (s.isConnected())
		{
%>			hiddenFrame = parent.document.getElementById("commframe");
			if (hiddenFrame != null)
			{
				var debugwindow = parent.document.getElementById("dockedHiddenFrame");
				debugwindow.style.width=50 + "px";
				debugwindow.style.height=50 + "px";
				hiddenFrame.style.width=50 + "px";
				hiddenFrame.style.height=50 + "px";
				debugwindow.style.visibility="hidden";
				hiddenFrame.style.display="none";
				parent.showWait();
			}
<%		}
%>	}
```
    

### 还有很多修改过的地方,比如资源文件url路径,和action表单提交路径
login_new.jsp 为修改后的文件
login_old.jsp 为修改前的文件

在 login_new.jsp 中 搜索 basePath 和 submitUrl,修改的一些信息,和改法




## 3.修改 web.xml
D:\IBM\WebSphere\AppServer\profiles\ctgAppSrv01\installedApps\ctgCell01\MAXIMO.ear\maximouiweb.war\WEB-INF\web.xml
D:\IBM\WebSphere\AppServer\profiles\ctgAppSrv01\config\cells\ctgCell01\applications\MAXIMO.ear\deployments\MAXIMO\maximouiweb.war\WEB-INF\web.xml
D:\IBM\WebSphere\AppServer\profiles\ctgDmgr01\config\cells\ctgCell01\applications\MAXIMO.ear\deployments\MAXIMO\maximouiweb.war\WEB-INF\web.xml


```xml
	<!-- Uncomment this line for Cross Site Scripting Problem -->
	<filter>
          <filter-name>HttpCrossSiteScriptingSecurity</filter-name>
          <filter-class>psdi.webclient.system.filter.HttpCrossSiteScriptingSecurity</filter-class>
                           <init-param>
                              <param-name>script</param-name>
                              <param-value>script</param-value>
                          </init-param>

      </filter>
```
	在此处后面添加
```xml
	<!-- rsalogin  Start -->
	<filter>
		<filter-name>rsalogin</filter-name>
		<filter-class>org.shoukaiseki.webclient.login.LoginFilter</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>rsalogin</filter-name>
		<url-pattern>/rsalogin/login.jsp</url-pattern>
	</filter-mapping>
    <!-- rsalogin End -->
	
	
	<!-- rsalogin  Start -->
	<!--<filter>
		<filter-name>rsalogin</filter-name>
		<filter-class>org.shoukaiseki.webclient.login.LoginFilter</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>rsalogin</filter-name>
		<url-pattern>/rsalogin/login.jsp</url-pattern>
	</filter-mapping>-->
    <!-- rsalogin End -->
```


# java代码3个类
JsEncryptUtil.java Base64.java  和 LoginFilter.java
编译后放到 maximouiweb.war\WEB-INF\classes 下面即可
