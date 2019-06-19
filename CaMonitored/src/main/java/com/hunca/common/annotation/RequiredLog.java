package com.hunca.common.annotation;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * 次注解定义的是日志信息打印
 * @author saxon
 *
 */
@Retention(RetentionPolicy.RUNTIME)//运行时有效
@Target(ElementType.METHOD)
public @interface RequiredLog {
	 //理解为注解内部定义的属性.
	 String value() default "";
}







