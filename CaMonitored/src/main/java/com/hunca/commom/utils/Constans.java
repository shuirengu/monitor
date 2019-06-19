package com.hunca.commom.utils;

import java.io.File;

public class Constans {

	//定义登录后台用户在session中的键
	public static final String SESSION_SYSUSER = "SESSION_SYSUSER";
	//定义登录客户在session中的键
	public static final String SESSION_CUSTOMER = "SESSION_CUSTOMER";
	
	public static final String SMS_URL = "http://61.187.115.174:8080/HncaSms/services/hncaOnlineSmsSend?wsdl";
	
	public static final String LOGGER_RETURN = "LOGGER_RETURN";
	//签名验证平台
		public static final String SVS_URL="http://61.187.115.171/CAwebservice/HuncaSVSService";
	// 系统相关常量
	public static final int USER_IS_TRUE = 1;// 用户正常使用
	public static final int USER_IS_FASLES = 2;// 用户禁用
	
	// 短信平台用户名
		public static final String SMS_USERNAME = "HNCA";
		
		// 短信平台密码
		public static final String SMS_PASSWORD = "HNCA";
	/**
	 * 日志管理
	 * 操作类型
	 * 0 --> 登陆
	 * 1 --> 增加
	 * 2 --> 删除
	 * 3 --> 更新
	 */
	public static final String OPER_TYPE_LOGIN = "0";
	public static final String OPER_TYPE_INSERT = "1";
	public static final String OPER_TYPE_DELETE = "2";
	public static final String OPER_TYPE_UPDATE = "3";
	
	public static final String UPLOAD_DIR = File.separator + "CAService" + File.separator + "image" + File.separator;

	public static final String DEFINE_ERR = "参数错误或者操作未成功";//返回信息-失败
	public static final int CODE_ERROR = 0;//请求返回码-失败
}
