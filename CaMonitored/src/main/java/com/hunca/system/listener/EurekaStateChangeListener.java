package com.hunca.system.listener;
/**
 * 服务监听处理类
 * @author saxon
 *
 */
public class EurekaStateChangeListener {
	/*@Autowired
	EmailUtil mailUtil;	
	@Autowired
	NotifyUserService notifyUserService;
	@Autowired
    ApplicationService applicationService;
	
	@Autowired
	ConfigService configService;
	
	private Thread EmailThread = new Thread();
	private Thread ShortMsgThread = new Thread();
	int i = 0;

	@EventListener
	public void listen(EurekaInstanceCanceledEvent eurekaInstanceCanceledEvent) {
		
 		if(++i % 4 == 0) {//同一个服务只执行一次操作
 		
 			String appName = eurekaInstanceCanceledEvent.getAppName();
			String serverId = eurekaInstanceCanceledEvent.getServerId();
 			List<NotifyUser> list = notifyUserService.selectObjectList(appName,serverId);
 			String df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()); 
 			String msg= "您好:\n"
 					+ appName+"服务器于"+df+"宕机,请及时处理,如果已处理请忽略。";
 			Config config = configService.selectConfig();
 			
			//启动线程  调用发邮件方法  
			EmailThread = new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						Thread.sleep(config.getEmailTime());
					} catch (InterruptedException e) {
						e.printStackTrace();
						return;
					}//五分钟
					MailBean mailBean = new MailBean()
								.setSubject("HUNCA服务器通知")
								.setText(msg);
					for (NotifyUser user : list) {
			 			mailUtil.sendMailTemplate(mailBean, user.getEmail());
			 		}
				}
			});
				
				//调用发短信方法  启动线程
				ShortMsgThread = new Thread(new Runnable() {
				
				@Override
				public void run() {
					try {
						Thread.sleep(config.getPhoneTime());//默认十五分钟发短信
					} catch (InterruptedException e) {
						e.printStackTrace();
						return;
					}
					SmsUtils smsUtils = new SmsUtils(Constans.SMS_URL);
					for (NotifyUser user : list) {
						smsUtils.sendSms(user.getPhone(),msg);
					}
				}
			});
			EmailThread.start();
			ShortMsgThread.start();
		}
	}
	
	@EventListener
	public void listen(EurekaInstanceRegisteredEvent event) {
		
		InstanceInfo instanceInfo = event.getInstanceInfo();
		String id = instanceInfo.getId();
		InstanceStatus status = instanceInfo.getStatus();
		String appName = instanceInfo.getAppName();
		String IP = instanceInfo.getIPAddr();
		int port = instanceInfo.getPort();
		App app = new App().setAppIp(IP)
					.setAppPort(port).setAppState(status.name())
					.setServerId(id).setAppName(appName);
		System.out.println(id);
		switch (status) {
		case UP:
			applicationService.insertObject(app);
			break;
		default:
			applicationService.UpdateObject(app);
			break;
		}
	//判断断线的服务有没有连上  连上取消发送短信和邮件 
		if(EmailThread.isAlive() && status.name() == "UP") 
			EmailThread.interrupt();;
			
		if(EmailThread.isAlive()&& status.name() == "UP") 
			ShortMsgThread.interrupt();
	}
	
	@EventListener
	public void listen(EurekaInstanceRenewedEvent event) {
		String appName = event.getAppName();
		event.getServerId();
		System.out.println("客户端: " + appName + "续租了...");
	}
	@EventListener
	public void listen(EurekaRegistryAvailableEvent event) {
		System.out.println("注册中心启动...");
	}
	@EventListener
	public void listen(EurekaServerStartedEvent event) {
		// Server启动
		System.out.println("Monitor服务启动...");
	}*/
}
