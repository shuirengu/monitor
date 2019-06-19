package com.hunca.system.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hunca.commom.utils.PageObject;
import com.hunca.system.model.NotifyUser;
import com.hunca.system.result.ConnectResult;

public interface NotifyUserService {


	PageObject<NotifyUser> doFindPageObjects(@Param("username")String username, @Param("pageCurrent")Integer pageCurrent);

	int saveObject(NotifyUser entity);

	int updateObject(NotifyUser entity);

	int deleteObject(Integer id);

	NotifyUser doFindObjectById(Integer id);

	List<NotifyUser> selectObjectList(@Param("appName")String appName,@Param("serverId") String serverId);

	ConnectResult doFindAppById(Integer id);

	int validById(Integer id, Integer valid);

	int doUpdateAppUser(String ids, Integer id);
	
}
