package com.base.common.json;

public class JsonBean {

	//标题
	private String title="";
	//状态码
	private String state="";
	//数据
	private Object data="";
	//是否弹层0不返回；1返回
	private String alert="0";
	//弹层的数据
	private String message="";
	
	
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getAlert() {
		return alert;
	}
	public void setAlert(String alert) {
		this.alert = alert;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * 失败情况
	 * @param code 编码
	 * @param msg  原因
	 * @return
	 */
	public static JsonBean fail(String code, String msg) {
		return fail(code, msg, "0");
	}
	
	/**
	 * 失败情况
	 * @param code 编码
	 * @param msg  原因
	 * @param alert	
	 * @return
	 */
	public static JsonBean fail(String code, String msg, String alert) {
		JsonBean json = new JsonBean();
		json.setMessage(msg);
		json.setState(code);
		json.setAlert(alert);
		return json;
	}
	
	/**
	 * 成功情况
	 * @param code	编码
	 * @param msg	原因
	 * @param data	数据
	 * @return
	 */
	public static JsonBean success(String code, String msg, Object data) {
		return success(code, msg, data, "0");
	}
	
	/**
	 * 成功情况
	 * @param code	编码
	 * @param msg	原因
	 * @return
	 */
	public static JsonBean success(String code, String msg) {
		return success(code, msg, null, "0");
	}
	
	/**
	 * 成功情况
	 * @param code	编码
	 * @param msg	原因
	 * @param data	数据
	 * @param alert	
	 * @return
	 */
	public static JsonBean success(String code, String msg, Object data, String alert) {
		JsonBean json = new JsonBean();
		json.setData(data);
		json.setMessage(msg);
		json.setState(code);
		json.setAlert(alert);
		return json;
	}
}
