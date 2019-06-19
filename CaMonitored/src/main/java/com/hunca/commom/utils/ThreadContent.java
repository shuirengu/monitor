package com.hunca.commom.utils;

import com.hunca.system.model.SysUser;

public class ThreadContent {
	  private static ThreadLocal<SysUser> UserLocal= new ThreadLocal<SysUser>();  
	  
	  public static SysUser getUser() {  
	        return (SysUser)UserLocal.get();  
	    }  
	    public static void setUser(SysUser user) {  
	    	UserLocal.set(user);  
	    }  
	    public static void delThreadLocal() {
	    	UserLocal.remove();
	    }
}
