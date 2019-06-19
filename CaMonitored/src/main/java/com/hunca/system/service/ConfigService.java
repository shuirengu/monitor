package com.hunca.system.service;

import com.hunca.system.model.Config;

public interface ConfigService {

	Config selectConfig();

	int updateConfig(Integer emailTime, Integer shortMsgTime);


}
