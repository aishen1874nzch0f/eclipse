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
package com.base.flow.strategy;

import java.util.List;

import org.snaker.engine.impl.GeneralAccessStrategy;

import com.base.shiro.ShiroUtils;



/**
 * 自定义访问策略，根据操作人获取其所有组集合（部门、角色、权限）
 * @author yuqs
 * @since 0.1
 */
public class CustomAccessStrategy extends GeneralAccessStrategy {
	@Override
	protected List<String> ensureGroup(String operator) {
		return ShiroUtils.getGroups();
	}
}
