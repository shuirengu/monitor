package com.hunca.commom.utils;
/**
 * VO:封装控制层要返回到客户端的数据
 * @author tarena
 */
public class JsonResult {
	/**我们自己设置的服务端向客户端输出的状态码*/
    private int state=1;//"1,ok;0,false"2,权限错误
    /**状态码state对应的具体信息*/
    private String message="ok";
    /**业务层返回给控制层的具体数据*/
    private Object data;
    
    public JsonResult(){
    }
    public JsonResult(String message){
    	this.message=message;
    }
    public JsonResult(Object data){
    	this.data=data;
    }
    public JsonResult(Throwable e){
    	this.state=0;
    	this.message=e.getMessage();
    }
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
     
     
}
