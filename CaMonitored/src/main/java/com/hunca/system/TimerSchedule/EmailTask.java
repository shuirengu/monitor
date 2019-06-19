package com.hunca.system.TimerSchedule;

import com.hunca.commom.utils.EmailUtil;
import com.hunca.system.model.MailBean;
import com.hunca.system.model.NotifyUser;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.TimerTask;

/**
 * @author wushangqun
 * @create 2019-06-18-10:47
 * 邮件发送事件
 */
@Component
public class EmailTask extends TimerTask {

    EmailUtil emailUtil;
    String msg = null;
    List<NotifyUser> list  = null;
    public EmailTask(List<NotifyUser> list, String msg,EmailUtil emailUtil){
        this.emailUtil = emailUtil;
        this.msg = msg;
        this.list = list;
    }
    public EmailTask(){}
    @Override
    public void run() {
        MailBean mailBean = new MailBean()
                .setSubject("HUNCA服务器通知")
                .setText(msg);
        for (NotifyUser user : list) {
            emailUtil.sendMailTemplate(mailBean, user.getEmail());
        }
    }
}
