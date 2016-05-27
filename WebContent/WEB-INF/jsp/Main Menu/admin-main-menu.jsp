<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				id="administration-tile">
				<span class="dashboard-title"><i class="fa fa-cogs fa-3x"></i>
					Administration</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="attendance-tile">
				<span class="dashboard-title"><i
					class="fa fa-calendar-check-o fa-2x"></i> Attendance</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="contracts-tile">
				<span class="dashboard-title"><i class="fa fa-files-o fa-3x"></i>
					Contracts</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="employee-tile">
				<span class="dashboard-title"><i class="fa fa-user fa-3x"></i>
					Employee</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="leave-tile">
				<span class="dashboard-title"><i class="fa fa-bed fa-3x"></i>
					Leave</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="performanceAppraisal-tile">
				<span class="dashboard-title"><i class="fa fa-rocket fa-3x"></i>
					Performance</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="projectTeamMember-tile">
				<span class="dashboard-title"><i class="fa fa-users fa-3x"></i>
					Projects &amp; Teams</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="recruitment-tile">
				<span class="dashboard-title"><i
					class="fa fa-user-plus fa-3x"></i> Recruitment</span>
			</div>
			<div class="col-sm-12 col-md-3 col-lg-4 dashboard-tile"
				id="reports-tile">
				<span class="dashboard-title"><i
					class="fa fa-file-pdf-o fa-3x"></i> Reports</span>
			</div>
			<div class="col-sm-12 col-md-offset-4 col-md-3 col-md-offset-5 col-lg-4 dashboard-tile"
				id="training-tile">
				<span class="dashboard-title"><i
					class="fa fa-table fa-3x"></i> Training</span>
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
			src="${pageContext.request.contextPath}/static/js/Main Menu/admin-dashboardScript.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>