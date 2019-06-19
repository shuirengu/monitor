<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">用户管理</h3>

				<div class="box-tools">
					<div class="input-group input-group-sm" style="width: 350px;">
						<input type="text" name="table_search" id="searchNameId"
							class="form-control pull-right" placeholder="用户名">

						<div class="input-group-btn">
							<button type="button" class="btn btn-default btn-search">
                                <i class="fa fa-search"></i>
							</button>
							<button type="button" class="btn btn-default btn-add">添加</button>
							<button type="button" class="btn btn-default btn-update">修改</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body table-responsive no-padding">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>certSn</th>
							<th>用户名</th>
							<th>职位</th>
							<th>邮箱</th>
							<th>手机号</th>
							<th>是否启用</th>
							<th>最后登录时间</th>
							<th style="text-align:center; width:150px;">操作</th>
						</tr>
					</thead>
					<tbody id="tbodyId"></tbody>
				</table>
			</div>
			<div id="pageId" class="box-footer clearfix">
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
</div>
<script type="text/javascript">
   $(document).ready(function(){
	   $("#pageId").load("${ctx}/doPageUI",function(){
		   doGetObjects();
	   });
	   $(".input-group-btn")
	   .on("click",".btn-search",doQueryObjects)
	   .on("click",".btn-add,.btn-update",doLoadEditUI);
	   $("tbody").on("click",".btn-valid",doValidById)
	   			 .on("click",".btn-delete",doDeleteById);
	   
   });
   
   function doLoadEditUI(){
	   //1.判定点击的对象
	   var title;
	   if($(this).hasClass("btn-add")){
		   title="添加用户";
		   doLoadPage(title);
	   }else if($(this).hasClass("btn-update")){
		   title="修改用户";
		   var id=doGetCheckedId();
		   console.log("id="+id)
		   if(!id){
			  layer.msg("请先选择");
			  return;
		   }
		   //基于id进行查询并加载编辑页面
		   doFindObjectById(id,title);
	   }
   }
   function doFindObjectById(id,title){
	   //1.params
	   var params={"id":id};
	   //2.url
	   var url="${ctx}/user/doFindObjectById";
	   //3.ajax request
	   $.getJSON(url,params,function(result){//JsonResult
		   if(result.state==1){
			  $("#mainContentId").data("rowData",result.data); 
	          doLoadPage(title);
		   }else{
			  layer.msg(result.message);
		   }
	   });
   }
   
   function doGetCheckedId(){
	 return $("tbody input[name='radioId']:checked").val();
   }
   function doLoadPage(title){
	   var url="${ctx}/user/doUserEditUI"
	   $("#mainContentId").load(url,function(){
		   $(".box-title").html(title);
	   }) 
   }
   //禁用和启用操作
   function doValidById(){
	   //params
	   var rowData=$(this).parents("tr").data("rowData");
	   console.log(rowData);
	   var id=rowData.userId;
	   var newValid=rowData.valid?0:1;
	   
	   var params={"id":rowData.userId,"valid":newValid};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/notify/doValidById";
	   //ajax request
       var btn=$(this);//获取点击的button对象
	   $.post(url,params,function(result){
    	   if(result.state==1){
    		   layer.msg(result.message);
    		   //doGetObjects();//重新查询刷新
    		   //优化方式实现(局部刷新:修改button显示,修改td内容显示)
    		   doEditRow(btn,rowData.isUse);
    	   }else{
    		   layer.msg(result.message);
    	   }
       })    
   }   
   function doDeleteById(){
	   if(!confirm("确认删除吗"))return;
	   //params
	   var rowData=$(this).parents("tr").data("rowData");
	   var id=rowData.userId;
	   
	   var params={"id":rowData.userId};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/user/doDeleteById";
	   //ajax request
       var btn=$(this);//获取点击的button对象
	   $.post(url,params,function(result){
    	   if(result.state==1){
    		   layer.msg(result.message);
    		   doGetObjects();//重新查询刷新
    	   }else{
    		   layer.msg(result.message);
    	   }
       })    
   }    
   function doEditRow(obj,valid){
	   //1.修改按钮上的内容
	   $(obj).html(valid?"启用":"禁用");
	   //2.修改tr中第6个td中的内容(查询API文档)
	   var tr=$(obj).parents("tr");
	   tr.find("td:eq(6)").text(valid?"禁用":"启用");
	   //3.获取当前行tr对象，然后重新绑定新的值
	   var rowData=tr.data("rowData")
	   rowData.isUse=valid?0:1;
	   tr.data("rowData",rowData);
   }
   //处理查询按钮事件
   function doQueryObjects(){
	   $("#pageId").data("pageCurrent",1);
	   doGetObjects();
   }
   //页面加载完成异步加载当前页数据
   function doGetObjects(){
	   var url="${ctx}/user/doFindPageObjects";
	   var pageCurrent=$("#pageId").data("pageCurrent");
	   if(!pageCurrent)pageCurrent=1;
	   var params={"pageCurrent":pageCurrent}
	   params.username=$("#searchNameId").val().trim();
	   params.random = Math.random();
	   //console.log(params);
	   $.getJSON(url,params,function(result){
		  
		   doHandleResponseResult(result);
	   });
   }
   //判断返回数据是否为正常数据
   function doHandleResponseResult(result){
	   if(result.state==1){
		  doSetTableBodyRows(result.data.records);
		  doSetPagination(result.data);
		}else if(result.state == 0){
		  layer.msg(result.message);
	   }else{
		   layer.msg(result.message);
		   doLoadErrorUI();
	   }
   }
   //通过服务端返回的数据初始化页面
   function doSetTableBodyRows(data){
	  //1.获取tbody对象，并清空内容
	  var tBody=$("#tbodyId");
	  tBody.empty();
	  //2.迭代data内容将数据追加到tbody中
	  for(var i in data){
		  var tr=$("<tr></tr>");
		  tr.data("rowData",data[i]);
		  var tds=doCreateTds(data[i]);
		  tr.append(tds);
		  tBody.append(tr);
	  }
   }
   function doCreateTds(row){
	   console.log(row);
	   var tds="<td><input type='radio' name='radioId' value='"+row.userId+"' ></td>"+
	     "<td>"+row.certSn+"</td>"+
	     "<td>"+row.realName+"</td>"+
	     "<td>"+row.post+"</td>"+
	     "<td>"+row.email+"</td>"+
	     "<td>"+row.phone+"</td>"+
	     "<td>"+(row.isUse?"启用":"禁用")+"</td>"+
	     "<td>"+new Date(row.lastLoginTime).toLocaleString()+"</td>"+
	     "<td><button type='button' class='btn btn-default btn-valid'>"+(row.isUse?"禁用":"启用")+"</button>"+
	     "<button style='margin-left:10px;'type='button' class='btn btn-default btn-delete'>"+"删除"+"</button></td>"; 
       return tds;
   }
</script>




