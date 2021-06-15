/*
 *  Copyright 2014-2015 snakerflow.com
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *     http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *
 */
package com.base.shiro.entity;

import java.util.List;

import com.base.common.utils.StringUtil;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 菜单,权限模型，资源类型1为菜单，2为权限
 * @author xpg
 * @since 0.1
 */
public class ResModel extends Model<ResModel> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8781209142247805658L;
	public static final ResModel dao = new ResModel();
	//菜单资源的根菜单标识为0
	public static final Integer ROOT_MENU = 0;	
	/***
	 * 	获得所有分页菜单、资源
	 * @param pageNumber
	 * @param pageSize
	 * @param name
	 * @return
	 */
	public Page<ResModel> paginate (int pageNumber, int pageSize, String name) {
		String sql = "from sys_res m left join sys_res pm on pm.id=m.pid";
		if(StringUtil.isNoNullorEmpty(name)) {
			sql += " where m.name like '%" + name + "%' ";
		}
		sql += " order by m.id asc";
		return paginate(pageNumber, pageSize, "select m.*,pm.name as parentName", sql);
	}	
	/***左侧菜单树用
	 * 获得全部权限范围的菜单
	 * @param userId
	 * @return
	 */
	public List<ResModel> getAllowedAccessMenus(Integer userId) {
		
		String sql="select r.* FROM sys_res r LEFT JOIN sys_role_res rr ON rr.res_id=r.id LEFT JOIN sys_user_role ur ON ur.role_id=rr.role_id LEFT JOIN sys_user u ON u.id=ur.user_id where r.type=1 and u.id="+userId+" order by r.seq asc";
		
		return find(sql);
	}
	/**后期URL过滤filter用
	 * 获取该用户所有权限URL
	 * @param userId
	 * @return
	 */
	public List<ResModel> getAllAuthoritys(Integer userId) {
		// TODO Auto-generated method stub
		String sql="select r.* FROM sys_res r LEFT JOIN sys_role_res rr ON rr.res_id=r.id LEFT JOIN sys_user_role ur ON ur.role_id=rr.role_id LEFT JOIN sys_user u ON u.id=ur.user_id where u.id="+userId+" order by r.seq asc";
		
		return find(sql);
	}
	/**
	 * 获取所用户所有已经选择的资源ID
	 * @param userId
	 * @return
	 */
	public List<ResModel> getUserRes(Integer roleId) {
		// TODO Auto-generated method stub
		String sql="select r.id FROM sys_res r left join sys_role_res srr on srr.res_id=r.id  where srr.role_id="+roleId+" order by r.id asc";
		
		return find(sql);
	}

	public int deleteCascade(Integer res_id) {
		// TODO Auto-generated method stub
		return Db.update("delete from sys_role_res where res_id = ?", res_id);
	}
	/**
	 * 获得所有菜单
	 * @param id,id=root，就是全部菜单
	 * @return
	 */
	public List<ResModel> getByParent(Integer id) {
		// TODO Auto-generated method stub		
		String sql = "select * from sys_res where pid="+id;		
		sql += " order by id asc";
		return find(sql);
	}
	
}
