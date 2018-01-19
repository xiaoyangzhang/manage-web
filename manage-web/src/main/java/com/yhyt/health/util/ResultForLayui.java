package com.yhyt.health.util;

import java.util.List;
/*
 * 
 * 页面查询用的返回实体类
 * 
 * 
 * 张衡
 * 
 * 
 * 
 */
public class ResultForLayui {

	private String rel;
	private String msg;
	private List list;
	private String count;
	public String getRel() {
		return rel;
	}
	public void setRel(String rel) {
		this.rel = rel;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	
}
