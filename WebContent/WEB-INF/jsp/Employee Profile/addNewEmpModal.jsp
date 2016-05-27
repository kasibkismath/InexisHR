<div class="modal fade" tabindex="-1" role="dialog" id="addNewEmpModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Add New Employee</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="addNewEmpForm" 
					ng-submit="addNewEmpForm.$valid && addNewEmp(saveNewFirstName)">
					
					<!-- Alerts when caps lock is on -->
					<div role="alert" class="alert alert-warning padded" 
							ng-show='isCapsLockOn'>
							<strong>Warning!</strong> Caps Lock is ON
					</div>
						
					<div class="form-group">
						<div ng-messages="addNewEmpForm.firstName.$error" role="alert" ng-if="addNewEmpForm.firstName.$dirty">
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
						<label class="col-sm-2 control-label">First Name</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="First Name"
								name="firstName" ng-model="saveNewFirstName" ng-minlength="3" 
								ng-maxlength="25" required>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.lastName.$error" role="alert" ng-if="addNewEmpForm.lastName.$dirty">
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
						<label class="col-sm-2 control-label">Last Name</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Last Name"
								name="lastName" ng-model="saveNewLastName" ng-minlength="3" 
								ng-maxlength="25" required>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.email.$error" role="alert" ng-if="addNewEmpForm.email.$dirty">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Email is required
							</div>
							<div ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Invalid Email
							</div>
						</div>
						<label class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" placeholder="Email"
								name="email" ng-model="saveNewEmail"
								ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/" required>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.phoneNumber.$error" role="alert" ng-if="addNewEmpForm.phoneNumber.$dirty">
							<div ng-message="minlength, maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Phone Number must be at least 10 characters long 
							</div>
							<div ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Phone Number should only contain numeric
							</div>
						</div>
						<label class="col-sm-2 control-label">Phone Number</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Phone Number"
								name="phoneNumber" ng-model="saveNewPhoneNo" ng-minlength="10" 
								ng-maxlength="10" ng-pattern="/^\d+$/">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">
							<i class="fa fa-times fa-lg"></i> Close
						</button>
						<button type="submit" class="btn btn-success" >
							<i class="fa fa-check fa-lg"></i> Save
						</button>
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->