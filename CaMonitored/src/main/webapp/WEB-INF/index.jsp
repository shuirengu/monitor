<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.hunca.system.model.SysUser"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--<%
SysUser user = (SysUser)request.getSession().getAttribute("SESSION_SYSUSER");
	String name = user.getRealName();
%>--%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<title>Hunca监控系统</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/static/public/layui/css/layui.css" />
<link rel="stylesheet"
	href="${ctx}/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${ctx}/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${ctx}/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${ctx}/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect. -->
<link rel="stylesheet" href="${ctx}/dist/css/skins/skin-blue.min.css">
<link rel="stylesheet"
	href="${ctx}/bower_components/layer/skin/default/layer.css">
<link rel="stylesheet"
	href="${ctx}/bower_components/ztree/css/metroStyle/metroStyle.css" />
<link rel="stylesheet"
	href="${ctx}/bower_components/treegrid/jquery.treegrid.css" />
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<header class="main-header">

			<!-- Logo -->
			<a href="index2.html" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini">CA</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg">HUNCA</span>
			</a>

			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li class="dropdown messages-menu">
							<ul class="dropdown-menu">
								<li>
									<!-- inner menu: contains the messages -->
									<ul class="menu">
										<li>
											<!-- start message --> <a href="#">
												<div class="pull-left">
													<!-- User Image -->
													<img src="${ctx}/dist/img/user2-160x160.jpg"
														class="img-circle" alt="User Image">
												</div> <!-- Message title and timestamp -->
												<h4>
													Support Team <small><i class="fa fa-clock-o"></i> 5
														mins</small>
												</h4> <!-- The message -->
												<p>Why not buy a new awesome theme?</p>
										</a>
										</li>
										<!-- end message -->
									</ul> <!-- /.menu -->
								</li>
								<li class="footer"><a href="#">See All Messages</a></li>
							</ul>
						</li>
						<li class="dropdown user user-menu">
							<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <!-- The user image in the navbar-->
								<img src="${ctx}/dist/img/user2-160x160.jpg" class="user-image"
								alt="User Image"> <!-- hidden-xs hides the username on small devices so only the image appears. -->
								<span class="hidden-xs"><%--<%=name %>--%></span>
						</a>
						</li>
						<!-- Control Sidebar Toggle Button -->
						<li><a href="${ctx}/admin/doLogout">退出</a></li>
					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="${ctx}/dist/img/user2-160x160.jpg" class="img-circle"
							alt="User Image">
					</div>
					<div class="pull-left info">
						<p><%--<%=name %> --%></p>
						<!-- Status -->
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">HEADER</li>
					<!-- Optionally, you can add icons to the links -->
					</i>
					<i class="fa fa-angle-left pull-right"></i>
					</a>
					
					<li><a id="load-app-id">连接服务管理</a></li>
					<li><a id="load-user-id">系统用户管理</a></li>
					<li><a id="load-log-id">系统日志管理</a></li>
					<li><a id="load-notify-id">通知用户管理</a></li>
					<li><a id="load-config-id">基础配置管理</a></li>
				</ul>
			</section>
		</aside>
		<div class="content-wrapper">
			<section class="content-header">
				<section id="mainContentId" class="content container-fluid">
				</section>
		</div>
		<footer class="main-footer">
			<!-- To the right -->
			<div class="pull-right hidden-xs">Anything you want</div>
			<strong>Copyright &copy; 2016 <a href="#">Company</a>.
			</strong> All rights reserved.
		</footer>

		<div class="control-sidebar-bg"></div>
		<script src="${ctx}/bower_components/jquery/dist/jquery.min.js"></script>
		<!-- Bootstrap 3.3.7 -->
		<script
			src="${ctx}/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
		<!-- AdminLTE App -->
		<script src="${ctx}/dist/js/adminlte.min.js"></script>
		<!-- layui -->
		<script src="${ctx}/static/public/layui/layui.all.js"
			type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
		//页面加载完成以后执行
		$(function() {
			//在id为load-log-id的对象上注册一个点击事件
			doLoadUI("load-log-id", "${ctx}/log/doLogListUI");
			doLoadUI("load-user-id", "${ctx}/user/doUserListUI");
			doLoadUI("load-notify-id", "${ctx}/notify/doNotifyListUI");
			doLoadUI("load-config-id", "${ctx}/config/doConfigEditUI");
			doLoadUI("load-app-id", "${ctx}/app/doAppListUI");
		});
		function doLoadUI(id, url) {
			$("#" + id).click(function() {
				$("#mainContentId").load(url);	
			});
		}
		function doLoadErrorUI(){
			$("#mainContentId").load("${ctx}/error/doError403UI");
		}
	</script>
</body>
</html>