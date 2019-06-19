package com.hunca.system.model;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * 配置信息表
 * @author saxon
 *
 */
@Accessors(chain=true)
@Data
public class Config {
	private Integer id;
	private Integer emailTime;
	private Integer phoneTime;
}
