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


import java.util.Map;

import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.base.flow.entity.DictItem;
import com.base.flow.entity.DictModel;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

	
/**
 * DictController
 * @author xpg
 * @since 0.1
 */
public class DictController extends Controller {
	//保存当前修改字典编号
	public static int DICT_ID=0;
	public void index() {

		render("dictList.jsp");
	}
	public void dictItemList(){	
//		int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber=(getParaToInt("pageIndex")!=0)?getParaToInt("pageIndex")+1:1;		
		int pageSize=(getParaToInt("limit")!=0)?getParaToInt("limit"):10;		
		Page<DictModel> dictItemList= DictModel.dao.dictItemPaginate(pageNumber,pageSize,DICT_ID,getPara("name"));
		Map<String, Object> map=MapUtil.toModel("rows", dictItemList);
//		map.put("rows",goodsModelList.getList() );
		map.put("results",dictItemList.getTotalRow());
		map.put("hasError", false);		
		renderJson(map);
		
	}
	public void dictList(){	
//		int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber=(getParaToInt("pageIndex")!=0)?getParaToInt("pageIndex")+1:1;		
		int pageSize=(getParaToInt("limit")!=0)?getParaToInt("limit"):10;		
		Page<DictModel> dictList= DictModel.dao.dictPaginate(pageNumber,pageSize,getPara("name"));
		Map<String, Object> map=MapUtil.toModel("rows", dictList);
//		map.put("rows",goodsModelList.getList() );
		map.put("results",dictList.getTotalRow());
		map.put("hasError", false);		
		renderJson(map);
		
	}		
	public void itemConfig() {
		DICT_ID=getParaToInt(0,1);
		setAttr("dictId", DICT_ID);
		render("dictItemList.jsp");
	}	
	//字典项保存
	public void save() {
		DictItem model = new DictItem();
		model.set("code", getPara("code"));
		model.set("name", getPara("name"));
		model.set("desc", getPara("desc"));
		model.set("dict_id",DICT_ID);
		model.set("seq", getPara("seq"));
		boolean bool = model.save();
		renderJson(JsonMessage.message(bool));	
	}
	//字典保存
	public void dictSave() {
		DictModel model = new DictModel();
		model.set("cnName", getPara("cnName"));
		model.set("desc", getPara("desc"));
		model.set("name", getPara("name"));		
		boolean bool = model.save();
		renderJson(JsonMessage.message(bool));
	}
	//字典项更新
	public void update() {
		DictItem model = new DictItem();
		model.set("id", getPara("id"));
		model.set("code", getPara("code"));
		model.set("name", getPara("name"));
		model.set("desc", getPara("desc"));
		model.set("dict_id",DICT_ID);
		model.set("seq", getPara("seq"));
		boolean bool = model.update();
		renderJson(JsonMessage.message(bool));
	}
	//字典更新
	public void dictUpdate() {
		DictModel model = new DictModel();
		model.set("id", getPara("id"));
		model.set("cnName", getPara("cnName"));
		model.set("desc", getPara("desc"));
		model.set("name", getPara("name"));
		boolean bool = model.update();
		renderJson(JsonMessage.message(bool));
	}
	//字典删除，同时删除字典项
	@Before(Tx.class)
	public void casDelete() {		
		int bool=DictItem.dao.deleteByDictId(getParaToInt("ids"));
		boolean res=DictModel.dao.deleteById(getParaToInt("ids"));
		if(bool>=0&&res){
			renderJson(JsonMessage.message(res));
		}
				
	}
	//仅删除字典项
	public void deleteBatch() {		
		int bool =Db.update("delete from sys_dictitem where id in("+getPara("ids")+")");
		renderJson(JsonMessage.message(bool));		
	}
}


