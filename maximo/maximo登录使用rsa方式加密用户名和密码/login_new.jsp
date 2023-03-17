<%--
* Licensed Materials - Property of IBM
* 
* 5724-U18
* 
* (C) COPYRIGHT IBM CORP. 2006,2017 All Rights Reserved.
* 
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with
* IBM Corp.
--%><%@ page contentType="text/html;charset=UTF-8" buffer="128kb" autoFlush="true" import="psdi.util.*,psdi.webclient.system.runtime.*,psdi.webclient.system.session.*,psdi.webclient.system.websession.*,psdi.webclient.system.dojo.*,psdi.server.*,java.util.*,java.rmi.RemoteException" %><%!
private static class Labels
{
	private static final String group = "login";
	
	final String welcome;
	final String welcomeToMaximo;
	final String enterInfo;
	final String username;
	final String password;
	final String loginButton;
	final String selectLanguage;
	final String onLanguageSelection;
	final String forgotPassword;
	final String newUserLabel;
	final String newUserLink;
	final String mobileLoginLink;
	final String standardLoginLink;
	final String adminLoginLink;
	final String copyright;
	final String tenantId;
	final String federalNotice;
	final String nonFederalNotice;

	Labels(String langCode) throws MXException, RemoteException
	{
		MXServer server = MXServer.getMXServer();

		welcome = server.getMessage(group, "welcome", langCode);
		welcomeToMaximo = server.getMessage(group, "welcomemaximomessage", langCode);
		enterInfo = server.getMessage(group, "enterinfo", langCode);
		username = server.getMessage(group, "username", langCode);
		password = server.getMessage(group, "password", langCode);
		loginButton = server.getMessage(group, "loginbutton", langCode);
		selectLanguage = server.getMessage(group, "languages", langCode);
		onLanguageSelection = server.getMessage(group, "onlanguageselection", langCode);
		forgotPassword = server.getMessage(group, "forgotpassword", langCode);
		newUserLabel = server.getMessage(group, "newuserlabel", langCode);
		newUserLink = server.getMessage(group, "newuserlink", langCode);
		mobileLoginLink = server.getMessage(group, "mobileloginlink", langCode);
		standardLoginLink= server.getMessage(group, "standardloginlink", langCode);
		copyright = server.getMessage(group, "copyright2017", langCode);
		tenantId  = server.getMessage(group,"tenant",langCode);
		federalNotice = server.getMessage(group, "federalNotice", langCode);
		nonFederalNotice = server.getMessage(group, "nonFederalNotice", langCode);
		adminLoginLink = server.getMessage(group, "adminLogin", langCode);
	}
}
%><%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String submitUrl=basePath+"ui/login";
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache");

	WebClientSessionManager wcsm = WebClientSessionManager.getWebClientSessionManager(session);
	if (wcsm != null && wcsm.getSessionInvalidated())
	{
		session.removeAttribute("MXSession");
	}

	MXSession s = WebClientRuntime.getMXSession(session);
	String skin = WebClientRuntime.getWebClientSystemProperty("mxe.webclient.skin");
	String isFederal = WebClientRuntime.getWebClientSystemProperty("mxe.isFederal", "0");
	String isSaasEnabled = WebClientRuntime.getWebClientSystemProperty("mxe.isSaasEnabled", "0");
	
	boolean mtEnabled = WebClientRuntime.isMTEnabled();
	
	if(skin==null || skin.length()==0) {
		skin="classic";
	}
	if (!WebClientSessionFactory.getWebClientSessionFactory().hasAvailableSessions())
	{
		String url = new java.net.URL(new java.net.URL(WebClientRuntime.getMaximoRequestURL(request)), "loginerror.jsp").toString() + "?unavailable=true";
		if (!WebClientRuntime.send503Error(response, s, url))
		{
			response.sendRedirect(url);
		}
		return;
	}

	s.setClientHost(request.getRemoteHost());
	s.setClientAddr(request.getRemoteAddr());

	Object[] settings = WebClientRuntime.getLocaleFromRequest(request);
	String langcode;
	if (settings[0] instanceof String)
	{
		langcode = (String)settings[0];
	}
	else
	{
		langcode = MXServer.getMXServer().getBaseLang();
	}
	Map<String,String> langNameToCodeMap = null;
	String[][] langs = s.getLanguageList();
	if(langs != null)
	{
		if(langs.length == 1)
		{
			langcode = langs[0][0];
		}
		else if(langs.length > 1)
		{
			langNameToCodeMap = new HashMap<String,String>();
			for(int i = 0; i < langs.length; i++)
			{
				langNameToCodeMap.put(langs[i][1], langs[i][0]);
			}
		}
	}
	s.setLangCode(langcode);
	session.setAttribute("langcode", langcode);

	Locale locale = null;
	if (settings[1] instanceof Locale)
	{
		locale = (Locale)settings[1];
		session.setAttribute("_locale_", locale);
	}
	if (locale != null)
	{
		session.removeAttribute("locale");
		s.setLocale(locale);
	}

	if (request.getParameter("langchanged") != null)
	{
		session.setAttribute("_langchanged", "1");
	}

	boolean isMobile = false;

	boolean everyplace = WebClientRuntime.getWebClientRuntime().hasLicenseAccess("EVERYPLACE");
	if(everyplace)
	{
		String mobile = request.getParameter("mobile");
		if(WebClientRuntime.isNull(mobile))
		{
			String userAgent = request.getHeader("User-Agent").toUpperCase();
			if(userAgent.contains("MOBILE") || userAgent.contains("IPHONE") || userAgent.contains("IPOD") || userAgent.contains("PLAYBOOK") || userAgent.contains("ANDROID"))
			{
				isMobile = true;
			}
		}
		else if(mobile.equals("true"))
		{
			isMobile = true;
		}
		if(isMobile) {
			skin = "mobile";
		}
	}
	request.setCharacterEncoding("UTF-8");

	String debug = request.getParameter("debug");
	if(debug == null || debug.length() == 0)
	{
		debug = "0";
	}

	boolean formAuth = request.getParameter("appservauth") != null;
	String allowInSubFrame = request.getParameter("allowinsubframe");
	if (formAuth)
	{
		session.setAttribute("formAuth", "true");
	}
	String url = "../../ui/login";

	String queryString = request.getQueryString();
	if(queryString != null)
	{
		url += "?" + HTML.encode(queryString);
	}
	int branding = s.getBranding();
	if(branding == MXServerRemote.BRAND_NONE)
	{
		branding = MXServerRemote.BRAND_MAXIMO_AND_TIVOLI;
	}
	WebClientSession wcs = null;
	if(wcsm != null)
	{
		wcs = wcsm.getWebClientSession(request);
		if(wcs != null)
		{
			if(wcs.usingContextInterval())
			{
				s.disconnect();
			}
		}
	}
	if(s.isConnected() && s.getUserName().equalsIgnoreCase(s.getProperty("mxe.system.reguser")))
	{
		s.disconnect();
	}
	if(!formAuth && (WebAppEnv.useAppServerSecurity() || s.isConnected()))
	{
		response.sendRedirect(url);
		return;
	}

	String userFieldName = "username";
	String passwordFieldName = "password";
	String tenantFieldName = "tenant";
	boolean tokenExpire = false;
	if(WebAppEnv.useAppServerSecurity())
	{
		userFieldName = "j_" + userFieldName;
		passwordFieldName = "j_" + passwordFieldName;
		if (WebClientRuntime.isRunningInWebLogic())
		{
			url="j_security_check";
		}
		else
		{
			url="../../j_security_check";
		}

		if (s.isConnected()) // This is possible cause for Appserver token expiry
		{
			tokenExpire = true;
		}
	}

	String userName = request.getParameter("username");
	if(userName == null)
	{
		userName = "";
	}

	
	String tenant = request.getParameter(tenantFieldName);
	if(tenant == null)
	{
		tenant = "";
	}
	
	Labels labels = new Labels(langcode);

	String reverseAlign = "right";
	String direction = "ltr";
	if(BidiUtils.isGUIMirrored(langcode))
	{
		reverseAlign = "left";
		direction = "rtl";
	}

	String timestamp = Long.toString(System.currentTimeMillis());
	session.setAttribute("allowlogin", timestamp);

	String message;
	MXException loginException = (MXException)session.getAttribute("loginexception");
	if (loginException != null)
	{
		//Issue 10-12120
		message = s.getTaggedMessage(loginException);
		message = WebClientRuntime.replaceString(message,"\"","\\\"");
		session.removeAttribute("loginexception");
	}
	else
	{
		message = (String)request.getAttribute("signoutmessage");
		if (message == null)
		{
			message = (String)session.getAttribute("signoutmessage");
			if (message != null)
			{
				session.removeAttribute("signoutmessage");
			}
		}
		else
		{
			request.removeAttribute("signoutmessage");
		}
	}
	if (message != null)
	{
		message = WebClientRuntime.removeQuotes(message);
		message = message.replace("\\n"," ");
	}
	if(request.getAttribute("errormsg")!=null&&!request.getAttribute("errormsg").toString().isEmpty()){
		message=request.getAttribute("errormsg").toString();
	}
//HTML 5 doctype 
%><!DOCTYPE html>
<html lang="<%=langcode.toLowerCase()%>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>	
	<meta name="viewport" content="width=320, initial-scale=1.0" />
	<meta name="format-detection" content="telephone=no" />

	<link rel="apple-touch-icon" href="../images/maximo-icon.png"/>
	<link rel="shortcut icon" href="../images/maximo-icon.ico"/>
<%	if(branding == MXServerRemote.BRAND_MAXIMO || branding == MXServerRemote.BRAND_MAXIMO_AND_TIVOLI)
	{
%>	<title><%=labels.welcomeToMaximo%></title>
<%	}
	else
	{
%>	<title><%=labels.welcome%></title>
<%	}
%>	<link href="<%=basePath%>/webclient/login/css/login.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>/webclient/login/css/<%=skin%>/login.css" rel="stylesheet" type="text/css" />
<%	if(isMobile)
	{
%>	<link href="<%=basePath%>/webclient/login/css/mobilelogin.css" rel="stylesheet" type="text/css" />
<%	}
	if(direction.equals("rtl"))
	{
%>	<link href="<%=basePath%>/webclient/login/css/RTLlogin.css" rel="stylesheet" type="text/css" />
<%	}
%>
    <script type="text/javascript" src="<%=basePath%>/webclient/javascript/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/webclient/javascript/jsencrypt.min.js"></script>
</head>

<body <%=(tokenExpire?"":"onload=\"checkForRefresh()\"")%>>
	<div role="main">
		<table id="main_tbl" class="main_tbl" cellpadding="0" cellspacing="3" role="presentation">
			<tr role="banner">
				<td>
<%					//Branding image
					if(branding == MXServerRemote.BRAND_TIVOLI || branding == MXServerRemote.BRAND_MAXIMO_AND_TIVOLI)
					{
%>					<img class="defaultbrandinglogo" src="<%=basePath%>/webclient/login/images/tivoli_brandmark.png" alt="Tivoli" />
<%					}
%>				</td>
				<td align="<%=reverseAlign%>">
					<img class="defaultibmlogo" src="<%=basePath%>/webclient/login/images/ibm-logo-white.gif" alt="IBM" />
				</td>
			</tr>
			<tr>
				<td class="dialog" colspan="2">
<%			if(branding == MXServerRemote.BRAND_MAXIMO || branding == MXServerRemote.BRAND_MAXIMO_AND_TIVOLI)
			{
				//  Welcome to MAXIMO
%>				<h1 class="prod_name"><%=labels.welcomeToMaximo%></h1>
<%			}
			else
			{
				// Welcome,
%>				<h1 class="prod_name"><%=labels.welcome%></h1>
<%			}
			if(!isMobile && message != null)
			{
%>				<div class="errorText">
					<img id="error_img" src="<%=basePath%>/webclient/login/images/st16_critical_24.png" alt="Error" align="absmiddle"/>
					<%=message%>
				</div>
<%			}
%>				<table cellpadding="0" cellspacing="0" role="presentation">
						<tr>
							<td colspan="5" align="<%=reverseAlign%>">
							<%	if(branding == MXServerRemote.BRAND_MAXIMO || branding == MXServerRemote.BRAND_MAXIMO_AND_TIVOLI)
								{
									//  Welcome to MAXIMO
					%>				<h1 class="prod_name ext_prod_name" style="display:none"><%=labels.welcomeToMaximo%></h1>
					<%			}
								else
								{
									// Welcome,
					%>				<h1 class="prod_name ext_prod_name" style="display:none"><%=labels.welcome%></h1>
					<%			} %>
							</td>
						</tr>
						<tr>
							<td valign="top"><img src="<%=basePath%>/webclient/login/images/mx_icon<%=isMobile?"_ev":""%>.png" alt="" /></td>
							<td class="input_pad">
								<form id="loginform" name="loginform" method="post" action="<%=path%>/login/rsalogin" onsubmit="loginSetup();" autocomplete="off">
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
%>									<input <%=attrs%> style="width:<%=isMobile?145:195%>px" id="sourceusername" langcode="<%=langcode%>" type="text"   onchange="document.getElementById('forgot_<%=userFieldName%>').value = this.value;"/>
									<br /><br />
									<label for="<%=passwordFieldName%>" dir="<%=direction%>"><%=labels.password%></label><br />
									<input style="width:<%=isMobile?145:195%>px" id="sourcepassword" type="password"  value="" autocomplete="off"/>
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
							</td>
						</tr>
<%
					if ("1".equals(s.getProperty(WebClientConstants.WEBCLIENT_GUEST_LOGIN)) && !mtEnabled)          
					{
						String guestLoginLabel = MXServer.getMXServer().getMessage("login", "guestloginlabel", langcode);
						String guestLoginURL = s.getProperty(WebClientConstants.WEBCLIENT_GUEST_LOGIN_URL);
%>
						<tr>
							<td align="<%=reverseAlign%>" colspan="2">
								<div style="text-align: <%=reverseAlign%>">
									<form name="guestform" method="get" action="<%=guestLoginURL%>" onsubmit="showWait()">
										<button class="tiv_btn" type="submit" id="guestloginlink" value="1"><%=guestLoginLabel%></button>
									</form>
								</div>
								<br />
							</td>
						</tr>
<%					}
					if(mtEnabled){ %>	
						<tr>
							<td align="<%=reverseAlign%>" height="18" colspan="2">
								<button id="adminlink" class="link" onclick="var tInfo = document.getElementById('tenantinfo'); tInfo.style.display=''; tInfo.setAttribute('aria-hidden', 'false');"><span><%=labels.adminLoginLink%></span></button>
							</td>
						</tr>				
				<%	}
					if((!formAuth || "1".equals(s.getProperty("mxe.AllowUserMgmt"))) && isMobile)
					{
%>						<tr>
							<td align="<%=reverseAlign%>" height="18" colspan="2">
								<form name="mobileform" method="get" action="<%=submitUrl%>" onsubmit="showWait()">
									<input type="hidden" name="mobile" value="<%=!isMobile%>" />
									<button id="mobilelink" class="link" type="submit" value="1"><span><%=labels.standardLoginLink%></span></button>
								</form>
							</td>
						</tr>
<%						if (!MXFormat.stringToBoolean(isSaasEnabled))
						{
%>							<tr>
								<td align="<%=reverseAlign%>" height="18" colspan="2">
									<form name="selfregform" method="post" action="<%=submitUrl%>" onsubmit="showWait()">
										<input type="hidden" name="event" value="loadapp" />
										<input type="hidden" name="value" value="forgotpswd" />
										<input type="hidden" name="login" value="selfreg" />
										<input type="hidden" name="username" id="forgot_<%=userFieldName%>" />
<%										if(langNameToCodeMap != null)
										{
%>											<input type="hidden" name="langcode" value="<%=langcode%>" />
<%										}
%>										<button id="forgotpwdlink" class="link" type="submit" value="1"><span><%=labels.forgotPassword%></span></button>
									</form>
								</td>
							</tr>
<%						}
					}
					if(langNameToCodeMap != null)
					{	
						String[] langNames = langNameToCodeMap.keySet().toArray(new String[langNameToCodeMap.size()]);
						Arrays.sort(langNames);
%>						<tr height="<%=isMobile?"104":"30"%>px">
							<td nowrap="nowrap" align="<%=reverseAlign%>" colspan="2">
								<form name="langform" method="post" id="langform" >
									<input type="hidden" id="languser" name="username"  value=""/>
<% 								if(formAuth)
								{
%>									<input type="hidden" name="langchanged" value="1" />
<%								}
%>									<label for="langselect"><%=labels.selectLanguage%>
									</label>
									
									<select id="langselect" name="langcode" onchange="selectLanguage()" title="<%=labels.onLanguageSelection%>">
<%								for(int i = 0; i < langNames.length; i++)
								{
									String code = langNameToCodeMap.get(langNames[i]); 
									if(code.equals(langcode))
									{
%>										<option value="<%=code%>" selected="selected"><%=langNames[i]%></option>
<%									}
									else
									{
%>										<option value="<%=code%>"><%=langNames[i]%></option>
<%									}
								}
%>									</select>
								</form>
							</td>
						</tr>
<%					}
					else if(isMobile)
					{
%>						<tr height="104px"><td colspan="2">&nbsp;</td></tr>
<%					}
					if((!formAuth || "1".equals(s.getProperty("mxe.AllowUserMgmt"))) && !isMobile)
					{
						if(everyplace)
						{
%>						<tr>
							<td align="<%=reverseAlign%>" height="18" colspan="2">
								<form name="mobileform" method="get" action="<%=submitUrl%>" onsubmit="showWait()">
									<input type="hidden" name="mobile" value="<%=!isMobile%>" />
									<button id="mobilelink" class="link" type="submit" value="1"><span><%=labels.mobileLoginLink%></span></button>
								</form>
							</td>
						</tr>
<%						}
%>						<tr>
							<td align="<%=reverseAlign%>" height="18" colspan="2">
								<form name="selfregform" method="post" action="<%=submitUrl%>" onsubmit="showWait()">
									<input type="hidden" name="event" value="loadapp" />
									<input type="hidden" name="value" value="forgotpswd" />
									<input type="hidden" name="login" value="selfreg" />
									<input type="hidden" name="username" id="forgot_<%=userFieldName%>" />
<%								if(langNameToCodeMap != null)
								{
%>									<input type="hidden" name="langcode" value="<%=langcode%>" />
<%								}
%>									<button id="forgotpwdlink" class="link" type="submit" value="1"><span><%=labels.forgotPassword%></span></button>
								</form>
							</td>
						</tr>
						<tr>
							<td align="<%=reverseAlign%>" height="18" colspan="2">
								<form name="selfregform" method="post" action="<%=submitUrl%>" onsubmit="showWait()">
									<input type="hidden" name="event" value="loadapp" />
									<input type="hidden" name="value" value="selfreg" />
									<input type="hidden" name="login" value="selfreg" />
									<input type="hidden" name="username" id="forgot_<%=userFieldName%>" />
<%								if(langNameToCodeMap != null)
								{
%>									<input type="hidden" name="langcode" value="<%=langcode%>" />
<%								}
%>
<%								if(!mtEnabled)
								{
%>									<%=labels.newUserLabel%> <button id="selfreglink" class="link" type="submit" value="1"><span><%=labels.newUserLink%></span></button>
<%								}
%>								</form>
							</td>
						</tr>
<%					}
%>				</table>
				</td>
			</tr>
			<%
			if (MXFormat.stringToBoolean(isSaasEnabled))
			{
%>			
			<tr style="height:10px;">
			</tr>
			<tr>
				<td colspan="2" class="fednotice" style="text-align:justify;" >
				<%	if(MXFormat.stringToBoolean(isFederal)){ %>
				<span id="fednotice"><%=labels.federalNotice%></span>
				<%} else {%>
				<span id="nonfednotice"><%=labels.nonFederalNotice%></span>
<%
			}
%>	
				</td>
			</tr>
<%
			}
%>						
			<tr>
				<td colspan="2" class="copyright" role="contentinfo"><img alt="IBM" src="images/ibm-logo-white.gif" style="display: none"><p><%=labels.copyright%></p></td>
			</tr>
		</table>
	</div>
    <script type="text/javascript" src="../javascript/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="../javascript/jsencrypt.min.js"></script>
<%	if(BidiUtils.isBidiEnabled())
	{
%>	<script type="text/javascript" src="../javascript/<%=Dojo.getMaximoJavascriptDirectory(request)%>bidi_library.js"></script>
<%	}

	if(tokenExpire)
	{
%>	<script type="text/javascript" src="../javascript/<%=WebClientRuntime.getDojoDirectory(request)%>/dojo/dojo.js"></script>
	<script type="text/javascript" src="../javascript/tokenrelog.js"></script>
<%	}

%>	<script language="JavaScript" type="text/javascript">
	var MAINDOC=document;
	function checkForRefresh() 
	{
<%		if (BidiUtils.isBidiEnabled())
		{
%>			setTimeout("document.getElementById('username').blur(); document.getElementById('username').focus()",100);
<%		}
%>		document.cookie = "TJE= ; expires=-1; path=/";
		document.cookie = "TE3= ; expires=-1; path=/";
		if (MAINDOC.location != document.location)
		{
			var hiddenFrame = parent.document.getElementById("commframe");
			if (hiddenFrame != null)
			{
				var debugwindow = parent.document.getElementById("dockedHiddenFrame");
				var hdrRow = parent.document.getElementById("debugHeaderRow");
				hdrRow.style.display="none";
				debugwindow.style.display="";
				debugwindow.style.visibility="visible";
				debugwindow.style.position="absolute";
				debugwindow.style.top = -16 + "px";
				debugwindow.style.left = -18 + "px";
				debugwindow.style.opacity=1;
				debugwindow.style.filter="alpha(opacity=100)";
				debugwindow.style.width=parent.document.body.clientWidth +19 + "px";
				debugwindow.style.height=parent.document.body.clientHeight + 16 + "px";
				hiddenFrame.style.width=parent.document.body.clientWidth +19 + "px";
				hiddenFrame.style.height=parent.document.body.clientHeight + 16 + "px";
				debugwindow.style.zIndex=1001
				hiddenFrame.style.display="inline";
				parent.hideWait();
			}
		}
		if(document.documentMode && (document.documentMode < 8))
			alert("Either Compatibility View is turned on or you are using an unsupported browser version which can affect the performance of the product. Ensure that Compatibility View is turned off. If the issue continues, ensure that you are not using an unsupported browser version.");

<%		if (message != null && isMobile)
		{
%>			alert("<%=message%>");
<%		}

%>		var userField = document.getElementById("<%=userFieldName%>");
		if (<%=loginException != null%> || userField.value == "")
		{
			userField.focus();
			userField.select();
		}
		else
		{
			var pWordField = document.getElementById("<%=passwordFieldName%>");
			if (pWordField.value == "")
			{
				pWordField.focus();
				pWordField.select();
			}
			else
			{
				document.getElementById("loginbutton").focus();
			}
		}
		window.setTimeout("document.location='exit.jsp?logintimeout=1'", <%=(session.getMaxInactiveInterval() - 10) * 1000%>);
	
		if (navigator.userAgent.toLowerCase().indexOf("iphone") > -1)
		{
			setTimeout(hideURLbar, 0);
		}
	}
	
	function loginSetup()
	{
		showWait();
        console.log("login");
		let pwd=$("#sourcepassword").val();
		let un=$("#sourceusername").val();
		console.log("",pwd);
		if(pwd!= undefined){
		 var pkey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCd+fHiQNWknm1ZcjnTK20XKRkUtY7B1h5DH+hAzlVSlMpZfVkDjHAc7rYDcNEdLz2LmA9+UD2BZ4lgckpzfRw5b2PHVlbpDeWMxKx0El10vJx0jP3LH71mKEYsjDuV3pryT/sRaylS3BY30sAcmvBOv/RyhuUAh247XChcNgOTywIDAQAB";
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
	document.getElementById("localStorage").value = ('localStorage' in window && window['localStorage'] !== null); 
	function selectLanguage()
	{
		var langform = document.getElementById("langform");
		var username = document.getElementById("<%=userFieldName%>");
		if(username && username.value)
		{
			langform.languser.value = username.value;
		}
		langform.submit();
	}

	function showWait()
	{
		document.body.style.cursor="wait";
		document.body.onkeydown = noKeys;

		var lb = document.getElementById("loginbutton");
		if (lb)
		{
			lb.disabled = true;
			lb.setAttribute("aria-disabled", "true");
		}

		var main_tbl = document.getElementById("main_tbl");
		if (main_tbl)
		{
			main_tbl.style.display = "none";
			main_tbl.setAttribute("aria-hidden", "true");
		}
	}

	function noKeys(event)
	{
		event = event || window.event;
		if (event.stopPropagation)
		{
			event.stopPropagation();
			event.preventDefault();
		}
		else
		{
			event.cancelBubble=true;
			event.returnValue=false;
		}
		return false;
	}

	function hideURLbar()
	{
		window.scrollTo(0, 1);
	}
	</script>
</body>
<%@ include file="../common/webreplayLogin.jsp" %>
</html>