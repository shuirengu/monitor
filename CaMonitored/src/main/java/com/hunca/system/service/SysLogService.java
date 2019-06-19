package com.hunca.system.service;

import com.hunca.commom.utils.PageObject;
import com.hunca.system.model.SysLog;

public interface SysLogService {

	PageObject<SysLog> findPageObjects(String username, Integer pageCurrent);

	int deleteObjects(Integer[] ids);

	

}
