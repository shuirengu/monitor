package com.hunca.commom.utils;

import javax.servlet.http.HttpServletRequest;

public class LoggerUtils {

	// 日志返回实体key
	public static final String LOGGER_RETURN = "LOGGER_RETURN";

	public static String getCliectIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		// 多个路由时，取第一个非unknown的ip
		final String[] arr = ip.split(",");
		for (final String str : arr) {
			if (!"unknown".equalsIgnoreCase(str)) {
				ip = str;
				break;
			}
		}
		return ip;
	}

	// 判断是否为ajax请求
	public static String getRequestType(HttpServletRequest request) {
		return request.getHeader("X-Requested-With");
	}
}
