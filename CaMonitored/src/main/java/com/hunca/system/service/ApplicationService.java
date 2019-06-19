package com.hunca.system.service;

import com.hunca.commom.utils.PageObject;
import com.hunca.system.model.App;

import java.util.List;

public interface ApplicationService {
	int insertObject(App app);
	int UpdateObjectState(App app);//修改服务状态
	PageObject<App> doFindPageObjects(String appName, Integer pageCurrent);
	int deleteById(Integer id);

    List<App> findAll();

	App doFindObjectById(Integer id);

	int doUpdateObject(App app);
}
