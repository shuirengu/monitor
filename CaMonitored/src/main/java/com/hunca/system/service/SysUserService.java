package com.hunca.system.service;

import java.util.List;
import java.util.Map;

import com.hunca.commom.utils.PageObject;
import com.hunca.system.model.SysUser;

public interface SysUserService {
	// 通过参数查询用户
		SysUser getSysUserByParam(Map<String, Object> sysUserParam);
		PageObject<SysUser> 
	     doFindPageObjects(String username,
	    		 Integer pageCurrent);
//改变用户的启用状态
		int validById(Integer id, Integer valid, Integer integer);
//新增用户
		int saveObject(SysUser entity);
//更新用户
		int updateObject(SysUser entity);
//删除用户
		int deleteObject(Integer id);
//根据主键查找用户信息		
		SysUser findObjectById(Integer id);

	
}
