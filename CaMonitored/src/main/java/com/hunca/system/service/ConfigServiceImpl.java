package com.hunca.system.service;
/**
 * 配置管理
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hunca.common.annotation.RequiredLog;
import com.hunca.common.exception.ServiceException;
import com.hunca.system.mapper.ConfigMapper;
import com.hunca.system.model.Config;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ConfigServiceImpl implements ConfigService {
	@Autowired
	ConfigMapper configMapper;
	

	@Override
	public Config selectConfig() {
		try {
			return configMapper.selectConfig();
			
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层异常,请联系管理员");
		}
	}

	@Override
	public int updateConfig(Integer emailTime, Integer shortMsgTime) {
		
	
			emailTime*=60000;
			shortMsgTime*=60000;//转换为毫秒
			int row = configMapper.updateConfig(emailTime,shortMsgTime);
			if(row == 0) throw new ServiceException("底层正在维护,请联系管理员");
			return row;
			
	
	}
	
}
