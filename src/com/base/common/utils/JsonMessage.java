package com.base.common.utils;

import java.util.HashMap;
import java.util.Map;

public class JsonMessage {

	 public static Map<String,Object> message(boolean bool)
	{
		Map<String, Object> map = new HashMap<>();
		if (bool) {
			// setAttr("msg", "删除成功");


			map.put("success", true);
			map.put("status", 200);
			return map;
		} else {
			// setAttr("msg", "添加失败");


			map.put("success", false);
			map.put("status", 400);
			return map;
		}
	}
	 public static Map<String,Object> message(int bool)
		{
			Map<String, Object> map = new HashMap<>();
			if (bool>0) {
				// setAttr("msg", "删除成功");


				map.put("success", true);
				map.put("status", 200);
				return map;
			} else {
				// setAttr("msg", "添加失败");


				map.put("success", false);
				map.put("status", 400);
				return map;
			}
		}
}