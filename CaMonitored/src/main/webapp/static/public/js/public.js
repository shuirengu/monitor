$(function(){
	$(document).ajaxError(function(event,xhr,options,exc){
		var msg = "";
		if(xhr.status==500){
			msg = "服务器发生异常: </br>"+xhr.responseText;
	    }else if(xhr.status==401){
	    	msg = "会话过期请重新登录: </br>"+xhr.responseText;
	    }else if(xhr.status==404){
	    	msg = "请求地址不存在: </br>"+xhr.responseText;
	    }else if(xhr.status==400){
	    	msg = "请求参数不正确: </br>"+xhr.responseText;
	    }else{
	    	msg = "未知错误: </br>"+xhr.responseText;
	    }
		layer.alert(msg, {
			icon : 5
		});
	});
})