/*
 *  Copyright 2014-2015 snakerflow.com
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *     http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *
 */
package com.base.shiro.web.validator;


import com.base.shiro.entity.UserModel;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * UserValidator.
 */
public class UserValidator extends Validator {
	
	@Override
	protected void validate(Controller controller) {
		validateRequiredString("userName", "usernameMsg", "请输入用户名称!");
		validateRequiredString("passWord", "passwordMsg", "请输入密码!");
	}
	
	@Override
	protected void handleError(Controller controller) {
		controller.keepModel(UserModel.class);
		
		String actionKey = getActionKey();
		System.out.println("actionKey=>" + actionKey);
		if (actionKey.equals("/ms/shiro/user/save"))
			controller.render("userAdd.jsp");		
		else if (actionKey.equals("/ms/shiro/user/update"))
			controller.render("userEdit.jsp");
	}
}
