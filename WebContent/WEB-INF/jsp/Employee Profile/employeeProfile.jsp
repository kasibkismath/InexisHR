<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-modules="empProfile, adminHeader" class="ng-cloak">
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

<!-- Angular Toastar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css"
	rel="stylesheet" />

</head>
<body ng-controller="mainController">
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>
	
	<jsp:include page="addNewEmpModal.jsp"></jsp:include>

	<!-- Content -->
	<div class="container">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="headingPad">
					<i class="fa fa-users fa-lg"></i> Employee Profiles
				</h3>
			</div>
			<div class="row">
			<div class="col-sm-offset-4 col-sm-2" id="addNewEmpBtn"> <button class="btn btn-success" id="" data-toggle="modal" data-target="#addNewEmpModal">Add New Employee &nbsp;<i class="fa fa-plus-circle fa-lg"></i></button></div>
		</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-sm-4">
				<div class="input-group">
					<span class="input-group-addon" id="searchBoxGlyp"><i
						class="fa fa-search fa-lg"></i></span> <input type="text"
						class="form-control" ng-model="q" placeholder="Search" id="searchBox">
				</div>
			</div>
			<div class="col-sm-4 col-sm-offset-4">
				<div class="input-group">
					<span class="input-group-addon" id="showListGlyp">No of Items</span> <input type="number" min="10"
						max="100" class="form-control" ng-model="pageSize" id="showListBox">
				</div>
			</div>
		</div>
		<!-- List Group Start -->
		<ul class="list-group">
			<!-- List Group Item Start -->
			<li class="list-group-item colored customList col-md-offset-1 col-md-5"
				dir-paginate="employee in employees | filter:q | itemsPerPage: pageSize">
				<div class="row">
					<br>
					<div class="col-md-3 col-sm-3 text-center">
						<a href="#"><img alt=""
							ng-src="${pageContext.request.contextPath}/static/images/Emp Profile Images/{{employee.imageURL}}"
							class="img-circle employee-image"></a>
					</div>
					<div class="col-md-9 col-sm-9">
						<div class="row">
							<div class="col-xs-12">
								<h3 class="empName" ng-cloak>{{employee.firstName}}
									{{employee.lastName}}</h3>
								<h4>
									<span class="label label-default" ng-cloak>{{employee.designation}}</span>
								</h4>
								<h5>
									<small class="text-muted"><a href="${pageContext.request.contextPath}/employeeProfile/employee/getById?EmpID={{employee.empId}}"
										class="btn btn-info" ng-cloak>For more info</a></small>
								</h5>
							</div>
						</div>
					</div>
				</div>
				<hr>
			</li>
		</ul>
		<div class="text-center">
          <dir-pagination-controls boundary-links="true" template-url="${pageContext.request.contextPath}/static/js/General/dirPagination.tpl.html"></dir-pagination-controls>
          </div>
	</div>
	
	<!-- Scripts -->
	<script>
		var contextPath = "${pageContext.request.contextPath}"
	</script>
	<script>var currentUser = "${loggedInUser}" </script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/dirPagination.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/ng-caps-lock.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/Employee Profile/employeeProfileAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>