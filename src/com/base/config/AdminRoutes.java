package com.base.config;



import com.base.app.CommonController;
import com.base.app.IndexController;
import com.base.flow.web.DictController;
import com.base.flow.web.FieldController;
import com.base.flow.web.FlowController;
import com.base.flow.web.FormController;
import com.base.flow.web.ProcessController;
import com.base.flow.web.SnakerController;
import com.base.flow.web.SurrogateController;
import com.base.flow.web.TaskController;
import com.base.shiro.web.AuthController;
import com.base.shiro.web.OrgController;
import com.base.shiro.web.ResController;
import com.base.shiro.web.RoleController;
import com.base.shiro.web.UserController;
import com.jdjt.dams.web.DocCateController;
import com.jdjt.dams.web.DocCateRangeController;
import com.jdjt.dams.web.DocNoController;
import com.jdjt.dams.web.DocumentController;
import com.jfinal.config.Routes;

/**
 * 后端路由
 * @author Administrator
 *
 */
public class AdminRoutes extends Routes {

	@Override
	public void config() {
		add("/",AuthController.class,"view/system");		
		add("/ms",IndexController.class,"view/system");		
		add("/ms/sys/dict",DictController.class,"view/common");
		//档案管理相关路由
		add("/ms/com",CommonController.class,"view/common");
		add("/ms/doc",DocumentController.class,"view/docManager");	
		add("/ms/docCate",DocCateController.class,"view/docManager");	
		add("/ms/docCateRange",DocCateRangeController.class,"view/docManager");	
		add("/ms/docNo",DocNoController.class,"view/docManager");
		//系统权限相关路由
		add("/ms/shiro/user",UserController.class,"view/system/security");		
		add("/ms/shiro/role",RoleController.class,"view/system/security");
		add("/ms/shiro/res",ResController.class,"view/system/security");		
		add("/ms/shiro/org",OrgController.class,"view/system/security");
		//流程相关路由
		add("/ms/flow/task",TaskController.class,"view/flow");		
		add("/ms/flow/field",FieldController.class,"view/flow");
		add("/ms/flow/form",FormController.class,"view/flow");
		add("/ms/flow/flow",FlowController.class,"view/flow");
		add("/ms/flow/process",ProcessController.class,"view/flow");
		add("/ms/flow/snaker",SnakerController.class,"view/flow");
		add("/ms/flow/surrogate",SurrogateController.class,"view/flow");
	}

}