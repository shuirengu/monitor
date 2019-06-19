package com.hunca.system.controller;

import com.hunca.commom.utils.JsonResult;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.system.model.App;
import com.hunca.system.service.ApplicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
/**
 * 
 * 这个类用来处理服务的查询删除操作
 * @author saxon
 *
 */
@RestController
@RequestMapping("app/")
public class ApplicationController {
	@Autowired
	ApplicationService applicationService;
	@RequestMapping("doFindPageObjects")
	  public JsonResult doFindPageObjects(
			  String appName,Integer pageCurrent){
		  return new JsonResult(
				  applicationService.doFindPageObjects(appName, pageCurrent));
	  }
	@RequiredLog("删除服务")
	@RequestMapping("doDeleteById")
	public JsonResult doDeleteById(Integer id){
		applicationService.deleteById(id);
		return new JsonResult("delete ok!!");
	}
    @RequiredLog("更改服务状态")
	@RequestMapping("doValidById")
	public JsonResult doValidById(Integer id,String state,String appIp,Integer appPort){
		applicationService.UpdateObjectState(new App().setAppState(state).setId(id).setAppIp(appIp).setAppPort(appPort));
		return new JsonResult("update ok!!");
	}

	@RequestMapping("doFindObjectById")
	public JsonResult doFindObjectById(Integer id){

		return new JsonResult(applicationService.doFindObjectById(id));
	}
    @RequiredLog("新增服务")
	@RequestMapping("doSaveObject")
	public JsonResult doSaveObject(App app){
		return new JsonResult(applicationService.insertObject(app));

	}
    @RequiredLog("修改服务")
	@RequestMapping("doUpdateObject")
	public JsonResult doUpdateObject(App app){
		return new JsonResult(applicationService.doUpdateObject(app));
	}
	
}
