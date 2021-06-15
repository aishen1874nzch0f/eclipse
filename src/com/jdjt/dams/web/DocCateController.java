package com.jdjt.dams.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.base.app.AbstractJsonController;
import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.base.shiro.entity.TreeNode;
import com.jdjt.dams.entity.DocCateModel;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

/**
 * ResourceController
 * 
 * @author xpg
 * @since 0.1
 */
public class DocCateController extends AbstractJsonController {
	public void index() {
		render("docCateList.jsp");
	}

	// 检索数据，数据列表
	public void docCateList() {
		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<DocCateModel> docCateList = DocCateModel.dao.paginate(pageNumber, pageSize, getPara("name"));
		Map<String, Object> map = MapUtil.toModel("rows", docCateList);
		map.put("results", docCateList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);
	}

	// 文件分类列表树形式
	public void docCateTreeList() {
		String name = getPara("name") == null ? "" : getPara("name");
		List<DocCateModel> menuList = DocCateModel.dao.getNodeList(name, DocCateModel.ROOT_NODE);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		TreeNode ctnode = null;
		for (DocCateModel fnode : menuList) {
			if (fnode.getInt("p_id") == DocCateModel.ROOT_NODE) {
				node = new TreeNode();
				node.setId(fnode.getInt("id"));
				node.setText(fnode.getStr("name"));
				List<TreeNode> ctrees = new ArrayList<TreeNode>();
				for (DocCateModel cnode : menuList) {
					if (cnode.getInt("p_id") == fnode.getInt("id")) {
						ctnode = new TreeNode();
						ctnode.setId(cnode.getInt("id"));
						ctnode.setText(cnode.getStr("name"));
						ctrees.add(ctnode);
						node.setChildren(ctrees);
					}
				}

				trees.add(node);
			}
		}
		renderJson(trees);
	}

	// 文件分类树
	public void docCateTreeOld() {
		String name = getPara("name") == null ? "" : getPara("name");
		List<DocCateModel> menuList = DocCateModel.dao.getNodeList(name, DocCateModel.ROOT_NODE);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		TreeNode ctnode = null;
		for (DocCateModel fnode : menuList) {
			if (fnode.getInt("p_id") == DocCateModel.ROOT_NODE) {
				node = new TreeNode();
				node.setId(fnode.getInt("id"));
				node.setText(fnode.getStr("name"));
				node.setExpanded(true);
				List<TreeNode> ctrees = new ArrayList<TreeNode>();
				for (DocCateModel cnode : menuList) {
					if (cnode.getInt("p_id") == fnode.getInt("id")) {
						ctnode = new TreeNode();
						ctnode.setId(cnode.getInt("id"));
						ctnode.setText(cnode.getStr("name"));
						ctrees.add(ctnode);
						node.setChildren(ctrees);
					}
				}
				trees.add(node);
			}
		}
		renderJson(trees);
	}

	// 树结构
	public void docCateTree() {
		String name = getPara("name") == null ? "" : getPara("name");
		List<DocCateModel> menuList = DocCateModel.dao.getNodeList(name, DocCateModel.ROOT_NODE);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		for (DocCateModel fnode : menuList) {
			if (menuList != null && !menuList.equals(null)) {
				node = new TreeNode();
				node.setId(fnode.getInt("id"));
				node.setText(fnode.getStr("name"));
				node.setExpanded(true);
				node.setChildren(docCateTreeBuild(fnode.getInt("id")));
				trees.add(node);
			}
		}
		renderJson(trees);
	}

	// 递归获得所有子节点
	public List<TreeNode> docCateTreeBuild(Integer pid) {

		List<DocCateModel> menuList = DocCateModel.dao.getChildList(pid);
		List<TreeNode> trees = new ArrayList<TreeNode>();
		TreeNode node = null;
		for (DocCateModel cnode : menuList) {
			if (menuList != null && !menuList.equals(null)) {
				node = new TreeNode();
				node.setId(cnode.getInt("id"));
				node.setText(cnode.getStr("name"));
				node.setExpanded(false);
				node.setChildren(docCateTreeBuild(cnode.getInt("id")));
				trees.add(node);
			}
		}
		return trees;
	}

	public void view() {
		setAttr("docCate", DocCateModel.dao.findById(getParaToInt()));
		render("docCateView.jsp");
	}

	public void save() {
		DocCateModel docCate = new DocCateModel();
		docCate.set("identity", getPara("identity"));
		docCate.set("name", getPara("name"));
		docCate.set("p_id", getParaToInt("p_id")==null?DocCateModel.ROOT_NODE:getParaToInt("p_id"));
		boolean bool = docCate.save();
		renderJson(JsonMessage.message(bool));
	}

	public void update() {
		DocCateModel docCate = new DocCateModel();
		docCate.set("id", getPara("id"));
		docCate.set("identity", getPara("identity"));
		docCate.set("name", getPara("name"));	
		docCate.set("p_id", getParaToInt("p_id")==null?DocCateModel.ROOT_NODE:getParaToInt("p_id"));		
		boolean bool = docCate.update();
		renderJson(JsonMessage.message(bool));
	}

	public void delete() {
		DocCateModel.dao.deleteById(getParaToInt());
	}

	public void deleteBatch() {

		int bool = Db.update("delete from da_categories_ident where id in(" + getPara("ids") + ")");
		renderJson(JsonMessage.message(bool));
	}
}
