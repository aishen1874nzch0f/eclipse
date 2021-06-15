package com.base.app.handler;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * 自定义拦截器，非法URL以及访问控制
 * @author Administrator
 *
 */
public class MyInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {	
       //
            inv.invoke();
	}

}
