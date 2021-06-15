package com.base.shiro.entity;

import java.util.List;

import com.base.common.utils.Digests;
import com.base.common.utils.EncodeUtils;
import com.base.common.utils.MD5Util;
import com.base.common.utils.StringUtil;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class UserModel extends Model<UserModel> 
{
	private static final long serialVersionUID = -8900455019192185350L;	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;
	public static final String INT_PASSWORD = "123456";
	public static final UserModel dao = new UserModel();
	
	public Page<UserModel> paginate(int pageNumber, int pageSize, String name) {
		String sql = "from sys_user u left join sys_org o on o.id= u.org ";
		if(StringUtil.isNoNullorEmpty(name)) {
			sql += " where u.username like '%" + name + "%' or u.fullname like '%"+ name +"%'";
		}
		sql += " order by u.id asc ";
		return paginate(pageNumber, pageSize, "select u.*,o.name as orgName", sql);
	}
	/**
	 * 获得包含部门的用户信息
	 * @param 根据用户名
	 * @return
	 */
	public UserModel getByName(String name) {
		return UserModel.dao.findFirst("select u.*,o.name as orgName from sys_user u left join sys_org o on u.org=o.id where u.username=?", name);
	}
	//根据用户Id获取用户信息
	public UserModel get(Integer id) {
		return UserModel.dao.findFirst("select u.*,o.name as orgName from sys_user u left join sys_org o on u.org=o.id where u.id=?", id);
	}
	
	public List<UserModel> getByOrg(Integer orgId) {
		String sql = "select u.*,o.name as orgName from sys_user u left join sys_org o on u.org=o.id ";
		if(orgId != null && orgId > 0) {
			sql += " where u.org=" + orgId;
		}
		return UserModel.dao.find(sql);
	}
	
	public List<RoleModel> getRoles(Integer id) {
		return RoleModel.dao.find("select r.* from sys_role r "
				+ "left join sys_user_role ru on r.id=ru.role_id "
				+ "left join sys_user u on u.id=ru.user_id "
				+ "where u.id=?", id);
	}
	
	public int insertCascade(Integer id, Integer roleId) {
		return Db.update("insert into sys_role_user (user_id, role_id) values (?,?)", id, roleId);
	}
	
	public int deleteCascade(Integer id) {
		return Db.update("delete from sys_role_user where user_id = ?", id);
	}
	
	/**
	 * 根据用户ID查询该用户所拥有的权限列表
	 * @param userId
	 * @return
	 */
	public List<String> getAuthoritiesName(Integer userId) {
		String sql = "select r.url FROM sys_res r left join sys_role_res rr ON rr.res_id=r.id LEFT JOIN sys_user_role ur ON ur.role_id=rr.role_id LEFT JOIN sys_user u ON u.id=ur.user_id where r.type=2 and u.id="+userId+" order by r.seq asc";
		return Db.query(sql);
	}
	
	/**
	 * 根据用户ID查询该用户所拥有的角色列表
	 * @param userId
	 * @return
	 */
	public List<String> getRolesName(Integer userId) {
		String sql = "select r.name from sys_user u " + 
					" left outer join sys_user_role ru on u.id=ru.user_id " + 
					" left outer join sys_role r on ru.role_id=r.id " + 
					" where u.id=? ";
		return Db.query(sql, userId);
	}
	
	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 * @throws Exception 
	 */
	public void entryptPassword(UserModel user) throws Exception {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		user.set("salt", EncodeUtils.hexEncode(salt));

//		byte[] hashPassword = Digests.sha1(user.getStr("plainPassword").getBytes(), salt, HASH_INTERATIONS);
//		user.set("password", EncodeUtils.hexEncode(hashPassword));
		user.set("password", MD5Util.md5Digest(user.getStr("password")));
	}
	
	
}
