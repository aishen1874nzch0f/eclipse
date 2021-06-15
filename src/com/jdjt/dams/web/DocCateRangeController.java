package com.jdjt.dams.web;

import java.util.Map;

import com.base.app.AbstractJsonController;
import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.jdjt.dams.entity.DocCateModel;
import com.jdjt.dams.entity.DocCateRangeModel;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;


/**
 * ResourceController
 * 
 * @author xpg
 * @since 0.1
 */
public class DocCateRangeController extends AbstractJsonController {
	public void index() {
		render("docCateRangeList.jsp");
	}

	public void docCateRangeList() {

		// DocumentModel doc=getModel(DocumentModel.class,"docModel");
		// int start=(getParaToInt("start")!=0)?getParaToInt("start"):1;
		int pageNumber = (getParaToInt("pageIndex") != 0) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != 0) ? getParaToInt("limit") : 10;
		Page<DocCateRangeModel> docList = DocCateRangeModel.dao.getCateRangeList(pageNumber, pageSize, getPara("name"));
		Map<String, Object> map = MapUtil.toModel("rows", docList);
		// map.put("rows",goodsModelList.getList() );
		map.put("results", docList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);
	}	

	public void add() {
		render("docCateAdd.jsp");
	}

	public void edit() {
		setAttr("docCate", DocCateModel.dao.findById(getParaToInt()));
		render("docCateEdit.jsp");
	}

	public void view() {
		setAttr("docCate", DocCateModel.dao.findById(getParaToInt()));
		render("docCateView.jsp");
	}

	
	public void save() {
		DocCateRangeModel docCateRange =new DocCateRangeModel();		
		docCateRange.set("fir_identity", getPara("fir_identity"));
		docCateRange.set("fir_categories", getPara("fir_categories"));	
		docCateRange.set("sec_identity", getPara("sec_identity"));
		docCateRange.set("sec_categories", getPara("sec_categories"));
		docCateRange.set("range_da", getPara("range_da"));
		docCateRange.set("remark", getPara("remark"));
		boolean bool=docCateRange.save();
		renderJson(JsonMessage.message(bool));
	}

	
	public void update() {
		DocCateRangeModel docCateRange =new DocCateRangeModel();
		docCateRange.set("id", getPara("id"));
		docCateRange.set("fir_identity", getPara("fir_identity"));
		docCateRange.set("fir_categories", getPara("fir_categories"));	
		docCateRange.set("sec_identity", getPara("sec_identity"));
		docCateRange.set("sec_categories", getPara("sec_categories"));
		docCateRange.set("range_da", getPara("range_da"));
		docCateRange.set("remark", getPara("remark"));
		boolean bool=docCateRange.update();
		renderJson(JsonMessage.message(bool));
	}

	public void delete() {
		DocCateRangeModel.dao.deleteById(getParaToInt());
		redirect("/ms/docCate");
	}

	public void deleteBatch() {

		int bool = Db.update("delete from da_categories_range where id in(" + getPara("ids") + ")");
		renderJson(JsonMessage.message(bool));
	}
}
