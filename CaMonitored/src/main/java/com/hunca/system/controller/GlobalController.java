package com.hunca.system.controller;

import com.hunca.commom.utils.*;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.kits.tool.ObjectUtils;
import com.hunca.system.model.SysUser;
import com.hunca.system.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
/**
 * 这个类用来处理用户登录操作
 * @author saxon
 *
 */
@Controller
public class GlobalController{
	@Autowired
	SysUserService sysUserService;
	@Autowired
	EmailUtil mailUtil;
	
	// 证书登录首页
		@RequestMapping("/admin")
		public String admin(Map<String, Object> map) {
			return "login";
		}
	//平台管理证书登陆
	@RequiredLog("用户登录")
	@ResponseBody
	@RequestMapping("/admin/login")
	public Result login(HttpSession session,HttpServletRequest req,String sn,String cert,String data,String sign){
		try {
			//登录功能
		} catch (Exception e) {
			e.printStackTrace();
			return new Result(Result.CODE_EXCEPTION,"登录发生异常");
		}
		
	}
	// 访问管理平台首页
	@RequestMapping("/admin/index")
	public String adminIndex(HttpSession session) {

		return "index";
	}
	@RequiredLog("退出登录")
	@RequestMapping("/admin/doLogout")
	public String doLogout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);// 防止创建Session
		if (session != null) {
			if (session.getAttribute(Constans.SESSION_SYSUSER) != null) {
				session.setAttribute(Constans.SESSION_SYSUSER,"");
			}
		}
		return "redirect:/admin";
	}
}
