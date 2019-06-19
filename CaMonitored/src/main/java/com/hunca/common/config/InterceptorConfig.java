package com.hunca.common.config;

import com.hunca.common.interceptor.SysInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

// 过滤器配置
//@Configuration
public class InterceptorConfig extends WebMvcConfigurerAdapter {


	
	@Bean
	public SysInterceptor sysInterceptor() {
		return new SysInterceptor();
	}
	

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		super.addInterceptors(registry);

		registry.addInterceptor(sysInterceptor())//
				.addPathPatterns("/**")//
				.excludePathPatterns("/error/**")//
				.excludePathPatterns("/admin")//
				.excludePathPatterns("/admin/login");//
												
	}
	
	
}
