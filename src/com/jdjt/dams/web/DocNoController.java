package com.jdjt.dams.web;

import java.util.Map;

import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.jdjt.dams.entity.DocNoModel;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

public class DocNoController extends Controller {

	public void index() {

		render("docNoList.jsp");
	}

	public void docNoList() {

		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<DocNoModel> docList = DocNoModel.dao.paginate(pageNumber, pageSize);
		Map<String, Object> map = MapUtil.toModel("rows", docList);
		map.put("results", docList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);
	}	

	public void save() {
		DocNoModel docIn = new DocNoModel();
		docIn.set("seq", getPara("seq"));
		docIn.set("item", getPara("item"));
		docIn.set("length", getParaToInt("length")==null?4:getParaToInt("length"));
		docIn.set("split", getPara("split"));
		docIn.set("cate_identity", getParaToInt("cate_identity"));
		boolean bool = docIn.save();
		renderJson(JsonMessage.message(bool));
	}

	public void update() {
		DocNoModel docIn = new DocNoModel();
		docIn.set("id", getPara("id"));
		docIn.set("seq", getPara("seq"));
		docIn.set("item", getPara("item"));
		docIn.set("length",getParaToInt("length")==null?4:getParaToInt("length"));
		docIn.set("split", getPara("split"));
		docIn.set("cate_identity", getPara("cate_identity"));		
		boolean bool = docIn.update();
		renderJson(JsonMessage.message(bool));
	}

	public void deleteBatch() {

		int bool = Db.update("delete from da_doc_no where id in(" + getPara("ids") + ")");
		renderJson(JsonMessage.message(bool));
	}

}