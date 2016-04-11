<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<link
	href="${pageContext.request.contextPath}/static/css/headerStyle.css"
	rel="stylesheet">
</head>
<!-- Navbar -->
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"></ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><i class="fa fa-bell fa-lg"></i> Notifications  <span class="badge">2</span></a></li>
				<li class="dropdown"><a id="userDropDown" href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user fa-2x"></i>
						Welcome, ${loggedInUser}</a>
					<ul class="dropdown-menu">
						<li><a href="#">Settings <span
								class="glyphicon glyphicon-cog pull-right"></span></a></li>
						<li class="divider"></li>
						<li><a href="<c:url value='/j_spring_security_logout'></c:url>">Sign Out<span
								class="glyphicon glyphicon-log-out pull-right"></span></a></li>
					</ul></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>