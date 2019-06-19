package com.hunca.system.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AppUserMapper {

	List<Integer> selectUserIdList(int appId);

	List<Integer> selectAppIdList(Integer id);
	int doUpdateAppUser(@Param("userId")Integer id,@Param("appIds")List<Integer> appIds);

	int deleteObjectByUserId(Integer id);
}
