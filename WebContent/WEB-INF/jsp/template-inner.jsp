<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/administrationStyle.css"
	rel="stylesheet">

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

</head>
<body>
	<!-- Header -->
	<jsp:include page="admin-header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h3></h3>
				<hr>
			</div>
			<div class="col-lg-12">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#users"
						aria-controls="home" role="tab" data-toggle="tab">Manage Users</a></li>
					<li role="presentation"><a href="#backups"
						aria-controls="profile" role="tab" data-toggle="tab">Backup</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- JS-->
	<script
		src="${pageContext.request.contextPath}/static/js/jquery-1.12.2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
</body>
</html>