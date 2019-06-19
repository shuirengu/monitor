<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><!-- Horizontal Form -->
 <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">配置管理</h3>
      </div>
      <!-- /.box-header -->
      <!-- form start -->
      <form class="form-horizontal">
        <div class="box-body">
          <div class="form-group">
            <label for="emailId" class="col-sm-3 control-label">邮箱发送间隔(单位/分钟)</label>
            <div class="col-sm-2">
              <input placeholder="正整数(最大两位数)" type="text" class="form-control"  id="emailTime">
            </div>
          </div>
          <div class="form-group">
            <label for="phoneId" class="col-sm-3 control-label">短信发送间隔(单位/分钟)</label>
              <div class="col-sm-2">
              <input  placeholder="正整数(最大两位数)" type="text" class="form-control" name="shortMsgTime"  id="shortMsgTime"">
            </div>
          </div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          <button type="button" class="btn btn-default btn-cancel">Cancel</button>
          <button type="button" class="btn btn-info pull-right btn-save">update</button>
        </div>
        <!-- /.box-footer -->
      </form>
    </div>
<script type="text/javascript">
 $(document).ready(function(){
	 //页面加载完成以后加载角色信息并初始化页面
	  doInitFormData();
	 //事件注册
	 $(".box-footer")
	 .on("click",".btn-cancel",doCancel)
	 .on("click",".btn-save",doUpdate);
 });
 function doInitFormData(){
	 var url = "${ctx}/config/doFindConfigTime";
	 var params = {random:Math.random()};
	 $.get(url,params,function(result){
		if(result.state == 1){
			$("#emailTime").data("data",result.data);
			$("#emailTime").val(result.data.emailTime/60000);
			$("#shortMsgTime").val(result.data.phoneTime/60000);
		}else{
			layer.msg(result.message);
		}
	 })
 }
function doCancel(){
	var data = $("#emailTime").data("data");
	$("#emailTime").val(data.emailTime/60000);
	$("#shortMsgTime").val(data.phoneTime/60000);
	//还原之前的设置
}
function doUpdate(){
	var emailTime = $("#emailTime").val();
	if(!((/^0?[1-9]|[1-9][0-9]$/).test(emailTime))){
		layer.msg("请输入正整数!");
		return false;
	}
	
	var shortMsgTime = $("#shortMsgTime").val();
	if(!((/^0?[1-9]|[1-9][0-9]$/).test(shortMsgTime))){
		layer.msg("请输入正整数!");
		return false;
	}
	var params = {"emailTime":parseInt(emailTime),"shortMsgTime":parseInt(shortMsgTime)};
	
	var url="${ctx}/config/doUpdateConfigTime";
	$.post(url,params,function(result){
		
			if(result.state == 1){
				layer.msg(result.message);
				doInitFormData();
			}else{
				layer.msg(result.message);
			}
	})
}
</script>
    
    
    
    
    
    
    