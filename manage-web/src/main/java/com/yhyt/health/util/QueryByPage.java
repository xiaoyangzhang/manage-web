package com.yhyt.health.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

/*
 * 
 * 张衡
 * 
 * 分页工具
 */
public class QueryByPage {
	
	public static List getPage(HttpServletRequest request,List u){
		
		if(null==request||null==u||u.size()==0){
		return null;
		}
		String pageIndexrequest=request.getParameter("pageIndex");
		String pageSizerequest=request.getParameter("pageSize");
		List<Object> u1=new ArrayList<Object>();
		for(int us=0;us<u.size();us++){
			
		Double db=(Double.parseDouble(pageIndexrequest)-1)*(Double.parseDouble(pageSizerequest));
		if(us>=db&&us<(db+Double.parseDouble(pageSizerequest))){
			
			u1.add(u.get(us));
		}
			
			
			
		}
		return u1;
		
		
		
		
	}
	
public static String getPageMake(HttpServletRequest request,String url){
	if(null==request||null==url||"".equals(url)){
		return null;
		}
		
		String pageIndexrequest=request.getParameter("pageIndex");
		String pageSizerequest=request.getParameter("pageSize");
			
		url+="&pageIndexrequest="+pageIndexrequest+"&pageSizerequest="+pageSizerequest;
		
		
		return url;
		
		
	}

}
