package com.hunca.system.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.hunca.commom.utils.JsonResult;
import com.hunca.commom.utils.PageObject;
import com.hunca.system.model.SysLog;
import com.hunca.system.service.SysLogService;
/**
 * 日志打印操作
 * @author saxon
 *
 */

@RestController
@RequestMapping("/log/")
public class SysLogController {
	
	@Autowired
	SysLogService sysLogService;
	
	
	@RequestMapping("doFindPageObjects")
	@ResponseBody
	public JsonResult doFindPageObjects(
			String username,
			Integer pageCurrent){
		PageObject<SysLog> pageObject=
		sysLogService.findPageObjects(username, pageCurrent);
		return new JsonResult(pageObject);
	}
	@RequestMapping("doDeleteObjects")
	@ResponseBody
	public JsonResult doDeleteObjects(Integer...ids){
		sysLogService.deleteObjects(ids);
		return new JsonResult("delete ok");
	}
		
}
