package com.hunca.system.model;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * 中间表
 * @author saxon
 *
 */
@Accessors(chain=true)
@Data
public class AppUser {
	private Integer id;
	private Integer userId;
	private Integer appId;
}
