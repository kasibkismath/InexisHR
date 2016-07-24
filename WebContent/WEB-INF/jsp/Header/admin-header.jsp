<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- Navbar -->
<nav class="navbar navbar-default" ng-controller="headerController" ng-init="getCurrentUser()">
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
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/admin-main-menu"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_USER')">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/user-main-menu"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_CEO')">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/ceo-main-menu"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_HR')">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/hr-main-menu"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_LEAD')">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/lead-main-menu"><img id="inexisBrand"
				class="img-responsive" alt="brand"
				src="${pageContext.request.contextPath}/static/images/inexis-brand.jpg"></a>
			</sec:authorize>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"></ul>
			<ul class="nav navbar-nav navbar-right">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li>
						<a href="${pageContext.request.contextPath}/admin-main-menu">
						<i class="fa fa-location-arrow fa-lg"></i> Go to Main Menu</a>
					</li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_USER')">
					<li>
						<a href="${pageContext.request.contextPath}/user-main-menu">
						<i class="fa fa-location-arrow fa-lg"></i> Go to Main Menu</a>
					</li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_CEO')">
					<li>
						<a href="${pageContext.request.contextPath}/ceo-main-menu">
						<i class="fa fa-location-arrow fa-lg"></i> Go to Main Menu</a>
					</li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_HR')">
					<li>
						<a href="${pageContext.request.contextPath}/hr-main-menu">
						<i class="fa fa-location-arrow fa-lg"></i> Go to Main Menu</a>
					</li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_LEAD')">
					<li>
						<a href="${pageContext.request.contextPath}/lead-main-menu">
						<i class="fa fa-location-arrow fa-lg"></i> Go to Main Menu</a>
					</li>
				</sec:authorize>
				
				<li class="dropdown"><a id="userDropDown" href="#" class="dropdown-toggle"
					data-toggle="dropdown">
					<img ng-src="${pageContext.request.contextPath}/static/images/EmpProfileImages/{{userImage}}"  class="img-circle" id="loggedInUserImg">
						Welcome, ${loggedInUser}</a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.request.contextPath}/user/settings">Settings <span
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