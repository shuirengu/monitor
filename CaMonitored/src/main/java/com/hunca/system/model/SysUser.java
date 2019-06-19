package com.hunca.system.model;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 系统用户表
 *
 */
public class SysUser implements Serializable {



	private static final long serialVersionUID = 1L;

	private Integer userId; // 用户ID
	private String certSn; // 证书号
	private String realName; // 真实姓名
	private String post; // 职务
	private String phone; // 手机号码
	private String email; // 邮箱
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime; // 创建时间
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date lastLoginTime; // 最后登录时间
	private int isUse; // 是否使用 1 使用 2 禁用
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCertSn() {
		return certSn;
	}

	public void setCertSn(String certSn) {
		this.certSn = certSn;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public int getIsUse() {
		return isUse;
	}

	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}

	public SysUser() {
	}

	public SysUser(Integer userId, String certSn, String realName, String post, String phone, String email,
			Date createTime, Date lastLoginTime, int isUse) {
		super();
		this.userId = userId;
		this.certSn = certSn;
		this.realName = realName;
		this.post = post;
		this.phone = phone;
		this.email = email;
		this.createTime = createTime;
		this.lastLoginTime = lastLoginTime;
		this.isUse = isUse;
	}

}
