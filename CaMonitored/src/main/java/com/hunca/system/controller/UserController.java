package com.hunca.system.controller;


import com.hunca.commom.utils.JsonResult;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.system.model.SysUser;
import com.hunca.system.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
/**
 * 系统用户管理
 * @author saxon
 *
 */

@RestController
@RequestMapping("/user/")
public class UserController {
	@Autowired
	SysUserService sysUserService;

	 @RequestMapping("doFindPageObjects")
	  public JsonResult doFindPageObjects(
			  String username,Integer pageCurrent){
		  return new JsonResult(
				  sysUserService.doFindPageObjects(
						  username, pageCurrent));
	  }
	 /**
	  * 暂时未做权限管理  后面跟上
	  * @param id  
	  * @param valid 状态
	  * @return
	  */
	 @RequiredLog("修改系统用户状态")
	 @RequestMapping("doValidById")
	  public JsonResult doValidById(HttpSession session,Integer id,
			  Integer valid){
		 //获取修改用户的信息
		 //SysUser user=(SysUser) session.getAttribute(Constans.SESSION_SYSUSER);
		// if(user.getUserId() == id) throw new ServiceException("不能修改自己的状态信息");
		  sysUserService.validById(id, valid,20);
		  return new JsonResult("update ok");
	  }
	@RequiredLog("新增系统用户")
	  @RequestMapping("doSaveObject")
	  public JsonResult doSaveObject(
			  SysUser entity){
		  sysUserService.saveObject(entity);
		  return new JsonResult("save ok");
	  }
	@RequiredLog("修改系统用户")
	  @RequestMapping("doUpdateObject")
	  public JsonResult doUpdateObject(SysUser entity){
		  sysUserService.updateObject(entity);
		  return new JsonResult("update ok");
	  }
	@RequiredLog("删除系统用户")
	  @RequestMapping("doDeleteById")
	  public JsonResult doDeleteObject(HttpSession session,Integer id){
		 // SysUser user=(SysUser) session.getAttribute(Constans.SESSION_SYSUSER);
			// if(user.getUserId() == id) throw new ServiceException("不能删除自己");
		  sysUserService.deleteObject(id);
		  return new JsonResult("Delete ok");
	  }
	  @RequestMapping("doFindObjectById")
	  public JsonResult doFindObjectById(
			  Integer id){
	
		  return new JsonResult(
		 sysUserService.findObjectById(id));
	  }
	
	
}
