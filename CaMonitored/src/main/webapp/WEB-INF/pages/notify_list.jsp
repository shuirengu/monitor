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
							<th>用户名</th>
							<th>邮箱</th>
							<th>手机号</th>
							<th>状态</th>
							<th>创建时间</th>			
							<th style="text-align:center;" >操作</th>
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
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">关联服务器</h4>
            </div>
            <div class="modal-body" style="text-align: center;">
            	<div id="connect" style="text-align: center;">
            		数据正在加载中......
            	</div>
            
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</div>
<script type="text/javascript">
	var transfer = layui.transfer;
	
   $(document).ready(function(){
	   $("#pageId").load("${ctx}/doPageUI",function(){
		   doGetObjects();
	   });
	   $(".input-group-btn")
	   .on("click",".btn-search",doQueryObjects)
	   .on("click",".btn-add,.btn-update",doLoadEditUI);
	   $("tbody").on("click",".btn-connect",doConnectById)
	   			 .on("click",".btn-delete",doDeleteById)
	   			 .on("click",".btn-valid",doValidById);
	   $(".modal-footer").on("click",".btn-primary",doUpdateAppUser);
   });
   
   function doUpdateAppUser(){
	   var userId = $("#myModal").data("userId");
	   console.log(userId);
	   var data = transfer.getData('demo'); 
	   var ids ="";
	 	$.each(data,function(index,item){
	 		ids+=item.value+",";
	 	})
	 	console.log(ids);
	   var url = "${ctx}/notify/doUpdateAppUser";
	   var params = {"ids":ids,"id":userId};
	   $.getJSON(url,params,function(result){
		   if(result.state == 1){
			   layer.msg(result.message);
			   $('#myModal').modal('hide');
		   }else{
			   layer.msg(result.message);
		   }
	   })
   }
   
   
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
	   var url="${ctx}/notify/doFindObjectById";
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
	   var url="${ctx}/notify/doNotifyEditUI"
	   $("#mainContentId").load(url,function(){
		   $(".box-title").html(title);
	   }) 
   }
   function doDeleteById(){
	   if(!confirm("确认删除吗"))return;
	   //params
	   var rowData=$(this).parents("tr").data("rowData");
	   var id=rowData.id;
	   
	   var params={"id":rowData.id};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/notify/doDeleteById";
	   $.post(url,params,function(result){
    	   if(result.state==1){
    		   layer.msg(result.message);
    		   doGetObjects();//重新查询刷新
    		   //优化方式实现(局部刷新:修改button显示,修改td内容显示)   		 
    	   }else{
    		   layer.msg(result.message);
    	   }
       })    
   }    
   //处理查询按钮事件
   function doQueryObjects(){
	   $("#pageId").data("pageCurrent",1);
	   doGetObjects();
   }
   //页面加载完成异步加载当前页数据
   function doGetObjects(){
	   var url="${ctx}/notify/doFindPageObjects";
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
	   var tds="<td><input type='radio' name='radioId' value='"+row.id+"'></td>"+
	     "<td>"+row.realName+"</td>"+
	     "<td>"+row.email+"</td>"+
	     "<td>"+row.phone+"</td>"+
	     "<td>"+(row.state?"启用":"禁用")+"</td>"+
	     "<td>"+new Date(row.createTime).toLocaleString()+"</td>"+
	     "<td style='text-align:center;'>"+
	     "<button type='button' class='btn btn-default btn-valid'>"+(row.state?"禁用":"启用")+"</button>"+
	     "<button style='margin-left:10px;' type='button' class='btn btn-default btn-delete'>"+"删除"+"</button>"+
	     "<button style='margin-left:10px;'type='button' class='btn btn-default btn-connect' data-toggle='modal' data-target='#myModal'>关联服务</button></td>"; 
       return tds;
   }
 //禁用和启用操作
   function doValidById(){
	   //params
	   var rowData=$(this).parents("tr").data("rowData");
	  
	  
	   var newValid=rowData.state?0:1;
	   
	   var params={"id":rowData.id,"valid":newValid};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/notify/doValidById";
	   //ajax request
       var btn=$(this);//获取点击的button对象
	   $.post(url,params,function(result){
    	   if(result.state==1){
    		   layer.msg(result.message);
    		   doEditRow(btn,rowData.state);
    	   }else{
    		   layer.msg(result.message);
    	   }
       })    
   } 
   function doEditRow(obj,valid){
	   //1.修改按钮上的内容
	   $(obj).html(valid?"启用":"禁用");
	   var tr=$(obj).parents("tr");
	   tr.find("td:eq(4)").text(valid?"禁用":"启用");
	   //3.获取当前行tr对象，然后重新绑定新的值
	   var rowData=tr.data("rowData")
	   rowData.state=valid?0:1;
	   tr.data("rowData",rowData);
   }
   function doConnectById(){
	   var rowData=$(this).parents("tr").data("rowData");
	   var id=rowData.id;
	   $("#myModal").data("userId",id);
	   var params={"id":rowData.id};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/notify/doFindAppById";
	   $.getJSON(url,params,function(result){
			console.log(result);
		   if(result.state == 1){
			   $("#connect").html("");
				   layui.use('transfer', function(){
				   		
				   		var res = result.data.allApp;
				    //渲染
				    transfer.render({
				      elem: '#connect'  //绑定元素
				      ,data:res
				      ,parseData: function(res){
				    		  return {
				    		      "value": res.id //数据值
				    		      ,"title": res.appName //数据标题
				    		      ,"disabled": "" //是否禁用
				    		      ,"checked": ""//是否选中
				    		    }
				     }
				      ,showSearch:true//打开搜索框
				      ,title:["所有服务","已关联服务"]
				      ,value:result.data.conApp
				      ,id:"demo"
				    });
				  });
				   
		   }else{
			  layer.msg(result.message);
		   }
		   
   })  
				
}
</script>