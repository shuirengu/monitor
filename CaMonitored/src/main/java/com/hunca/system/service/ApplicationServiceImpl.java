package com.hunca.system.service;

import com.hunca.commom.utils.PageObject;
import com.hunca.commom.utils.PageUtils;
import com.hunca.commom.utils.UuidUtil;
import com.hunca.common.annotation.RequiredLog;
import com.hunca.common.exception.ServiceException;
import com.hunca.system.mapper.ApplicationMapper;
import com.hunca.system.model.App;
import org.apache.commons.net.telnet.TelnetClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
@Service
@Transactional
public class ApplicationServiceImpl implements ApplicationService {
	@Autowired
	ApplicationMapper applicationMapper;
	
	@RequiredLog("更新服务信息")
	@Override//插入操作
	public int insertObject(App app) {
		try {
			String uuid = app.getAppIp()+":"+UuidUtil.uuid().substring(1,6)+":"+app.getAppPort();
			app.setAppState("DOWN").setServerId(uuid);
			return applicationMapper.insertObject(app);
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("底层异常请联系管理员");
		}
		
	}

	@Override//跟新操作
	public int UpdateObjectState(App app) {

			if(app.getAppState().equals("UP")){
				try {
					new TelnetClient().connect(app.getAppIp(),app.getAppPort());
				} catch (IOException e) {
					throw new ServiceException("当前服务器测试连接失败,请确定服务器正常启动");
				}
			}
		return applicationMapper.UpdateObjectState(app);

	}

	@Override//分页查询
	public PageObject<App> doFindPageObjects(String appName, Integer pageCurrent) {
		
			//1.数据合法性验证
			if(pageCurrent==null||pageCurrent<=0)
			throw new ServiceException("参数不合法");
	        //2.依据条件获取总记录数
			int rowCount=applicationMapper.getRowCount(appName);
	        if(rowCount==0)
			throw new ServiceException("记录不存在");
			//3.计算startIndex的值
			int pageSize=8;
			int startIndex=(pageCurrent-1)*pageSize;
			//4.依据条件获取当前页数据
			List<App> records=
					applicationMapper.findPageObjects(
							appName, startIndex, pageSize);
			//5.封装数据
			PageObject<App> pageObject=
			PageUtils.newPageObject(rowCount,
					records, pageSize, pageCurrent);
			
			return pageObject;
	
		
	}


	@Override//删除操作
	public int deleteById(Integer id) {
	
			if(id == null || id == 0) throw new ServiceException("参数错误");
			int row = applicationMapper.deleteById(id);
			if(row == 0) throw new ServiceException("记录已被删除 请勿重复提交");
			return row;
		
		
	}

	@Override
	public List<App> findAll() {
		List<App> allAppObject = applicationMapper.findAllAppObject();
		return allAppObject;
	}

	@Override
	public App doFindObjectById(Integer id) {

		return applicationMapper.doFindObjectById(id);
	}

	@Override
	public int doUpdateObject(App app) {
		return applicationMapper.doUpdateObject(app);
	}


}
