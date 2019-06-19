package com.hunca.system.controller;

import com.hunca.commom.utils.JsonResult;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.system.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
/**
 * 这个类是用来处理配置信息的修改查询操作
 * @author saxon
 *
 */
@RestController
@RequestMapping("config")
public class ConfigController {
	@Autowired
	ConfigService configService;

	@RequestMapping("doFindConfigTime")
	public JsonResult doFindConfigTime() {

		return new JsonResult(configService.selectConfig());
	}
	@RequiredLog("修改配置")
	@RequestMapping("doUpdateConfigTime")
	public JsonResult doUpdateConfigTime(Integer emailTime,Integer shortMsgTime) {
		configService.updateConfig(emailTime, shortMsgTime);
		return new JsonResult("Update Ok!!");
	}
}
