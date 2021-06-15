package com.base.common.utils.net;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;

public class HttpGet {
	
	/**
	 * 默认按照UTF-8读取
	 * @param url
	 * @return
	 */
	public static String get(String url) {
		return get(url, "UTF-8");
	}
	
	public static String get(String url, Map<String, String> reqsProperty) {
		return get(url, "UTF-8", reqsProperty);
	}
	
	/**
	 * 按照charset格式编码读取
	 * @param url
	 * @param charset 接收编码
	 * @return
	 */
	public static String get(String url, String charset) {
		String target = "";
		try {
			URL add = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) add.openConnection();
			connection.setUseCaches(false);// 设置非缓存 避免多次请求不能取到最新数据
			connection.setRequestMethod("GET");// 请求方式
			connection.connect();
			// 获取响应字节流
			InputStream stream = connection.getInputStream();
			// 将流转换成reder
			BufferedReader reader = new BufferedReader(new InputStreamReader(stream, charset));
			String temp = null;
			while ((temp = reader.readLine()) != null) {
				target += temp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return target;
	}
	
	/**
	 * 按照charset格式编码读取
	 * @param url	
	 * @param charset	接收编码
	 * @param reqsProperty	RequestProperty包头设置参数
	 * @return
	 */
	
	public static String get(String url, String charset, Map<String, String> reqsProperty) {
		String target = "";
		try {
			URL add = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) add.openConnection();
			connection.setUseCaches(false);// 设置非缓存 避免多次请求不能取到最新数据
			connection.setRequestMethod("GET");// 请求方式
			if (!reqsProperty.isEmpty()) {
				Iterator<String> ite = reqsProperty.keySet().iterator();
				while (ite.hasNext()) {
					String key = ite.next() + "";
					connection.setRequestProperty(key, reqsProperty.get(key) + "");
				}
			}
			connection.connect();
			// 获取响应字节流
			InputStream stream = connection.getInputStream();
			// 将流转换成reder
			BufferedReader reader = new BufferedReader(new InputStreamReader(stream, charset));
			String temp = null;
			while ((temp = reader.readLine()) != null) {
				target += temp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return target;
	}
}
