<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-modules="empProfile, adminHeader">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Profile</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/Employee Profile/employeeProfileStyle.css"
	rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	
<!-- Bootstrap Switch -->
<link
	href="${pageContext.request.contextPath}/static/css/General/angular-toggle-switch-bootstrap-3.css"
	rel="stylesheet">

<!-- Angular Toastar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css"
	rel="stylesheet" />

<!-- DatePicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-datepicker.min.css"/>

<!-- Character Count -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-character-count.css"/>

<!-- JS -->
<script src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
<script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/General/angular-datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/General/angular-toggle-switch.min.js"></script>


</head>
<body ng-controller="mainController" ng-init="editEmployee(${empId})" ng-cloak>
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>

	<!-- Content -->
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<h3 class="headingPad pull-left">
					<a href="#"><img alt=""
							ng-src="${pageContext.request.contextPath}/static/images/EmpProfileImages/{{editGetImageURL}}"
							class="img-circle employee-image-individual"></a> &nbsp; {{editGetFirstName}} {{editGetLastName}}
				</h3>
				<a href="${pageContext.request.contextPath}/employeeProfile" class="empProfileLink btn btn-primary pull-right">
					<i class="fa fa-undo"></i> Back To Employee Profiles
				</a>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-sm-12 topPad">
				<div class="panel-group" id="accordian">
					<div class="panel panel-info actives">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="accordian-toggle" data-toggle="collapse" data-parent="#accordian"
								href="#basicInfo" aria-expanded="true"><i class="fa fa-info-circle"></i> Employee Basic Information
								</a>
							</h4>
						</div>
						<div id="basicInfo" class="panel-collapse collapse in">
							<div class="panel-body">
								<jsp:include page="basicInfoForm.jsp"></jsp:include>
							</div>
						</div>
					</div>
					<div class="panel panel-success">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="accordian-toggle" data-toggle="collapse" data-parent="#accordian"
								href="#education"><i class="fa fa-graduation-cap"></i> Education
								</a>
							</h4>
						</div>
						<div id="education" class="panel-collapse collapse">
							<div class="panel-body">
								<jsp:include page="educationForm.jsp"></jsp:include>
							</div>
						</div>
					</div>
					<div class="panel panel-warning">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="accordian-toggle" data-toggle="collapse" data-parent="#accordian"
								href="#workHistory"><i class="fa fa-briefcase"></i> Work History
								</a>
							</h4>
						</div>
						<div id="workHistory" class="panel-collapse collapse">
							<div class="panel-body">
								<jsp:include page="workHistory.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	<!-- toaster -->
	<toaster-container></toaster-container>
	
	<!-- Scripts -->
	<script>
		var contextPath = "${pageContext.request.contextPath}"
	</script>
	<script>var currentUser = "${loggedInUser}" </script>
	
	<script
		src="${pageContext.request.contextPath}/static/js/General/dirPagination.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-datepicker.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/ng-caps-lock.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-character-count.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/ng-file-upload.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-capitalize.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-convert-to-number.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-bootstrap-switch.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/Employee Profile/employeeProfileAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>