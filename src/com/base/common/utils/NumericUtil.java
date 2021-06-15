package com.base.common.utils;

import java.util.regex.Pattern;

/**
 * * <p>Title:NumericUtil </p>
* <p>Description:DAMS </p>
* <p>Company: XX公司</p> 
* @author amy
* @date 2016年1月25日下午11:58:15
 */
public class NumericUtil {
	public static boolean isNumeric(String str){   
	    Pattern pattern = Pattern.compile("[0-9]*");   
	    return pattern.matcher(str).matches();      
	}  
}
