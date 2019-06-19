package com.hunca.system.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * 服务器得bean
 * @author saxon
 *
 */
@Accessors(chain=true)
@Data
public class App implements Serializable{
	private static final long serialVersionUID = 4069702786930980690L;
	private Integer id;
	private String appName;
	private String appState;
	private String appIp;
	private Integer appPort;
	private String serverId;
	private Date createTime;
	private Date updateTime;//最后更改状态事件
	
	
}
