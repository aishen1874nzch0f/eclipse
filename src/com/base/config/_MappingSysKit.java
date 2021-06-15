package com.base.config;

import com.base.flow.entity.DictItem;
import com.base.flow.entity.DictModel;
import com.base.shiro.entity.OrgModel;
import com.base.shiro.entity.ResModel;
import com.base.shiro.entity.RoleModel;
import com.base.shiro.entity.UserModel;
import com.jdjt.dams.entity.DocCateModel;
import com.jdjt.dams.entity.DocCateRangeModel;
import com.jdjt.dams.entity.DocNoModel;
import com.jdjt.dams.entity.DocumentModel;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;


public class _MappingSysKit {
	
	/**
	 * 系统表和Model统一映射
	 * @param arp
	 */
	public static void mapping(ActiveRecordPlugin arp) {		

		//系统权限，角色等表
		arp.addMapping("sys_user", UserModel.class);  
	    arp.addMapping("sys_role", RoleModel.class);	
	    arp.addMapping("sys_res", ResModel.class);
	    arp.addMapping("sys_org", OrgModel.class);	
	    arp.addMapping("sys_dictionary", DictModel.class);
	    arp.addMapping("sys_dictitem", DictItem.class);
	    //档案管理相关表
	    arp.addMapping("da_doc_profile", DocumentModel.class);	
	    arp.addMapping("da_categories_ident", DocCateModel.class);	
	    arp.addMapping("da_categories_range", DocCateRangeModel.class);
	    arp.addMapping("da_doc_no", DocNoModel.class);		    
	    
	}

}
