package com.base.common.json;

public interface JsonCode {

	/**
	 * 通用编码
	 */
	// 所有的：返回成功
	String SUCCESS = "200000";
	// 权限验证
	String SUCCESS_AUTH = "200001";
	// 系统错误
	String FAIL_SYSTEM_ERRER = "401000";
	// 数据为空
	String FAIL_DATA_NULL = "401001";
	// 操作失败
	String FAIL_OPERATION_FAILED = "401002";
	// 其他错误
	String FAIL_OTHER_MISTAKES = "401003";
	// 参数为空
	String FAIL_PARAMETER_IS_NULL = "401004";
	// 验证码获取60S内
	String FAIL_CODE_TIME = "401005";
	// 验证码获取失败
	String FAIL_CODE_FAILED = "401006";
	// 网络电话APPID错误
	String FAIL_NO_APPID = "401007";
	// 网络电话CLIENT注册失败
	String FAIL_CLIENT_REG = "401008";
	// 网络电话CLIENT获取失败
	String FAIL_CLIENT_GET = "401009";
	// 非法参数
	String FAIL_UNLAWFUL = "401010";
	// 非法操作
	String FAIL_ILLEGEL_OPERATION = "401011";
	/**
	 * 登录状态码
	 */
	// 用户不存在
	String FAIL_NOTEXIST = "400001";
	// 账号或者密码错误
	String FAIL_ACCOUNT_ERROR = "400002";
	// 登录失败
	String FAIL_LOGIN_FAILURE = "400003";
	// 登出失败
	String FAIL_LOGINOUT_FAILURE = "40004";

	/**
	 * 注册状态码
	 */
	// 用户不合法
	String FAIL_USER_IS_NOT_LEGEL = "400100";
	// 非法字符
	String FAIL_ILLEGAL_CHARACTER = "400101";
	// 用户已经存在；
	String FAIL_USERS_ALREADY_EXIST = "400102";
	// Email格式错误
	String FAIL_EMAIL_FORMAT_ERROR = "400103";
	// Emial 不允许注册
	String FAIL_EMAIL_ALLOWED_TO_REGISTER = "400104";
	// 该Email已经被注册
	String FAIL_EMAIL_HAS_BEAN_REGISTERED = "400105";
	// 用户未注册
	String FAIL_USERS_NOT_EXIST = "400106";
	
}
