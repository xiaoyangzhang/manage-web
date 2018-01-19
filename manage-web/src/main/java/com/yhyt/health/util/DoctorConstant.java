package com.yhyt.health.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/** 
* localadmin 作者: 
* @version 创建时间：2017年8月21日 上午9:43:41 
* 类说明 
*/
@Component    
@ConfigurationProperties(prefix="constant") //接收application.yml中的myProps下面的属性   
public class DoctorConstant {
	public static final String GROUP="/group1/M00/00/03/";
	private Map<String, String> sms = new HashMap<String, String>();
	
	private Map<String, String> redis = new HashMap<String, String>();
	
	private Map<String, String> fdfs = new HashMap<String, String>();

	public Map<String, String> getSms() {
		return sms;
	}

	public void setSms(Map<String, String> sms) {
		this.sms = sms;
	}

	public Map<String, String> getRedis() {
		return redis;
	}

	public void setRedis(Map<String, String> redis) {
		this.redis = redis;
	}

	public Map<String, String> getFdfs() {
		return fdfs;
	}

	public void setFdfs(Map<String, String> fdfs) {
		this.fdfs = fdfs;
	}
}
