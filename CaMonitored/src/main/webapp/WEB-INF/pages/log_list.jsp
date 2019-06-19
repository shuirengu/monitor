<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">日志管理</h3>

				<div class="box-tools">
					<div class="input-group input-group-sm" style="width: 350px;">
						<input type="text" name="table_search" id="searchNameId"
							class="form-control pull-right" placeholder="用户名">

						<div class="input-group-btn">
							<button type="button" class="btn btn-default btn-search">
                                <i class="fa fa-search"></i>
							</button>
							<button type="button" class="btn btn-default btn-delete">删除</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body table-responsive no-padding">
				<table class="table table-hover">
					<thead>
						<tr>
						    <th><input type="checkbox" id="checkAll">全选</th>
							<th>用户名</th>
							<th>操作</th>
							<th>IP地址</th>
							<th>执行时间</th>
							<th>创建时间</th>
						</tr>
					</thead>
					<tbody id="tbodyId">
					  <tr>
					    <td colspan="7">数据正在加载中....</td>
					  </tr>
					</tbody>
				</table>
			</div>
			<div id="pageId" class="box-footer clearfix">
			    <!-- 加载分页页面 --> 
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
</div>

<script type="text/javascript">
     //load函数语法:load(url,[params],[callback])
     $(function(){
    	 //debugger
    	 //异步加载分页页面
    	 $("#pageId").load("${ctx}/doPageUI",function(){
    	   //debugger
    		//当异步函数load方法执行结束执行数据加载
    		//通过此方法异步加载数据,然后将数据更新到tbody中
    	    doGetObjects()
    	 });
    	 //在查询按钮上注册点击事件
    	 $(".input-group-btn")//div
    	 .on("click",".btn-search",doQueryObjects)
    	 .on("click",".btn-delete",doDeleteObjects)
         //点击thead中的checkbox时修改tbody中checkbox状态
         $("thead")
    	 .on("change","#checkAll",doChangeTBodyCheckBoxState);
         //点击tbody中的checkbox时修改thead中checkbox状态
         $("#tbodyId")
         .on("change",".cBox",doChangeTHeadCheckBoxState);
     });
     //修改thead中checkbox状态
     function doChangeTHeadCheckBoxState(){
    	//1.给定一个标记初始化
    	var flag=true;
    	//2.获取tbody中checkbox的值并进行逻辑与操作
    	$("#tbodyId input[name='cItem']")
    	.each(function(){
    		flag=flag&&$(this).prop("checked");
    	});
    	//3.修改thead中checkbox的值
    	$("#checkAll").prop("checked",flag);
     }
     //修改tbody中checkbox状态
     function doChangeTBodyCheckBoxState(){
    	 //1.获取thead中checkbox状态(全选)
    	 var flag=$("#checkAll").prop("checked");
    	 //2.修改tbodycheckbox状态
    	 $("#tbodyId input[type='checkbox']")
    	 .prop("checked",flag);
     } 
     function doGetCheckedIds(){
    	//1.定义数组,存储选中的id值
    	var array=[];//new Array();
    	//2.迭代tbody中的复选框checkbox
    	$("#tbodyId input[type='checkbox']")
    	.each(function(){//each为jquery中的一个迭代函数
    		//当this指向的checkbox选中时
    		if($(this).prop("checked")){
    			//将选中的checkbox值存储到array
    			array.push($(this).val());
    		}
    	});
    	return array;
     }
     //基于选中记录进行删除操作
     function doDeleteObjects(){
    	 
    	 //1.获取选中记录id,并进行判定
    	  var idArray=doGetCheckedIds();
    	  if(idArray.length==0){
    		 layer.msg("请先选择");
    		 return;
    	  }
    	 //2.给出提示确认删除吗?
    	  if(!confirm("确认删除吗"))return;
    	 // console.log(idArray);
    	 //3.发送异步请求执行删除操作
    	 //3.1构建请求参数
    	 var params={"ids":idArray.toString()};//1,2,3,4
         //3.2构建请求的url
         var url="${ctx}/log/doDeleteObjects";
         //3.3提交异步请求
         $.post(url,params,function(result){
        	if(result.state==1){
        		layer.msg(result.message);
        		doSetPageCurrent();
        		doGetObjects();
        	}else{
        		layer.msg(result.message);
        	}
         });
     }
     
     function doSetPageCurrent(){
    	 var pageCount=$("#pageId").data("pageCount");
    	 var pageCurrent=$("#pageId").data("pageCurrent");
    	 var checked=$("#checkAll").prop("checked");
    	 if(pageCurrent==pageCount&&checked&&pageCurrent>1){
    		 pageCurrent--;
    		 $("#pageId").data("pageCurrent",pageCurrent);
    	 }
     }
     
     function doQueryObjects(){
    	 //1.修改当前页码值
    	 $("#pageId").data("pageCurrent",1);
    	 //2.重新执行查询操作
    	 doGetObjects();
     }
     function doGetObjects(){
    	 //1.请求参数定义
    	 var pageCurrent=
    	 $("#pageId").data("pageCurrent");
    	 //假如pageCurrent没有值则赋值为1
    	 if(!pageCurrent) pageCurrent=1;
    	 var params={"pageCurrent":pageCurrent};
    	 //当查询时获取用户输入的内容(借助jquery中的val()函数)
    	 var uname=$("#searchNameId").val();
    	 if(uname)params.username=uname;
    	 params.random = Math.random();
    	 
    	 //2.请求url定义
    	 var url="${ctx}/log/doFindPageObjects";
    	 //3.发起异步请求获取数据(借助jquery中的getJSON)
    	 $.getJSON(url,params,function(result){//callback
    	     doHandleResponseResult(result);//JsonResult
    	 });//ajax (xhr)
     }
     //处理服务端的响应结果
     function doHandleResponseResult(result){
    	  if(result.state==1){//jsonResult.state
    	   $("#checkAll").prop("checked",false);
    	   //显示当前日志数据 
    	   doSetTableBodyRows(result.data.records);
    	   //显示分页信息
    	   doSetPagination(result.data);//PageObject
    	  }else if(result.state == 0){
    		  layer.msg(result.message);
   	 	  }else{
   	 		layer.msg(result.message);
   		   doLoadErrorUI();
     }
     }
     function doSetTableBodyRows(records){
    	//1.获取tbody对象,并清空原有内容
    	var tBody=$("#tbodyId");
    	tBody.empty();//tBody.innerHTML="";
    	//2.迭代records记录,然后追加到tbody中
    	for(var i=0;i<records.length;i++){
    		//2.1创建tr对象
    		var tr=$("<tr></tr>");
    		//2.2创建td对象
    		var tds=doCreateTds(records[i]);
    		//2.3将td追加到tr
    		tr.append(tds);
    		//2.4将tr追加到tbody
    		tBody.append(tr);
    	}
     }
     function doCreateTds(data){
    	 console.log(data);
  	        var tds="<td><input type='checkbox' class='cBox' name='cItem' value='"+data.id+"'></td>"+
  		   	 "<td>"+data.username+"</td>"+
  		     "<td>"+data.operation+"</td>"+
  		     "<td>"+data.ip+"</td>"+
  		     "<td>"+data.time+"毫秒</td>"+
  		     "<td>"+new Date(data.createdTime).toLocaleString()+"</td>";	   
            return tds;
     }      
</script>




