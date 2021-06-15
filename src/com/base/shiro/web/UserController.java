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
import com.base.shiro.ShiroUtils;
import com.base.shiro.Status;
import com.base.shiro.entity.OrgModel;
import com.base.shiro.entity.UserModel;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

/**
 * UserController
 * @author xpg
 * @since 0.1
 */
public class UserController extends Controller {
	
	String error =null;
	
	public void index() {
		render("userList.jsp");
	}
	public void userList(){	
//		int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber=(getParaToInt("pageIndex")!=0)?getParaToInt("pageIndex")+1:1;		
		int pageSize=(getParaToInt("limit")!=0)?getParaToInt("limit"):10;		
		Page<UserModel> userList= UserModel.dao.paginate(pageNumber,pageSize,getPara("name"));
		Map<String, Object> map=MapUtil.toModel("rows", userList);
//		map.put("rows",goodsModelList.getList() );
		map.put("results",userList.getTotalRow());
		map.put("hasError", false);		
		renderJson(map);
		
	}
	//查看用户信息
	public void view(){
		setAttr("userInfo",UserModel.dao.get(ShiroUtils.getUserId()));
		render("userView.jsp");
	}
	//重置密码
	public void resetPwd(){
		UserModel user =new UserModel();
		user.set("id",getParaToInt());
		user.set("last_updated_date",DateUtils.getCurrentTime());
		user.set("password", UserModel.INT_PASSWORD);
		try {
			user.entryptPassword(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		boolean bool=user.update();
		renderJson(JsonMessage.message(bool));		
	}
	//激活用户
		public void active(){
			UserModel user =new UserModel();
			user.set("id",getParaToInt("id"));						
			Integer active =getParaToInt("active");		
			if(active==Status.NORMAL.getStatus()){
				user.set("account_status", Status.NOT_ENABLED.getStatus());	
			}
			else if(active==Status.NOT_ENABLED.getStatus()){
				user.set("account_status", Status.NORMAL.getStatus());
			}
			else if(active==Status.LOCKED.getStatus()){
				user.set("account_status", Status.NORMAL.getStatus());
			}
			else if(active==Status.DELETED.getStatus()){
				user.set("account_status", Status.NORMAL.getStatus());
			}	
			boolean bool=user.update();
			renderJson(JsonMessage.message(bool));		
		}
	
	@Before(Tx.class)
	public void save() {		
		UserModel nuser =new UserModel();
		nuser.set("username", getPara("username"));		
		nuser.set("fullname", getPara("fullname"));
		nuser.set("password", UserModel.INT_PASSWORD);
		try {
			nuser.entryptPassword(nuser);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		nuser.set("icon", getPara("icon")==null?"/styles/images/i07.png":getPara("icon"));
		nuser.set("email", getPara("email"));
		nuser.set("org", getParaToInt("org")==null?OrgModel.ROOT_ORG_ID:getParaToInt("org"));
		nuser.set("create_date",DateUtils.getCurrentTime());
		boolean bool=nuser.save();
		renderJson(JsonMessage.message(bool));
		
	}
	
	public void update() {		
		UserModel nuser =new UserModel();
		nuser.set("id", getPara("id"));	
		nuser.set("username", getPara("username"));		
		nuser.set("fullname", getPara("fullname"));		
		nuser.set("icon", getPara("icon"));
		nuser.set("email", getPara("email"));
		nuser.set("org", getParaToInt("org")==null?OrgModel.ROOT_ORG_ID:getParaToInt("org"));
		nuser.set("last_updated_date",DateUtils.getCurrentTime());
		boolean bool=nuser.update();
		renderJson(JsonMessage.message(bool));		
	}
	
	@Before(Tx.class)
	public void delete() {
		//直接删除数据库
//		int ubool =UserModel.dao.deleteCascade(getParaToInt());
//		boolean rbool =UserModel.dao.deleteById(getParaToInt());
//		if(ubool>=0&&rbool){
//			renderJson(JsonMessage.message(true));
//		}
//		if(ubool<0&&rbool==false){
//			renderJson(JsonMessage.message(false));
//		}
		//标记删除，数据库本身记录不删除
		UserModel user =new UserModel();
		user.set("id",getParaToInt("id"));
		user.set("account_status", Status.DELETED.getStatus());
		user.set("last_updated_date", DateUtils.getCurrentTime());
		boolean ubool=user.update();				
		renderJson(JsonMessage.message(ubool));
		
	}	
	@Before(Tx.class)
	public void deleteBatch() {	
		//直接删除数据库
//		int ubool = Db.update("delete from sys_user_role where user_id in(" + getPara("ids") + ")");
//		int rbool = Db.update("delete from sys_user where id in(" + getPara("ids") + ")");
//		if(ubool>=0&&rbool>=0){
//			renderJson(JsonMessage.message(true));
//		}
//		if(ubool<0&&rbool<0){
//			renderJson(JsonMessage.message(false));
//		}
		//标记删除，数据库本身记录不删除
		int rbool = Db.update("update sys_user set account_status="+Status.DELETED.getStatus()+",last_updated_date='"+DateUtils.getCurrentTime()+"' where id in(" + getPara("ids") + ")");				
		renderJson(JsonMessage.message(rbool));
	}	
}


