package com.hunca.system.listener;

import com.hunca.commom.utils.EmailUtil;
import com.hunca.system.TimerSchedule.EmailTask;
import com.hunca.system.TimerSchedule.ShortMsgTask;
import com.hunca.system.model.App;
import com.hunca.system.model.Config;
import com.hunca.system.model.NotifyUser;
import com.hunca.system.service.ApplicationService;
import com.hunca.system.service.ConfigService;
import com.hunca.system.service.NotifyUserService;
import org.apache.commons.net.telnet.TelnetClient;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author wushangqun
 * @create 2019-06-18-9:26
 */
@Component
@Transactional
public class ListenerTask extends TimerTask {
    //不能用autowire注入 用构造器注入
    ApplicationService applicationService ;
    NotifyUserService notifyUserService ;
    ConfigService configService;
    EmailUtil emailUtil;

    List<App> apps = null;
    TelnetClient telnet;
    Timer shortMsgTimer = null;
    Timer emailTimer = null;
    //String shortMsgKey;
    String eamilKey;
    /**
     * 创建一个存储已经宕机服务的map
     */
    Map<String, Timer> map = new HashMap<>();

    public ListenerTask(ApplicationService applicationService, NotifyUserService notifyUserService,                                                             ConfigService configService, EmailUtil emailUtil) {
        this.applicationService = applicationService;
        this.notifyUserService = notifyUserService;
        this.configService = configService;
        this.emailUtil = emailUtil;
    }
    public ListenerTask(){}
    @Override
    public void run() {
        //System.out.println("进来了");
        telnet=new TelnetClient();
        apps = applicationService.findAll();
        for (App app:apps) {
            shortMsgKey = app.getServerId()+"shortMsg";
            eamilKey = app.getServerId()+"email";
            try {
                telnet.connect(app.getAppIp(),app.getAppPort());
               // System.out.println("chenggong");

                if ( map.get(shortMsgKey) != null) {
                    map.get(shortMsgKey).cancel();
                    map.remove(shortMsgKey);
                }
                if ( map.get(eamilKey) != null) {
                    map.get(eamilKey).cancel();
                    map.remove(eamilKey);
                }
            }catch (Exception e){
                 List<NotifyUser> list = notifyUserService.selectObjectList(app.getAppName(),app.getServerId());
                 Config config = configService.selectConfig();
                 String df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                 String msg= "您好:\n"
                        + app.getAppName()+"服务器于"+df+"宕机,ip为"+app.getAppIp()+",端口号为"+app.getAppPort()                        +"请及时处理,如果已处理请忽略。";
                 //把当前的服务唯一标识为key timer类为value存进map中
                 //shortMsgTimer = new Timer(); 短信通知服务
                // shortMsgTimer.schedule(new ShortMsgTask(list,msg),config.getPhoneTime());
                 //.put(shortMsgKey,shortMsgTimer);
                 emailTimer = new Timer();
                 emailTimer.schedule(new EmailTask(list,msg,emailUtil),config.getEmailTime());
                 map.put(eamilKey,emailTimer);
                 applicationService.UpdateObjectState(app.setAppState("DOWN"));
                //处理发短信和邮件发送
                continue;
            }
        }
    }
}
