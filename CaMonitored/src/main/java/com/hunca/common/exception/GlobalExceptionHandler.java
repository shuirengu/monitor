package com.hunca.common.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.hunca.commom.utils.JsonResult;


/**
 * @ControllerAdvice 注解描述的类
 * 为一个全局异常处理类,在此类中可以
 * 定义具体的异常处理方法处理相关异常
 * 
 * 其中@RestControllerAdvice
 * 等同于@ControllerAdvice+@ResponseBody
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

   /*@ExceptionHandler(ServiceException.class)
	 @ResponseBody
	 public JsonResult doHandleServiceException(
			 ServiceException e){
	    	e.printStackTrace();
			return new JsonResult(e);
	 }*/
	/**
	 * @ExceptionHandler 注解描述的方法为一个
	 * 异常处理方法
	 * @param e
	 * @return
	 */
    @ExceptionHandler(RuntimeException.class)
    public JsonResult doHandleRuntimeException(
			RuntimeException e){
    	e.printStackTrace();
		return new JsonResult(e);
	}
}





