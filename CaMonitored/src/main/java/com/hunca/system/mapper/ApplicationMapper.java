package com.hunca.system.mapper;

import com.hunca.system.model.App;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ApplicationMapper {

	int insertObject(App app);
	int selectObjectCount(String serverId);
	int UpdateObjectState(App app);
	int selectObjectId(@Param("appName")String appName,@Param("serverId") String serverId);
	int getRowCount(@Param("appName")String appName);
	List<App> findPageObjects(@Param("appName")String appName,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize);
	List<App> findAllAppObject();
	int deleteById(Integer id);

    App doFindObjectById(@Param("id") Integer id);

	int doUpdateObject(App app);
}
