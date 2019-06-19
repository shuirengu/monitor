package com.hunca.system.model;

import java.util.Date;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * 通知用户管理
 * @author saxon
 *
 */
@Accessors(chain=true)
@Data
public class NotifyUser {
	private Integer id;
	private String email;
	private String phone;
	private String realName;
	private Date createTime;
	private short state;//是否使用 1 使用  0未使用
}
