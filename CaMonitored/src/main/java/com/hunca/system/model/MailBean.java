package com.hunca.system.model;

import lombok.Data;
import lombok.experimental.Accessors;
/**
 * 邮件bean
 * 
 * @author saxon
 *
 */
@Accessors(chain=true)
@Data
public class MailBean {
	   /**
     * 邮件主题
     */
    private String subject;

    /**
     * 邮件内容
     */
    private String text;


}


