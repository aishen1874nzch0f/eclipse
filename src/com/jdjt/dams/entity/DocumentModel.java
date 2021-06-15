package com.jdjt.dams.entity;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;


public class DocumentModel extends Model<DocumentModel> {

	
	private static final long serialVersionUID = 2997556576075840376L;
	
	public static final DocumentModel dao=new DocumentModel();
	//文件列表
	public Page<DocumentModel> paginate(Integer pageNumber,Integer pageSize,String name,String arch_date,String author){
		String sql = "from da_doc_profile";
		boolean bool=false;
		
		if(StringUtils.isNotEmpty(name)) {
			sql += " where name like '%" + name + "%' ";
			bool=true;
		}		
		if(StringUtils.isNotEmpty(author))
		{
			if(bool){
				sql += " and author = '" + author + "' ";
			}
			else{
				sql += " where author = '" + author + "' ";
				bool=true;
			}
			
		}
		if(StringUtils.isNotEmpty(arch_date))
		{
			if(bool){
			sql += " and arch_date = '" + arch_date + "' ";
			}
			else{
				sql += " where arch_date = '" + arch_date + "' ";
			}
		}		
		sql += " order by id asc";
		return paginate(pageNumber, pageSize,"select *", sql);	
	}		
	//获得所有年份列表
	public List<DocumentModel> getYearOfDoc() {
		// TODO Auto-generated method stub
		return dao.find("select distinct arch_date from da_doc_profile");
	}
	//获得所有文号责任人
	public List<DocumentModel> getAuthorOfDoc() {
		// TODO Auto-generated method stub
		return dao.find("select distinct author from da_doc_profile");
	}
	/**
	 * 获得字段Id最大值，并加1
	 * @return
	 */
	public Long generateId() {
		
		return	 dao.findFirst("select case  when max(id) IS NULL then 1 else max(id)+1 end as id from da_doc_profile").getLong("id");
			
		
	}
	//统计文书图表
	public List<DocumentModel> wenShuList(){		
		String sql="select arch_date,count(*) as num from da_doc_profile group by arch_date";
		return dao.find(sql);
	}
	

}
