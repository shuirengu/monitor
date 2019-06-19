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
            <label for="usernameId" class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="username" id="usernameId">
            </div>
          </div>
          <div class="form-group">
            <label for="CertSnId" class="col-sm-2 control-label">CertSn</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="certSn" id="certSnId">
            </div>
          </div>
         
          
          
          <div class="form-group">
            <label for="emailId" class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-10">
              <input type="text" class="form-control"  id="emailId">
            </div>
          </div>
          <div class="form-group">
            <label for="deptnameId" class="col-sm-2 control-label">职位</label>
              <div class="col-sm-10">
              <input type="text" class="form-control" name="post"  id="deptnameId">
            </div>
          </div>
          <div class="form-group">
            <label for="phoneId" class="col-sm-2 control-label">手机号</label>
              <div class="col-sm-10">
              <input type="text" class="form-control" name="mobile"  id="phoneId">
            </div>
          </div>
        </div>
        <input type="hidden"  id="userId">
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
	 
	 $("form")
	 .on("blur","#usernameId,#phoneId",isExists);
 });
 //验证字段名的值是否已存在
 function isExists(){
	var params={
			"columnName":$(this).prop("name"),
			"columnValue":$(this).val()
	};
	var url="${ctx}/user/doFindObjectByColumn";
	$.post(url,params,function(result){
		if(result.state==0){
			layer.msg(result.message);
		}
	})
 }

 function doCancel(){
	$("#mainContentId").removeData("rowData");
	$("#mainContentId").load("${ctx}/user/doUserListUI");
 }
 function doSaveOrUpdate(){
	 var rowData=$("#mainContentId").data("rowData");
	 //1.获取表单数据
	 var params=doGetEditFormData();
	 var realname = $("#usernameId").val();
	 var Email = $("#emailId").val();
	 var tel = $("#phoneId").val();
	 var post = $("#deptnameId").val();
	var cert =  $("#certSnId").val()
	if(2>realname.length ||realname.length>7){
		 layer.msg("名字至少两个字符或者不能超过7个字符");
		 $("#usernameId").val("");
		 return false;
	 }
	 if(cert.length == 0){
		 layer.msg("请输入正确的certSn号");
		 $("#certSnId").val("");
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
	 if(post.length>10){
		 layer.msg("职务名在10个字符之内");
		 $("#deptnameId").val("");
		 return false;
	 }
	 if(rowData)params.id=rowData.id;
	 //2.发起异步请求
	 var insertUrl="${ctx}/user/doSaveObject";
	 var updateUrl="${ctx}/user/doUpdateObject";
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
		userId:$("#userId").val(),
	    realName:$("#usernameId").val(),
	    certSn:$("#certSnId").val(),
	    email:$("#emailId").val(),
	    phone:$("#phoneId").val(),
	    post: $("#deptnameId").val()
	 }
	 return params;
 }
 function doInitFormData(){
     var data=$("#mainContentId").data("rowData");
     if(!data)return;
     $("#pwdDiv").remove();
	 console.log(data);
	 //初始化用户信息 
	 $("#userId").val(data.userId);
	 $("#usernameId").val(data.realName);
	 $("#certSnId").val(data.certSn);
	 $("#deptnameId").val(data.post);
	 $("#emailId").val(data.email);
	 $("#phoneId").val(data.phone);
 }
	
</script>
    
    
    
    
    
    
    