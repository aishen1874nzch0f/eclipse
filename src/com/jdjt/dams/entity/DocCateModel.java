package com.jdjt.dams.entity;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 分类
 * @author Administrator
 *
 */
public class DocCateModel extends Model<DocCateModel>{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8339836013055677035L;
	public static final DocCateModel dao=new DocCateModel();
	public static final Integer ROOT_NODE = 0;
	
	public Page<DocCateModel> paginate(int pageNumber, int pageSize, String name) {
		
		String sql = "from da_categories_ident d LEFT JOIN da_categories_ident dt ON dt.id=d.P_id";
		if(StringUtils.isNotEmpty(name)) {
			sql += " where d.name like '%" + name + "%' ";
		}
		sql += " order by d.id asc";
		return paginate(pageNumber, pageSize, "select d.*,dt.`name` as pname", sql);
	}
	//获取根节点
	public List<DocCateModel> getNodeList(String name,Integer root) {
		
		String sql = "select * from da_categories_ident where p_id="+root+" and name like '%"+name+"%' order by id asc";		
		return DocCateModel.dao.find(sql);
	}
	//获取根节点下面所有children
	public List<DocCateModel> getChildList(Integer pid) {
		String sql = "select * from da_categories_ident where p_id='"+pid+"'";			
		return DocCateModel.dao.find(sql);
	}	
}
