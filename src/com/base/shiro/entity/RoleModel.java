package com.base.shiro.entity;

import java.util.List;

import com.base.common.utils.StringUtil;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 用户角色相关
 */
public class RoleModel extends Model<RoleModel> {
	
	
	
	
	private static final long serialVersionUID = 8607175386628929240L;
	public static final RoleModel dao =new RoleModel();
	
	/**
	 * 找到用户拥有的角色
	 * @param object
	 * @return
	 */
	public List<RoleModel> findRolesByUser(Integer userId){
		
		 String sql = "select * from sys_role where id in (select role_id from sys_user_role where user_id="+userId+")";
//		 String sql = "select * from sys_role s "
//			 		+ "LEFT JOIN sys_user_role ur On ur.role_id=s.id "
//			 		+ "LEFT JOIN sys_user u ON u.id=ur.user_id "
//			 		+ "where u.id"+userId+")";
	        //return Role.dao.find(sql, this.get("USER_ID"));
	        return RoleModel.dao.find(sql);
		
	}
	
	/**
	 * 根据角色名中关键词，检索角色
	 * @param pageNumber
	 * @param pageSize
	 * @param name
	 * @return
	 */
	public Page<RoleModel> paginate (int pageNumber, int pageSize, String name) {
		String sql = "from sys_role ";
		if(StringUtil.isNoNullorEmpty(name)) {
			sql += " where name like '%" + name + "%' ";
		}
		sql += " order by id asc ";
		return paginate(pageNumber, pageSize, "select *", sql);
	}
	/**
	 * 所有角色
	 * @return
	 */
	public List<RoleModel> getAllRoles() {
		return RoleModel.dao.find("select * from sys_role");
	}
	/**
	 * 设置用户角色
	 * @param userId
	 * @param roleId
	 */
	
	public void insertCascade(Integer userId, Integer roleId) {
		Db.update("insert into sys_use_role (user_id,role_id) values (?,?)", userId, roleId);
	}
	/**
	 * 删除用户角色
	 * @param roleId
	 */
	public int deleteCascade(Integer roleId) {
		int usum=Db.update("delete from sys_user_role where role_id = ?", roleId);
		int rsum=Db.update("delete from sys_role_res where role_id = ?", roleId);
		return usum+rsum;
	}
	//获得该角色所有资源信息
	public List<ResModel> getAuthorities(Integer paraToInt) {
		// TODO Auto-generated method stub
		String sql = "select * from sys_res where id in (select res_id from sys_role_res where role_id="+paraToInt+")";
//		 String sql = "select * from sys_role s "
//			 		+ "LEFT JOIN sys_user_role ur On ur.role_id=s.id "
//			 		+ "LEFT JOIN sys_user u ON u.id=ur.user_id "
//			 		+ "where u.id"+userId+")";
	        //return Role.dao.find(sql, this.get("USER_ID"));
	        return ResModel.dao.find(sql);
	}	
}
