package com.hunca.commom.utils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.hunca.system.model.MailBean;
/**
 * 邮件工具类
 * @author saxon
 *
 */

@Component
public class EmailUtil {
	 	@Autowired
	    private JavaMailSender mailSender; // 自动注入的Bean

	    @Value("${spring.mail.username}")
	    private String sender; // 读取配置文件中的参数

	   
	    /**
	     * 模板邮件发送
	     * @param mailBean
	     */
	    public void sendMailTemplate(MailBean mailBean,String senderTo) {
	        try {
	            MimeMessage mimeMessage = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
	            helper.setFrom(sender);
	            helper.setTo(senderTo);
	            helper.setSubject(mailBean.getSubject());
	            helper.setText(mailBean.getText(), true);
	            mailSender.send(mimeMessage);
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
	    }

}
