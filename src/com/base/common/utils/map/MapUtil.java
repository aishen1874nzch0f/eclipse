package com.base.common.utils.map;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;

public class MapUtil {
	//封装成Map
	public static Map<String,Object> toMap(String key,Object obj){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put(key, obj);
		return map;
	}
	
	//封装成Map
		public static Map<String,Object> toModel(String key,Page<?> model){
			Map<String,Object> map=new HashMap<String,Object>();
			map.put(key, model.getList());
			return map;
		}
	
	//封装成Map
	public static Map<String,Object> toListMap(String key,List<?> list){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put(key, list);
		return map;
	}
	
}
