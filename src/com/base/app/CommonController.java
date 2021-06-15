package com.base.app;

import java.util.List;

import com.jdjt.dams.entity.DocumentModel;
import com.jfinal.core.Controller;

public class CommonController extends Controller {
	
	public void computer() {
		render("computer.jsp");
	}
	public void defaults() {
		render("defaults.jsp");
	}
	public void error() {
		render("error.jsp");		
	}	
	public void imgtable() {
		render("imgtable.jsp");
	}
	public void form() {
		render("form.jsp");
	}
	public void imglist() {
		render("imglist.jsp");
	}
	public void imglist1() {
		render("imglist1.jsp");
		
	}	
	public void right() {
		render("right.jsp");
	}
	public void tab() {
		render("tab.jsp");
	}
	public void tools() {
		render("tools.jsp");
	}
	public void filelist() {
		render("filelist.jsp");
	}	
	public void buiOpenGridTest() {
		render("buiOpenGridTest.jsp");
	}
	public void workSpace() {
		render("workSpace.jsp");			
	}
	public void tongjiAjax(){
		List<DocumentModel> list = DocumentModel.dao.wenShuList();		
		//System.out.println(list);
		renderJson(list);	
	}
}
