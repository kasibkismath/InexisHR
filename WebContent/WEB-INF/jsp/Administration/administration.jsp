<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" ng-modules="administration, adminHeader">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Administration</title>

<!-- JS -->
<script src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
<script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/General/angular-datatables.min.js"></script>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Administration/administrationStyle.css"
	rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Administration/editUserModalStyle.css"
	rel="stylesheet">
	
<!-- Angular Toastar CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css" rel="stylesheet" />

<!-- Glyphicons -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	
<!-- Angular Data Table and JQuery Data Table CSS-->
<link
	href="${pageContext.request.contextPath}/static/css/General/angular-datatables.min.css"
	rel="stylesheet">

<link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">

</head>
<body ng-controller="mainController" ng-init="init()">
	<!-- Header -->
		<jsp:include page="../Header/admin-header.jsp"></jsp:include>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#users"
						aria-controls="users" role="tab" data-toggle="tab">Manage Users</a></li>
					<li role="presentation"><a href="#backup"
						aria-controls="backup" role="tab" data-toggle="tab">Backup and Restore</a></li>
				</ul>
			</div>
	<!-- Tab panes -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-6 col-lg-12">
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane fade" id="backup">
							<!-- Backup Page : JSP  -->
							<jsp:include page="backup.jsp"></jsp:include>
					</div>
					<div role="tabpanel" class="tab-pane fade in active" id="users">
						<div class="pull-right addNewUserBtn">
							<button class="btn btn-warning" id="" data-toggle="modal" data-target="#addNewUserModal">Add New User <i class="fa fa-plus fa-lg"></i></button>
							<!-- Add New User Modal : JSP  -->
							<jsp:include page="addNewUserModal.jsp"></jsp:include>
						</div>
						<table datatable="ng" dt-options="" dt-column-defs=""
							class="table table-hover userList-Table">
							<thead>
							<tr>
								<th>Employee Name</th>
								<th>Username</th>
								<th>Email</th>
								<th>Status</th>
								<th>Role</th>
								<th></th>
							</tr>
							</thead>
							<tbody>
							<tr ng-repeat="user in users">
								<td ng-cloak>{{user.employee.firstName}} {{user.employee.lastName}}</td>
								<td ng-cloak>{{user.username}}</td>
								<td ng-cloak>{{user.email}}</td>
								<td ng-cloak>
									<span ng-if="user.enabled == true">Enabled</span>
									<span ng-if="user.enabled == false">Disabled</span>
								</td>
								<td ng-cloak>
									<span ng-if="user.authority == 'ROLE_ADMIN'">Administrator</span>
									<span ng-if="user.authority == 'ROLE_CEO'">CEO</span>
									<span ng-if="user.authority == 'ROLE_HR'">HR Manager</span>
									<span ng-if="user.authority == 'ROLE_LEAD'">Team Lead</span>
									<span ng-if="user.authority == 'ROLE_USER'">User</span>
								</td>
								<td ng-cloak>
									<button class="btn btn-primary" id="editUser" data-toggle="modal" data-target="#editUserModal" ng-click="editUserMain(user.id)"><i class="fa fa-pencil fa-lg"></i></button>
									<button class="btn btn-danger" id="deleteUser1" data-toggle="modal" data-target="#deleteUserModal" ng-click="deleteUserMain(user.id)" ng-disabled="(user.authority == 'ROLE_ADMIN') || (user.authority == 'ROLE_CEO') || (user.authority == 'ROLE_HR')"><i class="fa fa-trash fa-lg"></i></button>
								</td>
							</tr>
							</tbody>
						</table>
						<!-- Modals Include -->
							<jsp:include page="editUserModal.jsp"></jsp:include>
							<jsp:include page="deleteUserModal.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<!-- toaster -->
	<toaster-container></toaster-container>
	
	<!-- JS-->
	<script>var contextPath = "${pageContext.request.contextPath}" </script>
	<script>var currentUser = "${loggedInUser}"</script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/ng-caps-lock.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-validation-match.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-convert-to-number.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/Administration/administrationAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>