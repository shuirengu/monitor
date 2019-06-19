
package com.hunca.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hunca.commom.utils.Constans;
import com.hunca.commom.utils.ThreadContent;
import com.hunca.kits.tool.ObjectUtils;
import com.hunca.system.mapper.SysUserMapper;
import com.hunca.system.model.SysUser;

// 权限过滤器
public class SysInterceptor implements HandlerInterceptor {
	@Autowired
	SysUserMapper userMapper;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		SysUser attribute = (SysUser) session.getAttribute(Constans.SESSION_SYSUSER);
		if (ObjectUtils.isEmpty(attribute)) {
			if (request.getRequestURI().equals("logout")) {
				session.setAttribute("message", "");
			} else {
				session.setAttribute("message", "会话过期,请重新登录!");
			}
			request.getRequestDispatcher("/error/401").forward(request, response);
			return false;
		}
		
		userMapper.setLastLoginTime(attribute.getUserId());
		ThreadContent.setUser(attribute);
		return true;
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		ThreadContent.delThreadLocal();
	}

}
