<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en" ng-modules="myProfile, adminHeader">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Profile</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Employee Profile/User/myProfileStyle.css"
	rel="stylesheet">

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	
<!-- JS -->
<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>

</head>
<body ng-controller="myProfileMainController" ng-init="getEmployeeInfoByUsername()" ng-cloak>
	<!-- Header -->
	<jsp:include page="../../Header/admin-header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#basic"
						aria-controls="home" role="tab" data-toggle="tab">Basic Information</a></li>
					<li role="presentation"><a href="#education"
						aria-controls="profile" role="tab" data-toggle="tab">Education</a></li>
					<li role="presentation"><a href="#work"
						aria-controls="profile" role="tab" data-toggle="tab">Work Experience</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- Tab panes -->
		<div class="container">
			<div class="row">
				<div class="col-xs-6 col-lg-12">
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="basic">
							<jsp:include page="basicInfoMyProfile.jsp"></jsp:include>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="education" ng-cloak>
							<h4>Hello Education !!</h4>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="work" ng-cloak>
							<h4>Hello Work !!!</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!-- JS-->
	<script>
		var contextPath = "${pageContext.request.contextPath}"
	</script>
	<script>var currentUser = "${loggedInUser}" </script>
	
	<script
		src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Employee Profile/User/myProfileAngular.js">
	</script>
</body>
</html>