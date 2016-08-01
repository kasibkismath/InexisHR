<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" ng-modules="performance, adminHeader">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Performance</title>

<!-- CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/General/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/static/css/Header/adminHeaderStyle.css"
	rel="stylesheet">
	
<link
	href="${pageContext.request.contextPath}/static/css/Performance/performance.css"
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

<!-- Dropdowns Enhancement -->
<link href="${pageContext.request.contextPath}/static/css/General/dropdowns-enhancement.css" rel="stylesheet">


<!-- JS -->
<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
<script src="//code.angularjs.org/1.4.3/angular-messages.min.js"></script>
<script src="//code.angularjs.org/1.4.3/angular-animate.min.js"></script>

</head>
<body ng-controller="performanceMainController" ng-cloak>
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#summary"
						aria-controls="home" role="tab" data-toggle="tab">Summary</a></li>
					<li role="presentation"><a href="#appraisals"
						aria-controls="profile" role="tab" data-toggle="tab">Appraisals</a></li>
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
						<jsp:include page="summary.jsp"></jsp:include>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="appraisals">
						<jsp:include page="appraisals.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- toaster -->
	<toaster-container></toaster-container>
	
	<!-- JS-->
	<script>
		var contextPath = "${pageContext.request.contextPath}"
	</script>
	<script>var currentUser = "${loggedInUser}" </script>
	
	<script
		src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular.ng-modules.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/angular-character-count.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/General/dropdowns-enhancement.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Performance/performanceAngular.js"></script>
	<script>
		$("[data-toggle='tooltip']").tooltip();
	</script>
</body>
</html>