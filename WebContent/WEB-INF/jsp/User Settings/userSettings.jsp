<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="userSetting">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Settings</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<link
	href="${pageContext.request.contextPath}/static/css/User Settings/userSettingsStyle.css"
	rel="stylesheet">
	
<!-- Angular Toastar CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css" rel="stylesheet" />

</head>
<body ng-controller="mainController">
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<h3>
					<i class="fa fa-cog fa-lg"></i> Account Setting
				</h3>
				<hr>
				<div>
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#profile"
							aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
						<li role="presentation"><a href="#changePassword"
							aria-controls="home" role="tab" data-toggle="tab">Change Password</a></li>
					</ul>
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="profile">
							<!-- User Settings Profile Modal  -->
							<jsp:include page="userSettingsProfileModal.jsp"></jsp:include>
						</div>
						<div role="tabpanel" class="tab-pane" id="changePassword">
							<!-- User Settings Change Password Modal  -->
							<jsp:include page="userSettingsChangePwdModal.jsp"></jsp:include>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- toaster -->
	<toaster-container></toaster-container>
	
	<!-- JS-->
	<script>var username = "${loggedInUser}" </script>
	<script>var contextPath = "${pageContext.request.contextPath}" </script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/ng-caps-lock.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/angular-validation-match.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/User Settings/userSettingsAngular.js"></script>

</body>
</html>