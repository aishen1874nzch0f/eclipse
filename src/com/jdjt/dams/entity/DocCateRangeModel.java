package com.jdjt.dams.entity;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 分类
 * @author Administrator
 *
 */
public class DocCateRangeModel extends Model<DocCateRangeModel>{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8339836013055677035L;
	public static final DocCateRangeModel dao=new DocCateRangeModel();
	public static final Integer ROOT_NODE = 0;	
	
	/**
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param range
	 * @return
	 */
	public Page<DocCateRangeModel> getCateRangeList(int pageNumber, int pageSize, String range) {
		String sql = " from da_categories_range";
		if(StringUtils.isNotEmpty(range)) {
			sql += " where range_da like '%" + range + "%' ";
		}
		sql += " order by id asc";
		return paginate(pageNumber, pageSize, "select *", sql);
	}	
}
