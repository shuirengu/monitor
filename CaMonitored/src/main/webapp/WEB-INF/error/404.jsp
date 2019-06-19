<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>页面找不到了</title>
<%@ include file="/commons/public/template/error.jspf"%>
</head>
<body>
	<div class="error-wrapper">
		<img src="${ctx}/static/public/img/error.png" />
		<span>404</span>
	</div>
	<div align="center" class="content">
		<span>页面找不到了</span>
	</div>
	<div align="center" class="message">
		<span>${error }</span>
	</div>
</body>
</html>