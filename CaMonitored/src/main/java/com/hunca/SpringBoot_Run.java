package com.hunca;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication
@MapperScan("com.hunca.**.mapper")
public class SpringBoot_Run extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(SpringBoot_Run.class, args);
	}
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(SpringBoot_Run.class);
	}

}
