﻿<%
/*
引入湖南CA控件公共包含JSP，主要完成以下两个工作。
*/
 %>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/jquery.sprintf.js"></script>
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/objectclass.js"></script>
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/syan.activex.src.js"></script>
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/netonex.base.src.js"></script> 
    <script type="text/javascript" src="<%=basePath%>/Hunca_JS/netone/hunca_netone_std_core.js"></script>
    
  </head>
  <body>
  
 <!--声明CA控件-->
<div action="netonex" netonexid="netonex" activex32_codebase="./js/NetONEX32.v1.3.4.0.cab"
     activex64_codebase="./js/NetONEX64.v1.3.4.0.cab" npapi_codebase="./js/NetONEX.v1.3.4.0.msi" version="1.3.4.0" style="width:0px;height: 0px">
</div>
<!--声明CA控件-->
	

  </body>
</html>
