<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Profile</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/Employee Profile/employeeProfileStyle.css"
	rel="stylesheet">

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<!-- Angular Toastar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css"
	rel="stylesheet" />

<!-- Angular Data Table CSS-->
<link
	href="${pageContext.request.contextPath}/static/css/angular-datatables.min.css"
	rel="stylesheet">

</head>
<body>
	<!-- Header -->
	<jsp:include page="../admin-header.jsp"></jsp:include>

	<!-- Scripts -->
	<script
		src="${pageContext.request.contextPath}/static/js/jquery-1.12.2.min.js"></script>
	<script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/angular-datatables.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/ng-caps-lock.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/angular-validation-match.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
</body>
</html>