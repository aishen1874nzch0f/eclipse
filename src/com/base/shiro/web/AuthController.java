package com.base.shiro.web;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

import com.base.common.utils.MD5Util;
import com.base.common.utils.StringUtil;
import com.base.shiro.ShiroPrincipal;
import com.base.shiro.ShiroUtils;
import com.base.shiro.Status;
import com.base.shiro.entity.UserModel;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;

public class AuthController extends Controller {

	String error = null;

	public void index() {
		render("login.jsp");
	}

	public void dologin() {

		String username = getPara("userName");
		String password = getPara("passWord");
		boolean rememberme =getParaToBoolean("remeber",false);
		if (StringUtil.isNull(username) || StringUtil.isNull(password)) {
			error = "用户名或密码不能为空！";
		}
		if (StringUtil.isNull(error)) {
			Subject subject = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			token.setRememberMe(rememberme);
			try {
				subject.login(token);
			} catch (UnknownAccountException ue) {
				token.clear();
				error = "登录失败，您输入的账号不存在！";
			} catch (IncorrectCredentialsException ie) {
				// ie.printStackTrace();
				token.clear();
				error = "登录失败，密码不匹配！";
			} catch (LockedAccountException lae) {
				token.clear();
				error = "账号未激活或已冻结，请联系管理员！";
			} catch (RuntimeException re) {
				//re.printStackTrace();
				token.clear();
				error = "登录失败！";
			}

		}
		if (StringUtil.isNull(error)) {
			redirect("/ms/main");
		} else {
			keepModel(UserModel.class);
			setAttr("error", error);
			render("login.jsp");
		}
	}

	@ActionKey("/ms/doLogout")
	public void doLogout() {
		try {
			Subject subject = SecurityUtils.getSubject();
			if (subject.isAuthenticated()) {
				subject.logout();
				setCookie("EID_LOGIN_USER_ID", "", 0);
				render("login.jsp");
			}
			// String userName =
			// SecurityService.getLoginUser().getStr("loginname");

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		render("login.jsp");
	}

	// 获得登陆用户
	public static UserModel getLoginUser() {
		// Subject subject = SecurityUtils.getSubject();
		// if (!subject.isAuthenticated())
		// return null;
		// Object attr = subject.getPrincipals();
		ShiroPrincipal sp = ShiroUtils.getPrincipal();//
		return sp.getUser();
	}

	public static boolean isPermitted(String url) {
		Subject subject = SecurityUtils.getSubject();
		if (!subject.isAuthenticated())
			return false;
		return subject.isPermitted(url);
	}

	public boolean register() {
		String userName = getPara("userName");
		String passWord = getPara("npassWord");
		String npassWord = getPara("rpassWord");
		UserModel user = new UserModel();
		user.set("loginname", userName);
		if (StringUtil.isNull(userName) || StringUtil.isNull(passWord)) {
			error = "用户名或密码不能为空！";
		}
		if (passWord != npassWord) {
			error = "两次输入密码不一致！";
		}
		try {
			user.set("password", MD5Util.md5Digest(passWord));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			error = "系统错误，请检查";
			return false;
		}
		// 设置状态未激活
		user.set("status", Status.NOT_ENABLED);

		boolean bool = user.save();

		return bool;
	}

	/*
	 * 修改密码
	 * 
	 */
	@ActionKey("/ms/resetpasswd")
	public void resetpasswd() {
		render("resetPasswd.jsp");
	}

	// 修改密码
	public void updatePassowrd() {

		String passWord = getPara("npassWord");
		String npassWord = getPara("rpassWord");

		if (!passWord.equals(npassWord)) {
			error = "两次输入密码不一致！";

		} 
		if (StringUtils.isEmpty(passWord) && StringUtils.isEmpty(passWord)) {
			error = "密码不能为空！";

		} 
		if (StringUtils.isEmpty(error)|| StringUtils.isBlank(error)) {
			UserModel currentUser = getLoginUser();
			try {
				currentUser.set("password", MD5Util.md5Digest(passWord));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				error = "系统错误，请检查!";
			}
			// 设置状态未激活
			// currentUser.set("status", Status.NOT_ENABLED);
			
				currentUser.update();
				error = "密码修成成功！";
			}
			
		setAttr("error", error);
		render("resetPasswd.jsp");
	}
}
