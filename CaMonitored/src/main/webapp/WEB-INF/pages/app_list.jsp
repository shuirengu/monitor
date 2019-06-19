<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">服务器管理</h3>

				<div class="box-tools">
					<div class="input-group input-group-sm" style="width: 350px;">
						<input type="text" name="table_search" id="searchNameId"
							class="form-control pull-right" placeholder="服务名">

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
							<th>服务名</th>
							<th>服务IP</th>
							<th>服务端口</th>
							<th>服务状态</th>
							<th>唯一标识</th>
							<th>创建时间</th>
							<th>状态更改时间</th>
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
</div>
<script type="text/javascript">
   $(document).ready(function(){
	   $("#pageId").load("${ctx}/doPageUI",function(){
		   doGetObjects();
	   });
	   $(".input-group-btn")
		   .on("click",".btn-search",doQueryObjects)
           .on("click",".btn-add,.btn-update",doLoadEditUI);
	   $("tbody")
		   .on("click",".btn-delete",doDeleteById)
		   .on("click",".btn-valid",doValidById);
	   
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
       var url="${ctx}/app/doFindObjectById";
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
       var url="${ctx}/app/doAppEditUI"
       $("#mainContentId").load(url,function(){
           $(".box-title").html(title);
       })
   }
   //修改服务状态
   function doValidById(){

       var rowData=$(this).parents("tr").data("rowData");
       console.log(rowData);
       var id=rowData.id;
       var newState = rowData.appState == 'UP'?'DOWN':'UP';

       var params={"id":rowData.id,"state":newState,"appIp":rowData.appIp,"appPort":rowData.appPort};
       params.random = Math.random();
       //url
       var url="${ctx}/app/doValidById";
       //ajax request
       var btn=$(this);//获取点击的button对象
       $.post(url,params,function(result){
           if(result.state==1){
               layer.msg(result.message);
               //doGetObjects();//重新查询刷新
               //优化方式实现(局部刷新:修改button显示,修改td内容显示)
               doEditRow(btn,rowData.appState);
           }else{
               layer.msg(result.message);
           }
       })
   }
   function doEditRow(obj,State){
       //1.修改按钮上的内容
       $(obj).html(State == 'UP'?'UP':"DOWN");
       var tr=$(obj).parents("tr");
       tr.find("td:eq(4)").text(State == 'UP'?"DOWN":"UP");
       //3.获取当前行tr对象，然后重新绑定新的值
       var rowData=tr.data("rowData")
       rowData.appState=State == 'UP' ?'DOWN':'UP';
       tr.data("rowData",rowData);
   }
   function doDeleteById(){
	   if(!confirm("确认删除吗"))return;
	   //params
	   var rowData=$(this).parents("tr").data("rowData");
	   var id=rowData.id;	   
	   var params={"id":rowData.id};
	   params.random = Math.random();
	   //url
	   var url="${ctx}/app/doDeleteById";
	   $.post(url,params,function(result){
    	   if(result.state==1){
    		   layer.msg(result.message);
    		   doGetObjects();//重新查询刷新	 
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
	   var url="${ctx}/app/doFindPageObjects";
	   var pageCurrent=$("#pageId").data("pageCurrent");
	   if(!pageCurrent)pageCurrent=1;
	   var params={"pageCurrent":pageCurrent}
	   params.appName=$("#searchNameId").val().trim();
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
			var tBody=$("#tbodyId");
			  tBody.empty();
		  layer.msg(result.message);
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
	   var tds="<td><input type='radio' name='radioId' value='"+row.id+"' ></td>"+
	     "<td>"+row.appName+"</td>"+
	     "<td>"+row.appIp+"</td>"+
	     "<td>"+row.appPort+"</td>"+
	     "<td>"+row.appState+"</td>"+
	     "<td>"+row.serverId+"</td>"+
	     "<td>"+new Date(row.createTime).toLocaleString()+"</td>"+
	     "<td>"+new Date(row.updateTime).toLocaleString()+"</td>"+
	     "<td><button type='button' class='btn btn-default btn-delete'>"+"删除"+"</button>"+
		 "<button style='margin-left:10px;' type='button' class='btn btn-default btn-valid'>"+(row.appState == 'UP'?'DOWN':'UP')+"</button></td>";
       return tds;
   }
</script>




