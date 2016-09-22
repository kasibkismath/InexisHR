<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en" ng-app="adminHeader">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main Menu</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Main Menu/admin-dashboardStyle.css"
	rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">

<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<!-- Fonts -->
<link
	href='https://fonts.googleapis.com/css?family=Noto+Serif|Open+Sans'
	rel='stylesheet' type='text/css'>

</head>
<body>
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>

	<!-- Dashboard Tiles -->
	<div class="container-fluid dashboard-main">
		<div class="row">
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="myProfile-tile">
				<div class="dashboard-title">
					<span id="icon"><i class="fa fa-user fa-3x icon-color"></i></span>
					<br> <span id="textSmall">My Profile</span>
				</div>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="performanceAppraisal-tile">
				<div class="dashboard-title">
					<span id="icon"><i class="fa fa-rocket fa-3x icon-color"></i></span>
					<br> <span id="textMedium">Performance</span>
				</div>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="leave-tile">
				<div class="dashboard-title">
					<span id="icon"><i class="fa fa-bed fa-3x icon-color"></i></span>
					<br> <span id="textXSmall">Leave</span>
				</div>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="attendance-tile">
				<div class="dashboard-title">
					<span id="icon"><i class="fa fa-calendar-check-o fa-3x icon-color"></i></span>
					<br> <span id="textSmall">Attendance</span>
				</div>
			</div>
			<div class="col-md-3 col-sm-12 col-lg-4 dashboard-tile"
				id="tasks-tile">
				<div class="dashboard-title">
					<span id="icon"><i class="fa fa-tasks fa-3x icon-color"></i></span>
					<br>  <span id="textXSmall">Tasks</span>
				</div>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="recruitment-tile">
				<div class="dashboard-title">
					<span id="icon">
						<i class="fa fa-user-plus fa-3x icon-color"></i> 
					</span>
					<br> <span id="textSmall">Recruitment</span>
				</div>
			</div>
		</div>
	</div>

	<!-- Loading Page -->
	<div id="loader"></div>
		<!-- JS-->
		<script
			src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
		<script>
			var contextPath = "${pageContext.request.contextPath}"
		</script>
		<script>var currentUser = "${loggedInUser}"</script>
		<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/Loader/loadingoverlay.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/Main Menu/hr-dashboardScript.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>