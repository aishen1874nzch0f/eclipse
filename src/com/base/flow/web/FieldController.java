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
package com.base.flow.web;


import com.base.flow.entity.Field;
import com.base.flow.entity.Form;
import com.jfinal.core.Controller;

/**
 * FieldController
 * @author yuqs
 * @since 0.1
 */
public class FieldController extends Controller {
	public void index() {
		int formId = getParaToInt();
		setAttr("form", Form.dao.findById(formId));
		setAttr("fields", Field.dao.find("select * from df_field where formId=?", formId));
		render("fieldList.jsp");
	}
}
