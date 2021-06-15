package com.base.shiro;

import java.util.List;

import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.base.common.utils.EncodeUtils;
import com.base.common.utils.MD5Util;
import com.base.shiro.entity.UserModel;
import com.jfinal.log.Log;


/**
 * *重要*shiro授权相关
 * 
 * @author Administrator
 *
 */
public class ShiroDbRealm extends AuthorizingRealm {
	private static Log logger = Log.getLog(ShiroDbRealm.class.getName());

	/**
	 * 认证回调函数,登录时调用.
	 * 
	 * @return
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// 查询数据库存储用户信息
		String username = token.getUsername();
		UserModel loginuser = null;
		int status;
		if (username == null) {
			logger.warn("用户名不能为空");
			throw new AccountException("用户名不能为空");
		}
		loginuser = UserModel.dao.getByName(token.getUsername());
		if (loginuser == null) {
			logger.warn("用户不存在");
			throw new UnknownAccountException("用户不存在");
		}
		status = loginuser.get("account_status");
		// 用户被锁定
		if (Status.LOCKED.getStatus() == status)
			throw new LockedAccountException("用户账号冻结");
		// 用户未激活
		if (Status.NOT_ENABLED.getStatus() == status)
			throw new LockedAccountException(" 用户账号未激活");
		// 用户已经被管理员删除，请联系管理员
		if (Status.DELETED.getStatus() == status)
			throw new LockedAccountException("用户已经被管理员删除，请联系管理员");
		// 认证用户密码
		try {
			if (MD5Util.md5Digest(new String(token.getPassword())).equals(loginuser.get("password"))) {
				logger.info("密码已验证！");
			} else {
//				logger.info("用户名/密码 不正确！");
				throw new IncorrectCredentialsException("用户名/密码 不正确");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			e.printStackTrace();
			throw new IncorrectCredentialsException(e);
		}
		// 认证成功
		byte[] salt = EncodeUtils.hexDecode(loginuser.getStr("salt"));
		ShiroPrincipal subject = new ShiroPrincipal(loginuser);
		List<String> authorities = UserModel.dao.getAuthoritiesName(loginuser.getInt("id"));
		List<String> rolelist = UserModel.dao.getRolesName(loginuser.getInt("id"));
		subject.setAuthorities(authorities);
		subject.setRoles(rolelist);
		subject.setAuthorized(true);
		// String username = token.getUsername();
		// String password = String.valueOf(token.getPassword());
		// System.out.println(user.get("username")+"====="+user.get("password"));
		return new SimpleAuthenticationInfo(subject, token.getPassword(), ByteSource.Util.bytes(salt), this.getName());
	}

	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 */
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

		ShiroPrincipal subject = (ShiroPrincipal) super.getAvailablePrincipal(principals);
		String username = subject.getUserName();
		Integer userId = subject.getId();
		try {
			if (!subject.isAuthorized()) {
				// 根据用户名称，获取该用户所有的权限列表
				List<String> authorities = UserModel.dao.getAuthoritiesName(userId);
				List<String> rolelist = UserModel.dao.getRolesName(userId);
				subject.setAuthorities(authorities);
				subject.setRoles(rolelist);
				subject.setAuthorized(true);
				logger.info("用户【" + username + "】授权初始化成功......");
				logger.info("用户【" + username + "】 角色列表为：" + subject.getRoles());
				logger.info("用户【" + username + "】 权限列表为：" + subject.getAuthorities());
			}
		} catch (RuntimeException e) {
			throw new AuthorizationException("用户【" + username + "】授权失败");
		}
		// 给当前用户设置权限
		info.addStringPermissions(subject.getAuthorities());
		info.addRoles(subject.getRoles());
		return info;
	}

	/**
	 * 更新用户授权信息缓存.
	 * 
	 * @param principal
	 */
	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清除所有用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();

		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}

}
