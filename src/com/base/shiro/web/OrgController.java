package com.base.shiro.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.base.shiro.Status;
import com.base.shiro.entity.OrgModel;
import com.base.shiro.entity.TreeNode;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

/**
 * OrgController
 * 
 * @author xpg
 * @since 0.1
 */
public class OrgController extends Controller {

	public void index() {
		render("orgList.jsp");
	}

	public void orgList() {
		// int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<OrgModel> orgList = OrgModel.dao.paginate(pageNumber, pageSize, getPara("name"));
		Map<String, Object> map = MapUtil.toModel("rows", orgList);
		// map.put("rows",goodsModelList.getList() );
		map.put("results", orgList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);

	}
	
	/**
	 * 获得组织机构菜单树
	 */
	public void orgTree() {
		List<OrgModel> orgs = OrgModel.dao.getByParent(OrgModel.ROOT_ORG_ID);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		for (OrgModel org : orgs) {
			node = new TreeNode();
			node.setId(org.getInt("id"));
			Integer parentOrg = org.getInt("parent_org");
			node.setpId(parentOrg == null ? OrgModel.ROOT_ORG_ID : parentOrg);
			node.setText(org.getStr("name"));
			node.setChildren(orgTreeChild(org.getInt("id")));			
			node.setExpanded(true);
			trees.add(node);
		}
		renderJson(trees);
	}
	public List<TreeNode> orgTreeChild(Integer id) {
		List<OrgModel> org = OrgModel.dao.getByParent(id);
		List<TreeNode> corgs = new ArrayList<TreeNode>();
		TreeNode node = null;
		if (org != null) {
			for (OrgModel porg : org) {
				node = new TreeNode();
				node.setId(porg.getInt("id"));
				node.setText(porg.getStr("name"));
				node.setChildren(orgTreeChild(porg.getInt("id")));
				node.setExpanded(true);
				corgs.add(node);
			}
		}
		return corgs;
	}

	// 激活&冻结组织
	public void active() {
		OrgModel org = new OrgModel();
		org.set("id", getParaToInt("id"));
		Integer active = getParaToInt("active");
		if (active == Status.NORMAL.getStatus()) {
			org.set("active", Status.NOT_ENABLED.getStatus());
		} else if (active == Status.NOT_ENABLED.getStatus()) {
			org.set("active", Status.NORMAL.getStatus());
		} else if (active == Status.LOCKED.getStatus()) {
			org.set("active", Status.NORMAL.getStatus());
		}
		boolean bool = org.update();
		renderJson(JsonMessage.message(bool));
	}

	@Before(Tx.class)
	public void save() {
		OrgModel norg = new OrgModel();
		norg.set("active", getPara("active"));
		norg.set("desc", getPara("desc"));
		norg.set("fullname", getPara("fullname"));
		norg.set("name", getPara("name"));
		norg.set("type", getPara("type"));
		norg.set("parent_org", getParaToInt("parent_org")==null?OrgModel.ROOT_ORG_ID:getParaToInt("parent_org"));	
		boolean bool = norg.save();
		renderJson(JsonMessage.message(bool));

	}

	public void update() {
		OrgModel norg = new OrgModel();
		norg.set("id", getPara("id"));
		norg.set("active", getPara("active"));
		norg.set("desc", getPara("desc"));
		norg.set("fullname", getPara("fullname"));
		norg.set("name", getPara("name"));
		norg.set("type", getPara("type"));
		norg.set("parent_org", getParaToInt("parent_org")==null?OrgModel.ROOT_ORG_ID:getParaToInt("parent_org"));		
		boolean bool = norg.update();
		renderJson(JsonMessage.message(bool));
	}

	public void delete() {
//		OrgModel org = new OrgModel();
//		org.set("id", getParaToInt("id"));
//		org.set("active", Status.DELETED.getStatus());
//		boolean rbool = org.update();
//		renderJson(JsonMessage.message(rbool));
		boolean bool = OrgModel.dao.deleteById(getParaToInt());		
		renderJson(JsonMessage.message(bool));

	}

	public void deleteBatch() {
//		int rbool = Db.update(
//				"update sys_org set active=" + Status.DELETED.getStatus() + " where id in(" + getPara("ids") + ")");
//		renderJson(JsonMessage.message(rbool));
		int bool = Db.update("delete from sys_org where id in("+getPara("ids")+")");		
		renderJson(JsonMessage.message(bool));
	}
}
