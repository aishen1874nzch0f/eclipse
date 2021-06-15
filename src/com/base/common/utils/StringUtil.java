package com.base.common.utils;

import java.util.Random;

public class StringUtil {
	
	/**
	 * 判断字符串是否为空
	 * @param str
	 * @return
	 */
	public static boolean isNull(String str) {
		if (str == null || "".equals(str.trim()) || "null".equalsIgnoreCase(str))
        {
            return true;
        }
        return false;
	}
	/**
	 * 判断字符串不为空
	 * @param str
	 * @return
	 */
	
	public static boolean isNoNullorEmpty(String str) {
		if (str != null ||"".equals(str)||"null".equalsIgnoreCase(str))
        {
            return true;
        }
        return false;
	}
	
	/**
	 * 判断对象是否为空
	 * @param obj
	 * @return
	 */
	public static boolean isNull(Object obj) {
		if (obj == null)
        {
            return true;
        }
        if (obj instanceof String)
        {
            return isNull((String) obj);
        }
        return false;
	}
	
	/**
	 * 生成指定长度的随机码
	 * @param length 随机码长度 
	 * @return
	 * @throws Exception 
	 */
	public static String random(int length) throws Exception
	{
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";     
	    Random random = new Random();     
	    StringBuffer sb = new StringBuffer();     
	    for (int i = 0; i < length; i++) {     
	        int number = random.nextInt(base.length());     
	        sb.append(base.charAt(number));     
	    }     
	    return sb.toString();     
	}
}
