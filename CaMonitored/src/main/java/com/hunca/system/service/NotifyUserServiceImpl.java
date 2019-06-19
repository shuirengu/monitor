package com.hunca.system.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.util.StringUtils;
import com.hunca.commom.utils.PageObject;
import com.hunca.commom.utils.PageUtils;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.common.exception.ServiceException;
import com.hunca.system.mapper.AppUserMapper;
import com.hunca.system.mapper.ApplicationMapper;
import com.hunca.system.mapper.NotifyUserMapper;
import com.hunca.system.model.App;
import com.hunca.system.model.NotifyUser;
import com.hunca.system.model.SysUser;
import com.hunca.system.result.ConnectResult;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class NotifyUserServiceImpl implements NotifyUserService {
	@Autowired
	NotifyUserMapper notifyUserMapper;
	@Autowired
	AppUserMapper appUserMapper;
	@Autowired
	ApplicationMapper applicationMapper;

	@Override
	public PageObject<NotifyUser> doFindPageObjects(String username, Integer pageCurrent) {
		
			//1.数据合法性验证
			if(pageCurrent==null||pageCurrent<=0)
			throw new ServiceException("参数不合法");
	        //2.依据条件获取总记录数
			int rowCount=notifyUserMapper.getRowCount(username);
	        if(rowCount==0)
			throw new ServiceException("记录不存在");
			//3.计算startIndex的值
			int pageSize=8;
			int startIndex=(pageCurrent-1)*pageSize;
			//4.依据条件获取当前页数据
			List<NotifyUser> records=
					notifyUserMapper.findPageObjects(
			username, startIndex, pageSize);
			//5.封装数据
			PageObject<NotifyUser> pageObject=
			PageUtils.newPageObject(rowCount,
					records, pageSize, pageCurrent);
			
			return pageObject;
		
	
		
	}

	@Override
	public int saveObject(NotifyUser entity) {
		
			if(entity == null) throw new ServiceException("参数为空,请联系管理员");
			int row = notifyUserMapper.insertObject(entity);
			return row;	
		
		
	}

	@Override
	public int updateObject(NotifyUser entity) {
		try {
			if(entity == null) throw new ServiceException("参数为空,请联系管理员");
			int row = notifyUserMapper.updateObject(entity);
			return row;	
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层异常,请联系管理员");
		}
	}

	@Override
	public int deleteObject(Integer id) {
		try {
			if(id == null || id <= 0) throw new ServiceException("参数为空,请联系管理员");
			int row = notifyUserMapper.deleteObject(id);
			return row;	
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层异常,请联系管理员");
		}
	}
	

	@Override
	public NotifyUser doFindObjectById(Integer id) {
		
			if(id == null || id <= 0) throw new ServiceException("参数为空,请联系管理员");
			NotifyUser user=notifyUserMapper.doFindObjectById(id);
			if(user == null) throw new ServiceException("这个用户已经不存在");
			return user;	
		
	}

	@Override
	public List<NotifyUser> selectObjectList(String appName, String serverId) {
		
			int appId = applicationMapper.selectObjectId(appName,serverId);
			if(appId == 0) throw new ServiceException("当前服务不存在");
			List<Integer> userIds = appUserMapper.selectUserIdList(appId);
			if(userIds == null || userIds.size() ==0) throw new ServiceException("没有关联的用户");
			List<NotifyUser> notifyUsers = notifyUserMapper.selectObjectByUserId(userIds);
			if(notifyUsers == null) throw new ServiceException("关联的通知用户信息不存在");
			return notifyUsers;
	
	}

	@Override
	public ConnectResult doFindAppById(Integer id) {
		
			//根据userId查询到appid
			List<Integer> appIds =appUserMapper.selectAppIdList(id);
			
			
			//查询所有的app
			
			List<App> allApp = applicationMapper.findAllAppObject();
			if(allApp == null || allApp.size() == 0) throw new ServiceException("没有服务可以关联");
			return new ConnectResult().setAllApp(allApp).setConApp(appIds);
		
		
		
	}

	@Override
	public int validById(Integer id, Integer valid) {
		
			//1.合法性验证
			if(id==null||id<=0)
				throw new ServiceException("参数不合法,id="+id);
			if(valid!=1&&valid!=0)
				throw new ServiceException("参数不合法,valie="+valid);
			
			int rows=0;
			try{
				rows=notifyUserMapper.validById(id, valid);
			}catch(Throwable e){
				e.printStackTrace();
				throw new ServiceException("底层正在维护");
			}
			return rows;
		
		
	}
	@Override
	public int doUpdateAppUser(String ids,Integer id) {
		int deRow= appUserMapper.deleteObjectByUserId(id);
		List<Integer> appIds = new ArrayList<>();
		System.out.println("daole");
		int row = 0;
		if(id == null || id <= 0) throw new ServiceException("选中的用户异常,请联系管理员");
			if(!StringUtils.isEmpty(ids)) {
				String[] split = ids.split(",");
				for (String s : split) {
					appIds.add(Integer.parseInt(s));
				}
				row = appUserMapper.doUpdateAppUser(id,appIds);
				if(row == 0) throw new ServiceException("关联服务失败,请稍后重试或联系管理员");
			}
			return row;
	}
	
}
