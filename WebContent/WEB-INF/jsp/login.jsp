<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign In</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/loginStyle.css"
	rel="stylesheet" type="text/css">

<!-- Glyphicon CDNs -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

</head>
<body>
	<div class="container login-page">
		<!--login modal-->
		<div class="row">
			<div class="col-md-12">
				<div id="loginModal" class="modal show" tabindex="-1" role="dialog"
					aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<img id="inexisImg" class="img-responsive" alt=""
									src="${pageContext.request.contextPath}/static/images/inexis-small.jpg">
								<h2 class="text-center">Sign In</h2>
							</div>
							<div class="modal-body">
								<form class="form col-md-12 center-block"
									action="${pageContext.request.contextPath}/j_spring_security_check"
									method="post">
									<c:if test="${param.error != null}">
										<div class="alert alert-danger" role="alert">Login
											Failed! Check your username or password.</div>
									</c:if>
									<div class="form-group" id="username">
										<input type="text" id="loginUsername"
											class="form-control input-lg" placeholder="Username"
											name="j_username">
									</div>
									<div class="form-group" id="password">
										<input type="password" id="loginPassword"
											class="form-control input-lg" placeholder="Password"
											name="j_password">
									</div>
									<div class="form-group">
										<div class="checkbox">
											<label> <input type="checkbox"
												name="_spring_security_remember_me"> Remember me
											</label>
										</div>
									</div>
									<div class="form-group">
										<button type="submit" id="signInBtn"
											class="btn btn-success btn-lg btn-block signIn-btn">
											<i class="fa fa-lock fa-lg"></i> Sign In
										</button>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<div class="col-md-12">
									<button class="btn cancel-btn btn-danger" data-dismiss="modal"
										aria-hidden="true" id="loginCancel">
										<i class="fa fa-times fa-lg"></i> Cancel
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- JS-->
	<script
		src="${pageContext.request.contextPath}/static/js/jquery-1.12.2.min.js"></script>
	<script>
		var error = ${param.error != null};
	</script>
	<script
		src="${pageContext.request.contextPath}/static/js/loginScript.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
</body>
</html>