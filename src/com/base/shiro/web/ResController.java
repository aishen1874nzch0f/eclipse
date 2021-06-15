package com.base.shiro.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.base.common.utils.DateUtils;
import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.base.shiro.entity.ResModel;
import com.base.shiro.entity.TreeNode;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

/**
 * ResourceController
 * 
 * @author xpg
 * @since 0.1
 */
public class ResController extends Controller {
	public void index() {
		render("resList.jsp");
	}

	public void resList() {
		// int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<ResModel> menuList = ResModel.dao.paginate(pageNumber, pageSize, getPara("name"));
		Map<String, Object> map = MapUtil.toModel("rows", menuList);
		// map.put("rows",goodsModelList.getList() );
		map.put("results", menuList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);

	}

	// 菜单资源树
	public void resTree() {
		List<ResModel> ress = ResModel.dao.getByParent(ResModel.ROOT_MENU);
		System.out.println("======="+getParaToInt("roleid"));
		List<ResModel> reus = ResModel.dao.getUserRes(getParaToInt("roleid"));
		List<TreeNode> trees = new ArrayList<TreeNode>();		
		TreeNode node = null ;
		if (ress != null) {
			for (ResModel res : ress) {
				node = new TreeNode();
				node.setId(res.getInt("id"));
				node.setText(res.getStr("name"));
				for (ResModel reusr : reus) {
					if (reusr.getInt("id").intValue() == res.getInt("id").intValue()) {
						node.setChecked(true);
					}
				}
				node.setChildren(resTreeChild(res.getInt("id"), reus));
				node.setExpanded(true);	
				//node.setChecked(true);
				
				trees.add(node);				
			}
		}
		renderJson(trees);
	}
	//角色所有的菜单ID
	public void resSelect(){
		List<ResModel> reus = ResModel.dao.getUserRes(getParaToInt("roleid"));		
		renderJson(reus);
	}
	public List<TreeNode> resTreeChild(Integer id, List<ResModel> reus) {
		List<ResModel> ress = ResModel.dao.getByParent(id);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		if (ress != null) {
			for (ResModel res : ress) {
				node = new TreeNode();
				node.setId(res.getInt("id"));
				node.setText(res.getStr("name"));
				for (ResModel reusr : reus) {
					if (reusr.getInt("id").intValue() == res.getInt("id").intValue()) {
						node.setChecked(true);
					}
				}
				node.setChildren(resTreeChild(res.getInt("id"), reus));
				
				trees.add(node);
			}
		}
		return trees;
	}

	public void save() {
		ResModel nres = new ResModel();
		nres.set("name", getPara("name"));
		nres.set("url", getPara("url"));
		nres.set("desc", getPara("desc"));
		nres.set("icon", "/styles/images/leftico03.png");
		nres.set("seq", getPara("seq"));
		nres.set("type", getPara("type"));
		nres.set("pid",getParaToInt("pid")==null?ResModel.ROOT_MENU:getParaToInt("pid"));		
		nres.set("last_updated_date", DateUtils.getCurrentTime());
		boolean bool = nres.save();
		renderJson(JsonMessage.message(bool));

	}

	// 设置角色对应的资源
	public void setRes() {
		int[] result = {};
		if (getParaValues("ids") != null && getParaValues("roleId") != null) {
			String[] resIds = getParaValues("ids")[0].split(",");
			String[] roleid = getParaValues("roleId")[0].split(",");
			Object[][] list = new Object[resIds.length][2];

//			System.out.println("res====" + resIds.length);
//			System.out.println("role===" + roleid.length);
			result = new int[resIds.length];
			// 多个角色设置
			for (int i = 0; i < roleid.length; i++) {
				// 每个角色分别设置
				for (int j = 0; j < resIds.length; j++) {
					list[j][0] = Integer.parseInt(roleid[i]);
					list[j][1] = Integer.parseInt(resIds[j]);
				}
				int ubool = Db.update("delete from sys_role_res where role_id in(" +roleid[i] + ")");
				if (ubool >= 0) {
					result = Db.batch("insert into sys_role_res(role_id,res_id) values(?,?)", list, 1000);
				}
			}
		}
		renderJson(JsonMessage.message(result.length));
	}

	public void update() {
		ResModel nres = new ResModel();
		nres.set("id", getPara("id"));
		nres.set("name", getPara("name"));
		nres.set("url", getPara("url"));
		nres.set("desc", getPara("desc"));
		nres.set("seq", getPara("seq"));
		nres.set("type", getPara("type"));
		nres.set("pid",getParaToInt("pid")==null?ResModel.ROOT_MENU:getParaToInt("pid"));
		nres.set("last_updated_date", DateUtils.getCurrentTime());
		boolean bool = nres.update();
		renderJson(JsonMessage.message(bool));
	}

	@Before(Tx.class)
	public void delete() {
		int ubool = ResModel.dao.deleteCascade(getParaToInt());
		boolean rbool = ResModel.dao.deleteById(getParaToInt());
		;
		if (ubool >= 0 && rbool) {
			renderJson(JsonMessage.message(true));
		}
		if (ubool < 0 && rbool == false) {
			renderJson(JsonMessage.message(false));
		}
	}

	@Before(Tx.class)
	public void deleteBatch() {
		int ubool = Db.update("delete from sys_role_res where res_id in(" + getPara("ids") + ")");
		int rbool = Db.update("delete from sys_res where id in(" + getPara("ids") + ")");
		if (ubool >= 0 && rbool >= 0) {
			renderJson(JsonMessage.message(true));
		}
		if (ubool < 0 && rbool < 0) {
			renderJson(JsonMessage.message(false));
		}
	}
}
