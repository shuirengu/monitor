package com.hunca.system.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hunca.system.model.SysUser;


public interface SysUserMapper {

	SysUser getSysUserByParam(Map<String, Object> sysUserParam);

	 int getRowCount(@Param("username")String username);
	 List<SysUser> findPageObjects(
			 @Param("username")String username,
			 @Param("startIndex")Integer startIndex,
			 @Param("pageSize")Integer pageSize);

	int validById(@Param("id")Integer id,
			@Param("valid")Integer valid);

	int insertObject(SysUser entity);

	int updateObject(SysUser entity);

	int deleteObject(Integer id);

	
	int setLastLoginTime(int userId);

	SysUser findObjectById(Integer id);
}
