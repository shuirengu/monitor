package com.hunca.system.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hunca.system.model.NotifyUser;

public interface NotifyUserMapper {

	int updateObject(NotifyUser entity);

	int insertObject(NotifyUser entity);

	List<NotifyUser> findPageObjects(@Param("username")String username,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize);

	int getRowCount(@Param("username")String username);

	int deleteObject(Integer id);

	NotifyUser doFindObjectById(Integer id);

	List<NotifyUser> selectObjectByUserId(@Param("userIds")List<Integer> userIds);

	int validById(@Param("id")Integer id,@Param("valid")Integer valid);

	int doUpdateAppUser(@Param("id")List<Integer> id);

	
}
