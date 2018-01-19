package com.yhyt.health.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestMapping;
/*
 * 
 * 
 * 基础controller
 * 张衡
 */

public class BaseController {
	protected Log logger = LogFactory.getLog(this.getClass());
	protected String ERROR="/common/error.jsp";
	
	protected String getUrlPrefix(HttpServletRequest request){
		String prefix = "";
		RequestMapping mapping = this.getClass().getAnnotation(RequestMapping.class);
		if(mapping != null && mapping.value() != null && mapping.value().length > 0){
			prefix = mapping.value()[0];
		}
		return prefix;
	}
	
	protected String redirect(HttpServletRequest request, String url){
		if (url.startsWith("/"))
			url = getBasePath(request) + url;
		return "redirect:" + url;
	}
	
	protected String forward(String url) {
		return "forward:" + url;
	}
	
	private String getBasePath(HttpServletRequest request) {
		String scheme = getScheme(request);
		String serverName = request.getServerName();
		int serverPort = getServerPort(request);
		String contextPath = request.getContextPath();

		boolean inHttp = "http".equals(scheme.toLowerCase());
		boolean inHttps = "https".equals(scheme.toLowerCase());

		boolean includePort = true;

		if (inHttp && (serverPort == 80)) {
			includePort = false;
		} else if (inHttps && (serverPort == 443)) {
			includePort = false;
		}
		String url = scheme + "://" + serverName + ((includePort) ? (":" + serverPort) : "") + contextPath;

		return url;
	}
	
	private String getScheme(HttpServletRequest request) {
		if (!isNull(request.getHeader("X-Forwarded-Proto")))
			return request.getHeader("X-Forwarded-Proto");
		else
			return request.getScheme();
	}
	
	private int getServerPort(HttpServletRequest request) {
		String xport = request.getHeader("X-Forwarded-Port");
		if (!isNull(xport)) {
			return Integer.valueOf(xport.trim());
		} else {
			return request.getServerPort();
		}
	}
	
	private boolean isNull(String obj){
		return (obj==null || obj.trim().length()==0);
	}

}
