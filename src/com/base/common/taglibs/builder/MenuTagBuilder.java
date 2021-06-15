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
package com.base.common.taglibs.builder;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

import com.base.shiro.ShiroUtils;
import com.base.shiro.entity.ResModel;



/**
 * 自定义菜单标签处理类。 根据当前认证实体获取允许访问的所有菜单，并输出特定导航菜单的html
 * @author yuqs
 * @since 0.1
 */
public class MenuTagBuilder implements TagBuilder {
	public static MenuTagBuilder builder = new MenuTagBuilder();
	// Servlet的上下文
//	private ServletContext servletContext = null;

	@Override
	public String build(TagDTO dto) {
//		this.servletContext = dto.getServletContext();
		StringBuffer buffer = new StringBuffer();
		// 获取所有可允许访问的菜单列表
		List<ResModel> menus = getAllowedAccessMenu();
		
		// 循环迭代菜单列表，构成ID、List结构的Map
		Map<Integer, List<ResModel>> menuMaps = buildMenuTreeMap(menus);
		//System.out.println(menuMaps);
		// 根据Map构造符合左栏菜单显示的html		
		buildMenuTreeFolder(buffer, menuMaps, ResModel.ROOT_MENU);
		return buffer.toString();
	}

	/**
	 * 循环迭代菜单列表，构成ID、List结构的Map
	 * 
	 * @param menus
	 * @return
	 */
	
	private Map<Integer, List<ResModel>> buildMenuTreeMap(List<ResModel> menus) {
		Map<Integer, List<ResModel>> menuMap = new TreeMap<Integer, List<ResModel>>();
		for (ResModel menu : menus) {
			/**
			 * 判断是否有上一级菜单，如果有，则添加到上一级菜单的Map中去 如果没有上一级菜单，把该菜单作为根节点
			 */
			Integer parentMenuId = menu.getInt("pid") == null ? ResModel.ROOT_MENU
					: menu.getInt("pid");
			if (!menuMap.containsKey(parentMenuId)) {
				List<ResModel> subMenus = new ArrayList<ResModel>();
				subMenus.add(menu);
				menuMap.put(parentMenuId, subMenus);
			} else {
				List<ResModel> subMenus = menuMap.get(parentMenuId);
				subMenus.add(menu);
				menuMap.put(parentMenuId, subMenus);
			}
		}
		return menuMap;
	}

	/**
	 * 获取当前登录账号所有允许访问的菜单列表
	 * 
	 * @return
	 */
	private List<ResModel> getAllowedAccessMenu() {
		return ResModel.dao.getAllowedAccessMenus(ShiroUtils.getUserId());
	}

	/**
	 * 构建菜单目录
	 * 
	 * @param buffer
	 *            html信息
	 * @param menuMap
	 * @param menuId,根节点为0
	 */
	private void buildMenuTreeFolder(StringBuffer buffer,
			Map<Integer, List<ResModel>> menuMap, Integer menuId) {
		List<ResModel> treeFolders = menuMap.get(menuId);
		if (treeFolders == null) {
			return;
		}
		for (ResModel menu : treeFolders) {
			List<ResModel> treeNodes = menuMap.get(menu.getInt("id"));
			if((treeNodes == null || treeNodes.isEmpty()) && StringUtils.isEmpty(menu.getStr("name"))) {
				continue;
			}			
			buffer.append("<dd>");
			buffer.append("<div class='title'>");
			buffer.append("<span><img src='"+menu.getStr("icon")+"'/></span>");
			buffer.append(menu.getStr("name"));
			buffer.append("</div>");
			buffer.append("<ul class='menuson'>");				
			/**
			 * 有子菜单时，将子菜单添加到当前节点上
			 */
			buildMenuTreeNode(buffer, treeNodes);
			buffer.append("</ul>");
			buffer.append("</dd>");			
		}
	}
	/**
	 * 循环子菜单资源，并构造tree型html语句
	 * 
	 * @param buffer
	 * @param treeNodes
	 */
	private void buildMenuTreeNode(StringBuffer buffer, List<ResModel> treeNodes) {
		if (treeNodes == null) {
			return;
		}
		for (ResModel menu : treeNodes) {
			buffer.append("<li><cite></cite>");
			buffer.append("<a href='");
			buffer.append(menu.getStr("url"));			
			buffer.append("' target='rightFrame' ");
			buffer.append(">");
			buffer.append(menu.getStr("name"));
			buffer.append("</a>");
			buffer.append("<i></i>");
			buffer.append("</li>");
		}
	}	
}
