package com.base.config;
import org.snaker.jfinal.plugin.SnakerPlugin;

import com.alibaba.druid.filter.stat.StatFilter;
import com.base.app.handler.MyInterceptor;
import com.base.app.handler.SessionHandler;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.druid.DruidStatViewHandler;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;

public class BaseConfig extends JFinalConfig 
{

	// 设置视图,默认就是jsp
	
	public void configConstant(Constants me) 
	{
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("config.properties");	
		me.setDevMode(false);		
		me.setEncoding("UTF-8");
		me.setViewType(ViewType.JSP);
		me.setError404View("/common/404.jsp");
		me.setError403View("/common/403.jsp");
		me.setError500View("/common/500.jsp");				
	}

	// 配置访问路径：如struts2里面的actionXML配置
	
	public void configRoute(Routes me) 
	{
		
		//后台
		me.add(new AdminRoutes());
		
	}

	// 配置数据库
	
	public void configPlugin(Plugins me) 
	{
		// 加载数据库
		DruidPlugin dams = new DruidPlugin(PropKit.get("url"), PropKit.get("username"),
				PropKit.get("password").trim(), PropKit.get("driver"));
		
//		//添加拦截器
		dams.addFilter(new StatFilter());
//		WallFilter wall = new WallFilter();
//		wall.setDbType(JdbcConstants.POSTGRESQL);
		//加强sql规范
		//加载数据库连接池插件
	    me.add(dams);
	    
	    ScriptsPlugin scriptsPlugin = new ScriptsPlugin(dams);
		me.add(scriptsPlugin);
	    
	    ActiveRecordPlugin damsarp = new ActiveRecordPlugin(dams);
	    damsarp.setShowSql(true);		
	    me.add(damsarp);	
	    _MappingSysKit.mapping(damsarp);
	    
	    	
//	    // orcl数据库
//	    DruidPlugin xiaoai = new DruidPlugin(PropKit.get("orcl_url"), PropKit.get("orcl_username"), 
//	    		PropKit.get("orcl_password"), PropKit.get("orcl_driver"));
//	    //加载数据库连接池插件
//	    me.add(xiaoai);
//	    //数据库分组
//	    ActiveRecordPlugin xiaoaiarp = new ActiveRecordPlugin(cws);
//	    xiaoaiarp.setShowSql(true);		
//	    me.add(xiaoaiarp);
//	    // 用户信息表
//	    xiaoaiarp.addMapping("sys_p_user", SysPUserModel.class);
//	    xiaoaiarp.addMapping("zk_car_archives", ZkCarArchivesModel.class);
//	    xiaoaiarp.addMapping("zk_customer_info", ZkCustomerInfoModel.class);
//	    xiaoaiarp.addMapping("zk_xa_user_account", ZkXaUserAccountModel.class);
	    // 配置Snaker插件
	 	SnakerPlugin snakerPlugin = new SnakerPlugin(dams, PropKit.use("config.properties").getProperties());
	 	me.add(snakerPlugin);	 	
	}

	// 全局 拦截器
	
	public void configInterceptor(Interceptors me) 
	{
		me.add(new MyInterceptor());
	}

	// 设置Handler
	
	public void configHandler(Handlers me) 
	{
		//设置
		DruidStatViewHandler dvh =  new DruidStatViewHandler("/druid");
		
		me.add(dvh);
		 // 去掉 jsessionid 防止找不到action
        me.add(new SessionHandler());
        me.add(new ContextPathHandler("ctx"));
	}

	public static void main(String[] args) {
		JFinal.start("WebRoot", 80, "/", 5);
	}

	@Override
	public void configEngine(Engine me) {
		// TODO 自动生成的方法存根
		
	}
}