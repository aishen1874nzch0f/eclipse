package com.base.app;




import com.base.shiro.ShiroUtils;
import com.jfinal.core.Controller;

/**
 * CommonController
 */
public class IndexController extends Controller {
	public void main() {
		render("main.jsp");
	}
	public void top() {
		render("top.jsp");
	}
	public void left() {
		render("left.jsp");
		
	}	
	public void index() {
		setAttr("name", ShiroUtils.getUsername());
		setAttr("org", ShiroUtils.getOrgName());	
		render("index.jsp");
	}
}
