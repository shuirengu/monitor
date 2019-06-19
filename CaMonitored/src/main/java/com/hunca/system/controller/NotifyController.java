package com.hunca.system.controller;

import com.hunca.commom.utils.JsonResult;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.system.model.NotifyUser;
import com.hunca.system.service.NotifyUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
/**
   *     通知用户管理
 * @author saxon
 *
 */
@RestController
@RequestMapping("/notify/")
public class NotifyController {
	@Autowired
	NotifyUserService notifyUserService;
	
		//查询用户并分页
	 @RequestMapping("doFindPageObjects")
	  public JsonResult doFindPageObjects(
			  String username,Integer pageCurrent){
		  return new JsonResult(
				  notifyUserService.doFindPageObjects(
						  username, pageCurrent));
	  }
	 @RequiredLog("新增通知用户")
	 //新增用户
	  @RequestMapping("doSaveObject")
	  public JsonResult doSaveObject(
			  NotifyUser entity){
		  notifyUserService.saveObject(entity);
		  return new JsonResult("save ok");
	  }
	  @RequiredLog("修改通知用户")
	//更改用户信息
	  @RequestMapping("doUpdateObject")
	  public JsonResult doUpdateObject(NotifyUser entity){
		  notifyUserService.updateObject(entity);
		  return new JsonResult("update ok");
	  }
	  @RequiredLog("删除通知用户")
	  //根据id删除用户
	  @RequestMapping("doDeleteById")
	  public JsonResult doDeleteObject(Integer id){
			 notifyUserService.deleteObject(id);
		  return new JsonResult("Delete ok");
	  }
	  
	  //查询用户根据id
	  @RequestMapping("doFindObjectById")
	  public JsonResult doFindObjectById(Integer id){
		
		  return new JsonResult(notifyUserService.doFindObjectById(id));
	  }
	  //根据用户id查询用户关联的服务
	  @RequestMapping("doFindAppById")
	  public JsonResult doFindAppById(Integer id){
		  return new JsonResult(notifyUserService.doFindAppById(id));
	  }
	  //修改状态信息
	  @RequiredLog("修改通知用户状态")
	  @RequestMapping("doValidById")
	  public JsonResult doValidById(Integer id,Integer valid){
		  notifyUserService.validById(id, valid);
		  return new JsonResult("update ok");
	  }
	  //修改状态信息
	  @RequestMapping("doUpdateAppUser")
	  public JsonResult doUpdateAppUser(String ids,Integer id){
		  notifyUserService.doUpdateAppUser(ids,id);
		  return new JsonResult("update ok");
	  }
	  
}
