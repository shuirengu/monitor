package com.hunca.system.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hunca.system.model.SysLog;

public interface SysLogMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SysLog record);

    int insertSelective(SysLog record);

    SysLog selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SysLog record);

    int updateByPrimaryKey(SysLog record);

	List<SysLog> findPageObjects( @Param("username")String username,
			  @Param("startIndex")Integer startIndex,
			  @Param("pageSize")Integer pageSize);

	int getRowCount(@Param("username")String username);

	int deleteObjects(@Param("ids")Integer[] ids);
}