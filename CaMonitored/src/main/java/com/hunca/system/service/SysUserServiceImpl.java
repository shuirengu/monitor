package com.hunca.system.service;


import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import com.hunca.commom.utils.PageObject;
import com.hunca.commom.utils.PageUtils;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.common.exception.ServiceException;
import com.hunca.system.mapper.SysUserMapper;
import com.hunca.system.model.SysUser;

@Service
@Transactional
public class SysUserServiceImpl implements SysUserService {
	@Autowired
	SysUserMapper sysUserMapper;

	@Override
	public SysUser getSysUserByParam(Map<String, Object> sysUserParam) {
		try {
			SysUser user = sysUserMapper.getSysUserByParam(sysUserParam);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层正在维护,请联系管理员");
		}

	}

	@Transactional(readOnly = true)
	@Override
	public PageObject<SysUser> doFindPageObjects(String username, Integer pageCurrent) {
		
			// 1.数据合法性验证
			if (pageCurrent == null || pageCurrent <= 0)
				throw new ServiceException("参数不合法");
			// 2.依据条件获取总记录数
			int rowCount = sysUserMapper.getRowCount(username);
			if (rowCount == 0)
				throw new ServiceException("记录不存在");
			// 3.计算startIndex的值
			int pageSize = 8;
			int startIndex = (pageCurrent - 1) * pageSize;
			// 4.依据条件获取当前页数据
			List<SysUser> records = sysUserMapper.findPageObjects(username, startIndex, pageSize);
			// 5.封装数据
			PageObject<SysUser> pageObject = PageUtils.newPageObject(rowCount, records, pageSize, pageCurrent);

			return pageObject;
		

	}


	@Override
	public int validById(Integer id, Integer valid, Integer userId) {

		// 1.合法性验证
		if (id == null || id <= 0)
			throw new ServiceException("参数不合法,id=" + id);
		if (valid != 1 && valid != 0)
			throw new ServiceException("参数不合法,valie=" + valid);
		// if(id == userId)
		// throw new ServiceException("不能修改自己的状态值");
		// 2.执行禁用或启用操作
		int rows = 0;
		try {
			rows = sysUserMapper.validById(id, valid);
		} catch (Throwable e) {
			e.printStackTrace();
			throw new ServiceException("底层正在维护");
		}
		return rows;
	}


	@Override
	@Transactional
	public int saveObject(SysUser entity) {
		// 1.参数有效性验证
		if (entity == null)
			throw new ServiceException("保存对象不能为空");
		if (StringUtils.isEmpty(entity.getRealName()))
			throw new ServiceException("用户名不能为空");
		int rows = sysUserMapper.insertObject(entity);

		return rows;
	}


	@Override
	public int updateObject(SysUser entity) {

		
		if (entity == null)
			throw new ServiceException("保存对象不能为空");
		if (StringUtils.isEmpty(entity.getRealName()))
			throw new ServiceException("用户名不能为空");
		int rows =-1;
	
		rows = sysUserMapper.updateObject(entity);
		if (rows == 0)
			throw new ServiceException("记录可能已经不存在");
		return rows;
	}


	@Transactional
	@Override
	public int deleteObject(Integer id) {
		if (id == null || id < 1)
			throw new IllegalArgumentException("id值无效");
		int rows =-1;
		try {
			 rows = sysUserMapper.deleteObject(id);
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层正在维护");
		}
		if (rows == 0)
			throw new ServiceException("菜单可能已经不存在");
		return rows;
	}

	@Override
	public SysUser findObjectById(Integer id) {
	
		// 1.对参数进行校验
		if (id == null || id < 1)
			throw new IllegalArgumentException("参数值不合法");
		try {
			SysUser user = sysUserMapper.findObjectById(id);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层正在维护");
		}
	}

}
