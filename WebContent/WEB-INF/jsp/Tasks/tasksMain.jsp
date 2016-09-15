<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en" ng-modules="tasks, adminHeader">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tasks</title>

<!-- JS -->
<script src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
<script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/General/angular-datatables.min.js"></script>

<!-- Angular Data Table and JQuery Data Table CSS-->
<link
	href="${pageContext.request.contextPath}/static/css/General/angular-datatables.min.css"
	rel="stylesheet">
	
<link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Tasks/tasks.css"
	rel="stylesheet">
	
<!-- Angular Toastar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css"
	rel="stylesheet" />
	
<!-- Angular ChartJS CSS -->
<link href="${pageContext.request.contextPath}/static/css/General/angular-chart.min.css" rel="stylesheet">

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">
	
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	
<!-- Character Count -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-character-count.css"/>

<!-- DatePicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-datepicker.min.css"/>

<!-- Dropdowns Enhancement -->
<link href="${pageContext.request.contextPath}/static/css/General/dropdowns-enhancement.css" rel="stylesheet">


</head>
<body ng-controller="tasksMainController" ng-init="init()" ng-cloak>
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>
	
	<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_HR')">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#summary"
							aria-controls="home" role="tab" data-toggle="tab">Summary</a></li>
						<li role="presentation"><a href="#tasks"
							aria-controls="profile" role="tab" data-toggle="tab">Tasks</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-6 col-lg-12">
					<!-- Tab panes -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="summary">
							<h3>From User and HR View Summary</h3>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="tasks">
							<h3>From User and HR View Tasks</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</sec:authorize>
	
	<!-- CEO, Lead Tasks Page -->
	<sec:authorize access="hasAnyRole('ROLE_CEO', 'ROLE_LEAD')">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#leadCeoSummary"
							aria-controls="home" role="tab" data-toggle="tab">Summary</a></li>
						<li role="presentation"><a href="#leadCeoTasks"
							aria-controls="profile" role="tab" data-toggle="tab">Tasks</a></li>
						<sec:authorize access="hasRole('ROLE_LEAD')">
						<li role="presentation"><a href="#myLeadSummary"
							aria-controls="home" role="tab" data-toggle="tab">My Summary</a></li>
						<li role="presentation"><a href="#myLeadTasks"
							aria-controls="profile" role="tab" data-toggle="tab">My Tasks</a></li>
						</sec:authorize>
					</ul>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-6 col-lg-12">
					<!-- Tab panes -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="leadCeoSummary">
							<h3>From Lead and CEO View Summary</h3>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="leadCeoTasks">
							<jsp:include page="Lead and CEO/tasks.jsp"></jsp:include>
						</div>
						<sec:authorize access="hasRole('ROLE_LEAD')">
						<div role="tabpanel" class="tab-pane fade" id="myLeadSummary">
							<h3>From Lead View My Summary</h3>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="myLeadTasks">
							<h3>From Lead View My Tasks</h3>
						</div>
						</sec:authorize>
					</div>
				</div>
			</div>
			</div>
	</sec:authorize>
	
	<!-- toaster -->
	<toaster-container></toaster-container>
	
	<!-- JS-->
	<script>
		var contextPath = "${pageContext.request.contextPath}"
	</script>
	<script>var currentUser = "${loggedInUser}" </script>
	
	<script>var currentUserRole = "${loggedInUserRole}" </script>
	
	
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-character-count.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/dropdowns-enhancement.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-datepicker.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-convert-to-number.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Tasks/tasksAngular.js"></script>
</body>
</html>