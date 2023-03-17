package org.shoukaiseki.webclient.login;

import java.io.IOException;
import java.rmi.RemoteException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import psdi.server.DBManager;
import psdi.server.MXServer;
import psdi.util.MXException;
import psdi.util.MXSession;
import psdi.webclient.system.runtime.WebClientRuntime;

import org.apache.log4j.Logger;
import org.springframework.web.filter.OncePerRequestFilter;

public class LoginFilter extends OncePerRequestFilter {
	//私钥,公钥配对的私钥
	private final String PKEY = "MIIBVgIBADANBgkqhkiG9w0BAQEFAASCAUAwggE8AgEAAkEAoScV+C1UfmNHnWCg18n8/50xUbi9l+Y9T5En/FF9J+fAA0cCZgdMXsNGU96RAjJAR2hppXPDauMSsDn22KW+EwIDAQABAkALFcExHQ0e1H1smeT2cvJwMsPdtzNza2b0Pivd800EnZRfQc7kWab8PJDWBJOt1xFILX1Str/CstVdDak6MquhAiEA1q/B39Dj8x6mRD1mTuuWF6J2Jgm7CxDYJomYSFH2VAUCIQDAKg38TGsqk7sLez6xQWK9PpIX+816QdE470MOnoq9NwIhAMB6AULt4IEHOKAzwDb/hqiX8n919+ka5//dGte0DDoVAiEAwA2H2r8ZX/0ztD7holAh+dc+NaAgdW6wRwHBeCv1pzMCIQDDcDJp7r1XTdA7Gwv1Cn82k99l/PAMamF37I4ZFnrTDA==";
	private final Logger log = Logger.getLogger("org.shoukaiseki.ldap");

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
       String errormsg = "";
		try {
			if (!hasComeFromPortal(username, password)) {
				errormsg = "用户名和密码不能为空";
				renderError(errormsg, request, response);
				return;
			}
			String decUsername = JsEncryptUtil.decrypt(username, JsEncryptUtil.privateKey);
		    String decPassword = JsEncryptUtil.decrypt(password, JsEncryptUtil.privateKey);
				
			MXSession ms = WebClientRuntime.getMXSession(request.getSession());
			if (!ms.isConnected()) {
				ms.setUserName(decUsername);
				ms.setPassword(decPassword);
				ms.setClientAddr(request.getRemoteAddr());
				ms.setClientHost(request.getRemoteHost());
				ms.connect();
			}
			log.debug(" ================= 登录成功：" + username);
			response.sendRedirect(request.getContextPath() + "/ui/");
			return;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		     log.error(" ================= 登录失败：",e );
	         errormsg=e.getMessage();
		} finally {
		}
		 renderError(errormsg,request,response);
	}

	void renderError(String errormsg, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("errormsg", errormsg);
//	        request.setAttribute("authentication",authentication)
//	        request.getRequestDispatcher("/webclient/sso/login.jsp").forward(request,response)
		request.getRequestDispatcher("/webclient/login/login.jsp").forward(request, response);
	}

	private boolean hasComeFromPortal(String username, String password) {
		return username != null && username != "" && password != null && password != "";
	}


}
