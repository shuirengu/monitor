package com.hunca.system.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hunca.commom.utils.PageObject;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.common.exception.ServiceException;
import com.hunca.system.mapper.SysLogMapper;
import com.hunca.system.model.SysLog;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SysLogServiceImpl implements SysLogService{
	@Autowired
	SysLogMapper sysLogMapper;

	@Override
	public PageObject<SysLog> findPageObjects(String username, Integer pageCurrent) {
		
			 //1.验证参数的有效性
			if(pageCurrent==null||pageCurrent<1)
			throw new IllegalArgumentException("页码值不正确");
			//2.基于用户名查询总记录数并进行相关判定
			int rowCount=sysLogMapper.getRowCount(username);
			if(rowCount==0)
			throw new ServiceException("没有找到对应记录");
			//3.基于用户名以及当前页码值查询当前的记录
			int pageSize=8;
			int startIndex=(pageCurrent-1)*pageSize;
			List<SysLog> records=
			sysLogMapper.findPageObjects(username, startIndex, pageSize);
			PageObject<SysLog> po=new PageObject<>();
			po.setRowCount(rowCount);
			po.setRecords(records);
			po.setPageSize(pageSize);
			po.setPageCurrent(pageCurrent);
			po.setPageCount((rowCount-1)/pageSize+1);
			return po;
		
		
	}

	@Override
	public int deleteObjects(Integer[] ids) {
		
			//1.参数有效性验证
	    	if(ids==null||ids.length==0)
	    	throw new IllegalArgumentException("id值无效");
	    	//2.执行删除操作
	    	 int rows=sysLogMapper.deleteObjects(ids);
	    	//3.验证删除结果
	    	if(rows==0)
	    	throw new ServiceException("记录可能已经不存在");
	    	//4.返回结果
	    	return rows;
		
		
	}
	

}
