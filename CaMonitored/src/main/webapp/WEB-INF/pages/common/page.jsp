<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<ul class="pagination pagination-sm no-margin pull-right">
	<li><a class="first">首页</a></li>
	<li><a class="pre">上一页</a></li>
	<li><a class="next">下一页</a></li>
	<li><a class="last">尾页</a></li>
	<li><a class="rowCount">总记录数(0)</a></li>
	<li><a class="pageCount">总页数(0)</a></li>
	<li><a class="pageCurrent">当前页(1)</a></li>
</ul>
<script type="text/javascript">
     $(function(){
    	//在pageId对应的子元素上注册点击事件
    	//点击元素时执行doJumpToPage函数
    	$("#pageId").on("click",
    			 ".first,.pre,.next,.last",
    			   doJumpToPage);
    	//说明:on函数为一个事件注册函数,允许同时
    	//在多个对象上同时注册事件
     });
     
     //初始化分页信息
     function doSetPagination(pageObject){
    	//1.初始化总记录数
    	$(".rowCount").html("总记录数("+pageObject.rowCount+")");
    	//2.初始化总页数
    	$(".pageCount").html("总页数("+pageObject.pageCount+")");
    	//3.初始化当前页码
    	$(".pageCurrent").html("当前页("+pageObject.pageCurrent+")");
        //4.在页面上存储当前页码值以及总页数
        $("#pageId").data("pageCurrent",pageObject.pageCurrent);
        $("#pageId").data("pageCount",pageObject.pageCount);
     }
     //基于事件执行下一次查询
     function doJumpToPage(){
    	debugger
       //1.修改当前页码值
       //1.1获取当前页码值以及总页数
       var pageCurrent= $("#pageId").data("pageCurrent");
       var pageCount= $("#pageId").data("pageCount");
       //1.2获取点击对象的class属性值
       var cls=$(this).prop("class");//prop-->properties
       //1.3基于class属性值修改pageCurrent
       if(cls=="first"){
    	   pageCurrent=1;
       }else if(cls=="pre"&&pageCurrent>1){//pre
    	   pageCurrent--;
       }else if(cls=="next"&&pageCurrent<pageCount){//next
    	   pageCurrent++;
       }else if(cls=="last"){//last
    	   pageCurrent=pageCount;
       }
       //2.基于当前页码值执行下次查询
       //2.1保存当前页码值
        $("#pageId").data("pageCurrent",pageCurrent);
       //2.2基于页码值执行当前查询
        doGetObjects();
     }
     
     
     
</script>


