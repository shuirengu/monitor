package com.hunca.system.TimerSchedule;

import com.hunca.commom.utils.Constans;
import com.hunca.commom.utils.SmsUtils;
import com.hunca.system.model.NotifyUser;

import java.util.List;
import java.util.TimerTask;

/**
 * @author wushangqun
 * @create 2019-06-18-10:46
 * 短信发送事件
 */
public class ShortMsgTask extends TimerTask {
   /* String msg = null;
    List<NotifyUser> list  = null;
    public ShortMsgTask(List<NotifyUser> list,String msg){
       this.msg = msg;
        this.list = list;
    }
     public ShortMsgTask(){}

    @Override
    public void run() {

          //  SmsUtils smsUtils = new SmsUtils(Constans.SMS_URL);
            for (NotifyUser user : list) {
             //   smsUtils.sendSms(user.getPhone(),msg);
            }

    }*/
}
