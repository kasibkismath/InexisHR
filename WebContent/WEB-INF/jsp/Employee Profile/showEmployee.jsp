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

<!-- Angular Toastar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-toaster/1.1.0/toaster.min.css"
	rel="stylesheet" />

<!-- DatePicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-datepicker.min.css"/>

<!-- Character Count -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/General/angular-character-count.css"/>

<!-- Angular Scripts -->


</head>
<body ng-controller="mainController" ng-init="editEmployee(${empId})">
	<!-- Header -->
	<jsp:include page="../Header/admin-header.jsp"></jsp:include>

	<!-- Content -->
	<div class="container">
		<div class="row">
			<div class="col-sm-12 pull-left">
				<h3 class="headingPad">
					<a href="#"><img alt=""
							ng-src="${pageContext.request.contextPath}/static/images/Emp Profile Images/{{editGetImageURL}}"
							class="img-circle employee-image-individual"></a> &nbsp; {{editGetFirstName}} {{editGetLastName}}
				</h3>
				<hr>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 topPad">
				<div class="panel-group" id="accordian">
					<div class="panel panel-info actives">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="accordian-toggle" data-toggle="collapse" data-parent="#accordian"
								href="#basicInfo"><i class="fa fa-info-circle"></i> Employee Basic Information
								</a>
							</h4>
						</div>
						<div id="basicInfo" class="panel-collapse collapse">
							<div class="panel-body">
								<form ng-submit="editGetEmpId, editGetFirstName, editGetLastName, 
									editGetNicNo, editGetEmail, editGetPhoneNo, editGetMobileNo, 
									editGetHireDate, editGetDesignation, editGetEmpType, editGetSalary, 
									editGetBirthday, editGetFile" enctype="multipart/form-data" 
									name="editEmpForm">
									
									<!-- Alerts when caps lock is on -->
									<div role="alert" class="alert alert-warning warningPad" 
									ng-show='isCapsLockOn'>
										<strong>Warning!</strong> Caps Lock is ON
									</div>
									
									<div class="form-group">
    									<label></label>
   										<input type="hidden" ng-model="editGetEmpId" class="form-control">
  									</div>
									<div class="form-group">
										<div ng-messages="editEmpForm.firstName.$error" role="alert" ng-if="editEmpForm.firstName.$dirty">
											<div ng-message="required" class="alert alert-danger padded">
												<strong>Error!</strong> First Name is required
											</div>
											<div ng-message="minlength" class="alert alert-danger padded">
												<strong>Error!</strong> First Name must be at least 3 characters long 
											</div>
											<div ng-message="maxlength" class="alert alert-danger padded">
												<strong>Error!</strong> First Name must be less than 25 characters long 
											</div>
										</div>
    									<label>First Name</label>
   										<input type="text" class="form-control" placeholder="First Name"
   										ng-model="editGetFirstName" name="firstName" ng-minlength="3" 
										ng-maxlength="25" required>
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.lastName.$error" role="alert" ng-if="editEmpForm.lastName.$dirty">
											<div ng-message="required" class="alert alert-danger padded">
												<strong>Error!</strong> Last Name is required
											</div>
											<div ng-message="minlength" class="alert alert-danger padded">
												<strong>Error!</strong> Last Name must be at least 3 characters long 
											</div>
											<div ng-message="maxlength" class="alert alert-danger padded">
												<strong>Error!</strong> Last Name must be less than 25 characters long 
											</div>
										</div>
    									<label>Last Name</label>
   										<input type="text" class="form-control" placeholder="Last Name"
   										ng-model="editGetLastName" name="lastName" ng-minlength="3" 
										ng-maxlength="25" required>
  									</div>
  									<div class="form-group">
  										<div role="alert" class="alert alert-danger padded" 
										ng-show="editEmpForm.nicNo.$error.unique"
										ng-if="editEmpForm.nicNo.$dirty">
										<strong>Error!</strong> Employee with this NIC Number already exists
									</div>
									<div role="alert" class="alert alert-danger padded" ng-if="editEmpForm.nicNo.$dirty"
										ng-show="nicPatternMatchEdit === false">
										<strong>Error!</strong> Invalid NIC Number
									</div>
									<div ng-messages="editEmpForm.nicNo.$error" role="alert" ng-if="editEmpForm.nicNo.$dirty">
										<div ng-message="required" class="alert alert-danger padded">
											<strong>Error!</strong> NIC Number is required
										</div>
										<div ng-message="minlength, maxlength" class="alert alert-danger padded">
											<strong>Error!</strong> NIC Number should be 10 or 12 characters long 
										</div>
									</div>
    									<label>NIC Number</label>
   										<input type="text" class="form-control" placeholder="NIC Number"
   										ng-model="editGetNicNo" required ng-minlength="10" ng-maxlength="12"
   										ng-unique name="nicNo">
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.email.$error" role="alert" ng-if="editEmpForm.email.$dirty">
											<div ng-message="required" class="alert alert-danger padded">
												<strong>Error!</strong> Email is required
											</div>
											<div ng-message="pattern" class="alert alert-danger padded">
												<strong>Error!</strong> Invalid Email
											</div>
										</div>
    									<label>Email</label>
   										<input type="email" class="form-control" placeholder="Email"
   										ng-model="editGetEmail" name="email" required
   										ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/">
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.phoneNumber.$error" role="alert" ng-if="editEmpForm.phoneNumber.$dirty">
											<div ng-message="minlength, maxlength" class="alert alert-danger padded">
												<strong>Error!</strong> Phone Number must be only 10 characters long 
											</div>
											<div ng-message="pattern" class="alert alert-danger padded">
												<strong>Error!</strong> Phone Number should be numeric
											</div>
										</div>
    									<label>Phone Number</label>
   										<input type="text" class="form-control" placeholder="Phone Number"
   										ng-model="editGetPhoneNo" name="phoneNumber" ng-minlength="10"
   										ng-maxlength="10" ng-pattern="/^\d+$/">
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.mobileNumber.$error" role="alert" ng-if="editEmpForm.mobileNumber.$dirty">
											<div ng-message="required" class="alert alert-danger padded">
												<strong>Error!</strong> Mobile Number is required
											</div>
											<div ng-message="minlength, maxlength" class="alert alert-danger padded">
												<strong>Error!</strong> Mobile Number must be only 10 characters long 
											</div>
											<div ng-message="pattern" class="alert alert-danger padded">
												<strong>Error!</strong> Mobile Number should be numeric
											</div>
										</div>
    									<label>Mobile Number</label>
   										<input type="text" class="form-control" placeholder="Mobile Number"
   										ng-model="editGetMobileNo" name="mobileNumber" ng-minlength="10"
   										ng-maxlength="10" ng-pattern="/^\d+$/" required>
  									</div>
  									<div class="form-group">
  										<div role="alert" class="alert alert-warning warningPad" 
										ng-show='error'>
											<strong>Error!</strong> {{error}}
										</div>
    									<label>Hire Date</label>
	   									<datepicker date-format="yyyy-MM-dd" selector="form-control" 
	   										date-max-limit="{{hireDate | date:'yyyy-MM-dd'}}">
										    <input class="form-control" id="hireDate" placeholder="Hire Date" 
										    ng-model="editGetHireDate"/>
										</datepicker>
  									</div>
  									<div class="form-group">
  										<div role="alert" class="alert alert-danger padded" 
										ng-show="editEmpForm.designation.$error.required" 
										ng-if="editEmpForm.designation.$dirty" id="designationErrorMsg">
											<strong>Error!</strong> Designation is required, please select one.
										</div>
    									<label>Designation</label>
   										<select ng-model="editGetDesignation" name="designation" class="form-control" convert-to-number required>
											<option value="" >Select a designation</option>
											<option ng-repeat="designation in designations" value="{{designation.designationId}}">{{designation.name}}</option>
										</select>
  									</div>
  									<div class="form-group">
  										<div role="alert" class="alert alert-danger padded" 
										ng-show="editEmpForm.employmentType.$error.required" 
										ng-if="editEmpForm.employmentType.$dirty">
											<strong>Error!</strong> Employment Type is required, please select one.
										</div>
    									<label>Type of Employment</label>
   										<select ng-model="editGetEmpType" name="employmentType" class="form-control" required>
											<option value="" >Select an employment type</option>
											<option value="Permanent">Permanent</option>
											<option value="Temporary">Temporary</option>
										</select>
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.salary.$error" role="alert" 
  										ng-if="editEmpForm.salary.$dirty">
											<div ng-message="pattern" class="alert alert-danger padded">
												<strong>Error!</strong> Salary should be positive integer
											</div>
										</div>
    									<label>Salary</label>
   										<input type="text" class="form-control" placeholder="Salary"
   										ng-model="editGetSalary" name="salary">
  									</div>
  									<div class="form-group">
    									<label>Birthday</label>
	   									<datepicker date-format="yyyy-MM-dd" selector="form-control" 
	   										date-max-limit="{{hireDate | date:'yyyy-MM-dd'}}">
										    <input class="form-control" id="birthday" placeholder="Birthday" 
										    ng-model="editGetBirthday"/>
										</datepicker>
  									</div>
  									<div class="form-group">
  										<div ng-messages="editEmpForm.file.$error" role="alert" 
  										ng-if="editEmpForm.file.$dirty" id="imageErrorMsg">
											<div ng-message="pattern" class="alert alert-danger padded">
												<strong>Error!</strong> Image Type should be .jpg
											</div>
											<div ng-message="required" class="alert alert-danger padded">
												<strong>Error!</strong> Image is required
											</div>
										</div>
  										<label>Image Upload</label>
  										<span class="imageTypeDesc">Image Type should be: .jpg</span>
  										<input type="file" ngf-select ng-model="editGetFile" name="file" 
  										ngf-pattern="'.jpg'" ngf-accept="'image/*'" ngf-max-size="2MB" 
  										ngf-min-height="50" ngf-resize="{width: 200, height: 150}" required>
  									</div>
  									<div class="form-group">
  										<label>Image Preview</label>
  										<img ngf-thumbnail="editGetFile">
  									</div>
  									<div class="pull-right">
	  									<button type="button" class="btn btn-danger">
											<i class="fa fa-times fa-lg"></i> Clear
										</button>
										<button type="submit" class="btn btn-success" id="editEmpSaveBtn">
											<i class="fa fa-check fa-lg"></i> Save
										</button>
									</div>
								</form>
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
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar pulvinar blandit. Mauris sed imperdiet ex. Suspendisse sed ligula in ex vestibulum gravida. Nulla aliquam erat accumsan ante commodo malesuada. Cras tincidunt rutrum tellus, id placerat neque vestibulum efficitur. Nunc placerat magna et nisl lacinia, id laoreet nisi commodo. Nullam fermentum semper nulla vel volutpat. Nunc placerat sed est mollis feugiat. Etiam sagittis lacus sed augue ultricies, ac aliquet ligula efficitur. Aliquam convallis imperdiet nisi sed porttitor. Sed vitae vehicula quam. Sed lacinia ornare ante sit amet maximus. Sed tellus libero, efficitur id orci sed, cursus ultricies odio. Integer et dapibus justo. Nam porttitor magna ac dui ornare, ut accumsan sapien tincidunt.
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
	<script src="${pageContext.request.contextPath}/static/js/General/jquery-1.12.2.min.js"></script>
	<script src="//code.angularjs.org/1.4.3/angular.min.js"></script>
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
	<script
		src="${pageContext.request.contextPath}/static/js/General/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/Employee Profile/employeeProfileAngular.js"></script>
	<script
			src="${pageContext.request.contextPath}/static/js/Header/adminHeaderAngular.js"></script>
</body>
</html>