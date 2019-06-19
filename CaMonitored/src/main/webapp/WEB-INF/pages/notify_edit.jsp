<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><!-- Horizontal Form -->
 <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">添加用户</h3>
      </div>
      <!-- /.box-header -->
      <!-- form start -->
      <form class="form-horizontal">
        <div class="box-body">
          <div class="form-group">
            <label for="realNameId" class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name=realName id="realNameId">
            </div>
          </div>   
          <div class="form-group">
            <label for="emailId" class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-10">
              <input type="text" class="form-control"  id="emailId">
            </div>
          </div>
       
          <div class="form-group">
            <label for="phoneId" class="col-sm-2 control-label">手机号</label>
              <div class="col-sm-10">
              <input type="text" class="form-control" name="mobile"  id="phoneId">
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
     <div class="layui-layer layui-layer-page layui-layer-molv layer-anim" id="treeLayer" type="page" times="2" showtime="0" contype="object"
		style="z-index:59891016; width: 300px; height: 450px; top: 100px; left: 500px; display:none">
		<div class="layui-layer-title" style="cursor: move;">权限管理</div>
		<div class="layui-layer-content" style="height: 358px;">
			<div style="padding: 10px;" class="layui-layer-wrap">
				<ul id="zTreeId" class="ztree"></ul>   
			</div>
		</div>
		<span class="layui-layer-setwin"> <a class="layui-layer-ico layui-layer-close layui-layer-close1 btn-cancel" ></a></span>
		<div class="layui-layer-btn layui-layer-btn-">
			<a class="layui-layer-btn0 btn-confirm">确定</a>
			<a class="layui-layer-btn1 btn-cancel">取消</a>
	     </div>
      </div>
    </div>
<script type="text/javascript" src="${ctx}/bower_components/layer/layer.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	 //页面加载完成以后加载角色信息并初始化页面
	 doInitFormData();
	 //事件注册
	 $(".box-footer")
	 .on("click",".btn-cancel",doCancel)
	 .on("click",".btn-save",doSaveOrUpdate);
	 
 });
 function doCancel(){
	$("#mainContentId").removeData("rowData");
	$("#mainContentId").load("${ctx}/notify/doNotifyListUI");
 }
 function doSaveOrUpdate(){
	 var rowData=$("#mainContentId").data("rowData");
	 //1.获取表单数据
	 var params=doGetEditFormData();
	 var realname = $("#realNameId").val();
	 var Email = $("#emailId").val();
	 var tel = $("#phoneId").val();
	 if(2>realname.length ||realname.length>10){
		 layer.msg("名字至少两个字符或者不能超过7个字符");
		 $("#usernameId").val("");
		 return false;
	 }
	
	 var str = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
	 if(!(str.test(Email))){
		 layer.msg("请输入正确的邮箱地址!!");
		 $("#emailId").val("");
		 return false;
	 }
	 var telnum = /^1(3|4|5|7|8)\d{9}$/;
	 if(!(telnum.test(tel))){
		 layer.msg("请输入正确的手机号码");
		 $("#phoneId").val("");
		 return false;
	 }
	 if(rowData)params.id=rowData.id;
	 //2.发起异步请求
	 var insertUrl="${ctx}/notify/doSaveObject";
	 var updateUrl="${ctx}/notify/doUpdateObject";
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
 function doGetEditFormData(){
	
	 //获取用户输入的数据
	 var params={
	    realName:$("#realNameId").val(),
	    email:$("#emailId").val(),
	    phone:$("#phoneId").val(),
	 }
	 return params;
 }
 function doInitFormData(){
     var data=$("#mainContentId").data("rowData");
     if(!data)return;
     $("#pwdDiv").remove();
	 console.log(data);
	 //初始化用户信息 
	 $("#id").val(data.id);
	 $("#realNameId").val(data.realName);
	 $("#emailId").val(data.email);
	 $("#phoneId").val(data.phone);
 }

</script>
    
    
    
    
    
    
    