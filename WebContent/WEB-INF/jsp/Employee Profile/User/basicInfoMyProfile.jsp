<div class="row">
	<div class="col-sm-12 topPad">
		<div class="headingPad pull-left">
			<a href="#">
				<img alt="" 
				ng-src="${pageContext.request.contextPath}/static/images/EmpProfileImages/{{imageURL}}"
				class="img-circle employee-image-individual"></a>
		</div>
		<div>
			<div class="modal show" tabindex="-1" role="dialog" id="basicInfoMyProfileModal">
  				<div class="modal-dialog">
    				<div class="modal-content">
    					<div class="modal-header">
        					<h3 class="modal-title">Basic Information</h3>
     					</div>
      					<div class="modal-body">
        					<form class="form-horizontal">
							  <div class="form-group">
							    <label class="col-sm-2 control-label">First Name</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{firstName}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Last Name</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{lastName}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Email</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{email}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Status</label>
							    <div class="col-sm-10">
							      <p class="form-control-static" ng-if="status === true">Enabled</p>
							      <p class="form-control-static" ng-if="status === false">Disabled</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Designation</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{designation}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">NIC No</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{nicNo}}</p>
							    </div>
							  </div>
							   <div class="form-group">
							    <label class="col-sm-2 control-label">Type of Employment</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{employmentType}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Phone No</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{phoneNumber}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Mobile No</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{mobileNumber}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Hired Date</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{hireDate}}</p>
							    </div>
							  </div>
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Birthday</label>
							    <div class="col-sm-10">
							      <p class="form-control-static">{{birthDate}}</p>
							    </div>
							  </div>
							</form>
      					</div>
				    </div>
				 </div>
			</div>
		</div>
	</div>
</div>