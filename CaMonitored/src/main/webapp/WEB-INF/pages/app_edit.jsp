<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><!-- Horizontal Form -->
 <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">添加服务</h3>
      </div>
      <!-- /.box-header -->
      <!-- form start -->
      <form class="form-horizontal">
        <div class="box-body">
          <div class="form-group">
            <label for="appName" class="col-sm-2 control-label">服务名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="appName" id="appName">
            </div>
          </div>
          <div class="form-group">
            <label for="appIp" class="col-sm-2 control-label">服务IP</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="appIp" id="appIp">
            </div>
          </div>
         
          
          
          <div class="form-group">
            <label for="appPort" class="col-sm-2 control-label">服务端口</label>
            <div class="col-sm-10">
              <input type="text" class="form-control"  id="appPort">
            </div>
          </div>

<input type="hidden"  id="id">
        <!-- /.box-body -->
        <div class="box-footer">
          <button type="button" class="btn btn-default btn-cancel">Cancel</button>
          <button type="button" class="btn btn-info pull-right btn-save">Save</button>
        </div>
        <!-- /.box-footer -->
      </form>
    </div>
<script type="text/javascript" src="${ctx}/bower_components/layer/layer.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	  doInitFormData();
	 //事件注册
	 $(".box-footer")
	 .on("click",".btn-cancel",doCancel)
	 .on("click",".btn-save",doSaveOrUpdate);
 });

 function doCancel(){
	$("#mainContentId").removeData("rowData");
	$("#mainContentId").load("${ctx}/app/doAppListUI");
 }
 function doSaveOrUpdate(){
	 var rowData=$("#mainContentId").data("rowData");
	 //1.获取表单数据
     var params={
         appName:$("#appName").val(),
         appIp:$("#appIp").val(),
         appPort:$("#appPort").val(),
     }
	 var appName = $("#appName").val();
	 var appIp = $("#appIp").val();
	 var appPort = $("#appPort").val();

	 if(rowData)params.id=rowData.id;
	 //2.发起异步请求
	 var insertUrl="${ctx}/app/doSaveObject";
	 var updateUrl="${ctx}/app/doUpdateObject";
	 var url=rowData?updateUrl:insertUrl;
	 console.log(params);
	 $.post(url,params,function(result){
		 
		 if(result.state==1){
			 layer.msg(result.message);
			 doCancel();
		 }else{
			layer.msg(result.message);
		 }
	 })
 }

 function doInitFormData(){
     var data=$("#mainContentId").data("rowData");
     if(!data)return;
     $("#pwdDiv").remove();
	 console.log(data);
	 //初始化用户信息 
	 $("#appName").val(data.appName);
	 $("#appIp").val(data.appIp);
	 $("#appPort").val(data.appPort);
 }
	
</script>
    
    
    
    
    
    
    