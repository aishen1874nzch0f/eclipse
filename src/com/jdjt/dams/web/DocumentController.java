package com.jdjt.dams.web;

import java.util.List;
import java.util.Map;

import com.base.app.AbstractJsonController;
import com.base.common.utils.JsonMessage;
import com.base.common.utils.map.MapUtil;
import com.jdjt.dams.entity.DocumentModel;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

public class DocumentController extends AbstractJsonController {
	DocumentModel docsModel = new DocumentModel();
	// DocumentModel docModel=null;
	// 默认

	public void index() {
		// DocumentModel docModel =new DocumentModel();
		// setAttr("docModel", docModel);
		setAttr("years", docsModel.getYearOfDoc());
		setAttr("authors", docsModel.getAuthorOfDoc());
		render("docList.jsp");
	}
	public void doctree() {
		// DocumentModel docModel =new DocumentModel();
		// setAttr("docModel", docModel);
		setAttr("years", docsModel.getYearOfDoc());
		setAttr("authors", docsModel.getAuthorOfDoc());
		render("docTreeList.jsp");
	}
	public void docList() {

		//DocumentModel doc=getModel(DocumentModel.class,"docmodel");		
		int pageNumber = (getParaToInt("pageIndex") != null) ? getParaToInt("pageIndex") + 1 : 1;
		int pageSize = (getParaToInt("limit") != null) ? getParaToInt("limit") : 10;
		Page<DocumentModel> docList = docsModel.paginate(pageNumber, pageSize,getPara("name"),getPara("arch_date"),getPara("author"));
		Map<String, Object> map = MapUtil.toModel("rows", docList);
		// map.put("rows",goodsModelList.getList() );
		map.put("results", docList.getTotalRow());
		map.put("hasError", false);
		renderJson(map);
	}

	public void jsonYears() {

		List<DocumentModel> years = docsModel.getYearOfDoc();
		Map<String, Object> map = MapUtil.toListMap("rows", years);
		map.put("results", docsModel.getYearOfDoc());
		map.put("hasError", false);
	}

	/**
	 * 添加页面
	 */
	public void add() {
		render("docAdd.jsp");
	}

	/**
	 * 添加文书
	 */
	public void save() {

//		UploadFile upfile=getFile(getPara("file_path"),"d:/dams");
//		String fileName = "d:/dams/" + upfile.getFileName();
		DocumentModel doc = getModel(DocumentModel.class, "docModel");		
//		System.out.println("------------"+fileName);
//		doc.set("file_path", fileName);
		Long id = DocumentModel.dao.generateId();
		if (doc.get("id") == null) {
			doc.set("id", id);
		}
		if (!doc.save()) {
			render("docAdd.jsp");
		}
		redirect("/ms/doc");
	}

	/**
	 * 修改页面
	 */
	public void edit() {
		DocumentModel doc =DocumentModel.dao.findById(getParaToInt());
		setAttr("docModel", doc);
//		setAttr("file_path",doc.get("file_path"));
		render("docEdit.jsp");
	}

	// 修改方法
	public void update() {
//		getFile(getPara("file_path"),"d:/dams");
		getModel(DocumentModel.class, "docModel").update();
		redirect("/ms/doc");
	}	
	public void delete(){		
		
		boolean bool = DocumentModel.dao.deleteById(getParaToInt());		
		renderJson(JsonMessage.message(bool));
	}	
	public void deleteBatch(){
		
//		String[] ides =getParaValues("ids");		
		int bool = Db.update("delete from da_doc_profile where id in("+getPara("ids")+")");		
		renderJson(JsonMessage.message(bool));
	}	
}
