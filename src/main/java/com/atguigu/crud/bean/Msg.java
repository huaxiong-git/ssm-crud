package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

	private int code;
	
	private String message;
	
	private Map<String , Object> extend = new HashMap<String , Object>();

	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMessage("处理成功!");
		return msg;
	} 
	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMessage("处理失败!");
		return msg;
	}
	public int getCode() {
		return code;
	}

	public Msg add(String key , Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
}
