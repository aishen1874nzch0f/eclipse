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
package com.base.shiro.web;

import java.util.Map;

import com.base.common.utils.DateUtils;
import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.base.shiro.Status;
import com.base.shiro.entity.RoleModel;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

/**
 * RoleController
 * 
 * @author xpg
 * @since 0.1
 */
public class RoleController extends Controller {

	public void index() {

		render("roleList.jsp");
	}

	public void roleList() {
		// int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<RoleModel> roleList = RoleModel.dao.paginate(pageNumber, pageSize, getPara("name"));
		Map<String, Object> map = MapUtil.toModel("rows", roleList);
		// map.put("rows",goodsModelList.getList() );
		map.put("results", roleList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);

	}

	// 设置角色对应的资源
	@Before(Tx.class)
	public void setRole() {
		int[] result = {};
		if (getParaValues("ids") != null && getParaValues("userIds") != null) {
			String[] roleIds = getParaValues("ids")[0].split(",");
			String[] userId = getParaValues("userIds")[0].split(",");
			Object[][] list = new Object[roleIds.length][2];

//			System.out.println("res====" + roleIds.length);
//			System.out.println("role===" + userId.length);
			result = new int[roleIds.length];
			// 多个用户设置
			for (int i = 0; i < userId.length; i++) {
				// 每个用户分别设置
				for (int j = 0; j < roleIds.length; j++) {
					list[j][0] = Integer.parseInt(userId[i]);
					list[j][1] = Integer.parseInt(roleIds[j]);
				}
				//先删除所有已经社会角色
				int rbool = Db.update("delete from sys_user_role where user_id in(" +userId[i]+ ")");
				if (rbool >= 0) {
					//重新设置角色
					result = Db.batch("insert into sys_user_role(user_id,role_id) values(?,?)", list, 1000);
				}
			}
		}
		renderJson(JsonMessage.message(result.length));
	}

	// 激活角色
	public void active() {
		RoleModel role = new RoleModel();
		role.set("id", getParaToInt("id"));
		Integer active = getParaToInt("active");
		if (active == Status.NORMAL.getStatus()) {
			role.set("status", Status.NOT_ENABLED.getStatus());
		} else if (active == Status.NOT_ENABLED.getStatus()) {
			role.set("status", Status.NORMAL.getStatus());
		} else if (active == Status.LOCKED.getStatus()) {
			role.set("status", Status.NORMAL.getStatus());
		}
		boolean bool = role.update();
		renderJson(JsonMessage.message(bool));
	}

	@Before(Tx.class)
	public void save() {
		RoleModel nrole = new RoleModel();
		nrole.set("name", getPara("name"));
		nrole.set("desc", getPara("desc"));
		nrole.set("seq", getPara("seq"));
		nrole.set("icon", getPara("icon"));
		nrole.set("create_date", DateUtils.getCurrentTime());
		boolean bool = nrole.save();
		renderJson(JsonMessage.message(bool));

	}

	public void update() {
		RoleModel nrole = new RoleModel();
		nrole.set("id", getPara("id"));
		nrole.set("name", getPara("name"));
		nrole.set("desc", getPara("desc"));
		nrole.set("seq", getPara("seq"));
		nrole.set("icon", getPara("icon"));
		nrole.set("updated_date", DateUtils.getCurrentTime());
		boolean bool = nrole.update();
		renderJson(JsonMessage.message(bool));
	}

	@Before(Tx.class)
	public void delete() {
		int ubool = RoleModel.dao.deleteCascade(getParaToInt());
		boolean rbool = RoleModel.dao.deleteById(getParaToInt());
		if (ubool >= 0 && rbool) {
			renderJson(JsonMessage.message(true));
		}
		if (ubool < 0 && rbool == false) {
			renderJson(JsonMessage.message(false));
		}
	}

	@Before(Tx.class)
	public void deleteBatch() {
		int rbool = Db.update("delete from sys_user_role where role_id in(" + getPara("ids") + ")");
		int rrbool = Db.update("delete from sys_role_res where role_id in(" + getPara("ids") + ")");
		int ubool = Db.update("delete from sys_role where id in(" + getPara("ids") + ")");
		if (ubool + rbool + rrbool >= 0) {
			renderJson(JsonMessage.message(true));
		}
		if (ubool + rbool + rrbool < 0) {
			renderJson(JsonMessage.message(false));
		}
	}
}
