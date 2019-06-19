package com.hunca.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 全局的页面调度
 * @author saxon
 *
 */
@Controller
public class PageController {
	
	@RequestMapping("doPageUI")
	public String doPageUI() {
		return "pages/common/page";
	}
	  /****user pages **/
    @RequestMapping("user/doUserListUI")
	  public String doUserListUI(){
		  return "pages/user_list";
	  }
    @RequestMapping("user/doUserEditUI")
	  public String doUserEditUI(){
		  return "pages/user_edit";
	  }
    @RequestMapping("config/doConfigEditUI")
    public String doConfigEditUI(){
    	return "pages/config_edit";
    }
    @RequestMapping("notify/doNotifyListUI")
    public String doNotifyListUI(){
    	return "pages/notify_list";
    }
    @RequestMapping("notify/doNotifyEditUI")
    public String doNotifyEditUI(){
    	return "pages/notify_edit";
    }

	@RequestMapping("/log/doLogListUI")
	public String doLogListUI() {
		return "pages/log_list";
	}
	@RequestMapping("app/doAppListUI")
	public String doAppListUI() {
		return "pages/app_list";
	}
	@RequestMapping("app/doAppEditUI")
	public String doAppEditUI() {
		return "pages/app_edit";
	}
}
