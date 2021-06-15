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
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 部门模型
 * @author xpg
 * @since 0.1
 */
public class OrgModel extends Model<OrgModel> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5018575558755643041L;
	//根部门ID号默认为0
	public static final Integer ROOT_ORG_ID = 0;
	public static final OrgModel dao = new OrgModel();
	
	public Page<OrgModel> paginate (int pageNumber, int pageSize, String name) {
		String sql = " from sys_org o left join sys_org op on o.parent_org=op.id ";
		if(StringUtil.isNoNullorEmpty(name)) {
			sql += " where o.name like '%" + name + "%' ";
		}
		sql += " order by o.id asc";
		return paginate(pageNumber, pageSize, "select o.*,op.id as pid,op.name as pname", sql);
	}
	//获得单个组织结构信息
	public OrgModel get(Integer id) {
		return OrgModel.dao.findFirst("select o.*,po.id as pid, po.name as pname from sys_org o left join sys_org po on o.parent_org=po.id where o.id=?", id);
	}
	//传入PID，获得所有子机构
	public List<OrgModel> getByParent(Integer parentId) {
		String sql = "select o.*,po.name as pname from sys_org o left join sys_org po on o.parent_org=po.id ";
		sql += " where o.parent_org=" + parentId;		
		return find(sql);
	}	
}
