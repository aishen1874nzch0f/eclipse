package com.jdjt.dams.entity;



import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class DocNoModel extends Model<DocNoModel> {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6172387360981248582L;
	public static final DocNoModel dao =new DocNoModel();	
	
	public Page<DocNoModel> paginate(int pageNumber,int pageSize){
		String sql = "from da_doc_no d left join da_categories_ident dt on dt.id=d.cate_identity order by d.id asc";
		return paginate(pageNumber, pageSize,"select d.*,dt.name", sql);	
	}
}
