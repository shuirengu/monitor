package com.hunca.system.listener;

import com.hunca.commom.utils.EmailUtil;
import com.hunca.system.service.ApplicationService;
import com.hunca.system.service.ConfigService;
import com.hunca.system.service.NotifyUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Timer;

/**
 * @author wushangqun
 * @create 2019-06-18-9:16
 */
@Component
public class TelnetClientListener implements ServletContextListener {
    @Autowired
    ApplicationService applicationService ;
    @Autowired
    NotifyUserService notifyUserService ;
    @Autowired
    ConfigService configService;
    @Autowired
    EmailUtil emailUtil;
    @Override//通过定时器定时查看服务运行状态 判断有没有宕机
    public void contextInitialized(ServletContextEvent event) {
        WebApplicationContextUtils.getRequiredWebApplicationContext(event.getServletContext())
                .getAutowireCapableBeanFactory().autowireBean(this);

            ListenerTask task = new ListenerTask(applicationService,notifyUserService,configService,emailUtil);
            new Timer().schedule(task,0,2000);//两秒查看一次宕机情况
    }

    @Override //当监控系统异常时立即发短信和邮件
    public void contextDestroyed(ServletContextEvent event) {

    }
}
