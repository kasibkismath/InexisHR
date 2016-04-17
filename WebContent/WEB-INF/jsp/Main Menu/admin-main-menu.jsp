<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
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
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="administration-tile">
				<span class="dashboard-title"><i class="fa fa-cogs fa-lg"></i>
					Administration</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="attendance-tile">
				<span class="dashboard-title"><i
					class="fa fa-calendar-check-o fa-lg"></i> Attendance</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="contracts-tile">
				<span class="dashboard-title"><i class="fa fa-files-o fa-lg"></i>
					Contracts</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="employee-tile">
				<span class="dashboard-title"><i class="fa fa-user fa-lg"></i>
					Employee</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="leave-tile">
				<span class="dashboard-title"><i class="fa fa-bed fa-lg"></i>
					Leave</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="performanceAppraisal-tile">
				<span class="dashboard-title"><i class="fa fa-rocket fa-lg"></i>
					Performance</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="projectTeamMember-tile">
				<span class="dashboard-title"><i class="fa fa-users fa-lg"></i>
					Projects &amp; Teams</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="recruitment-tile">
				<span class="dashboard-title"><i
					class="fa fa-user-plus fa-lg"></i> Recruitment</span>
			</div>
			<div class="col-sm-12 col-md-4 col-lg-4 dashboard-tile"
				id="reports-tile">
				<span class="dashboard-title"><i
					class="fa fa-file-pdf-o fa-lg"></i> Reports</span>
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
			var myContextPath = "${pageContext.request.contextPath}"
		</script>
		<script
			src="${pageContext.request.contextPath}/static/js/Loader/loadingoverlay.js"></script>
		<script
			src="${pageContext.request.contextPath}/static/js/Main Menu/admin-dashboardScript.js"></script>
</body>
</html>