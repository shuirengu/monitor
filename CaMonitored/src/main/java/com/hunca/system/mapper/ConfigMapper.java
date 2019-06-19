package com.hunca.system.mapper;

import org.apache.ibatis.annotations.Param;

import com.hunca.system.model.Config;

public interface ConfigMapper {
	Config selectConfig();

	int updateConfig(@Param("emailTime")int emailTime, @Param("shortMsgTime")int shortMsgTime);
}
