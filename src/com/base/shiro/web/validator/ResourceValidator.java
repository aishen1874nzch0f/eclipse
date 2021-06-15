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



import com.base.shiro.entity.ResModel;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * ResourceValidator.
 */
public class ResourceValidator extends Validator {
	
	@Override
	protected void validate(Controller controller) {
		validateRequiredString("res.name", "nameMsg", "请输入资源名称!");
		validateRequiredString("res.url", "sourceMsg", "请输入资源值!");
	}
	
	@Override
	protected void handleError(Controller controller) {
		controller.keepModel(ResModel.class);
		
		String actionKey = getActionKey();
		if (actionKey.equals("/shiro/res/save"))
			controller.render("resAdd.jsp");
		else if (actionKey.equals("/shiro/res/update"))
			controller.render("resAdd.jsp");
	}
}
