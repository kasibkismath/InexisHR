<div class="modal fade" tabindex="-1" role="dialog" id="addNewUserModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Add New User</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="addNewUserForm" 
					ng-submit="addNewUserForm.$valid && addNewUser(saveNewUsername, saveNewPassword, saveNewEmail, saveNewAuthority, saveNewEmployee, saveNewEnabled)">
					
					<!-- Alerts when caps lock is on -->
					<div role="alert" class="alert alert-warning padded" 
							ng-show='isCapsLockOn'>
							<strong>Warning!</strong> Caps Lock is ON
					</div>
						
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewUserForm.username.$error.unique"
							ng-if="addNewUserForm.username.$dirty">
							<strong>Error!</strong> Username is already taken, Please enter another username.
						</div>
						<div ng-messages="addNewUserForm.username.$error" role="alert" ng-if="addNewUserForm.username.$dirty">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Username is required
							</div>
							<div ng-message="minlength" class="alert alert-danger padded">
								<strong>Error!</strong> Username must be at least 3 characters long 
							</div>
							<div ng-message="maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Username must be less than 16 characters long 
							</div>
						</div>
						<label class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Username"
								name="username" ng-model="saveNewUsername" ng-minlength="3" 
								ng-maxlength="15" ng-unique required>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewUserForm.password.$error" role="alert" ng-if="addNewUserForm.password.$dirty">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Password is required
							</div>
							<div ng-message="minlength" class="alert alert-danger padded">
								<strong>Error!</strong> Password must be at least 8 characters long 
							</div>
							<div ng-message="maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Password must be less than 25 characters long 
							</div>
						</div>
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" placeholder="Password"
								name="password" ng-model="saveNewPassword" ng-minlength="8" ng-maxlength="25" required>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewUserForm.confirmPassword.$error.match" ng-if="addNewUserForm.confirmPassword.$dirty">
							<strong>Error!</strong> Confirm Password does not match Password
						</div>
						<label class="col-sm-2 control-label">Confirm Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" placeholder="Confirm Password"
								name="confirmPassword" ng-model="saveNewConfirmPassword" match="saveNewPassword" required>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewUserForm.email.$error" role="alert" ng-if="addNewUserForm.email.$dirty">
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
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewUserForm.authority.$error.required" ng-if="addNewUserForm.authority.$dirty">
							<strong>Error!</strong> Authority is required, please select one.
						</div>
						<label class="col-sm-2 control-label">Authority</label>
						<div class="col-sm-10">
							<select ng-model="saveNewAuthority" name="authority" class="form-control" required>
								<option value="" >Select a user role</option>
								<option value="ROLE_ADMIN">ROLE_ADMIN</option>
								<option value="ROLE_CEO">ROLE_CEO</option>
								<option value="ROLE_HR">ROLE_HR</option>
								<option value="ROLE_USER" >ROLE_USER</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewUserForm.employee.$error.required" ng-if="addNewUserForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						<label class="col-sm-2 control-label">Employee</label>
						<div class="col-sm-10">
							<select ng-model="saveNewEmployee" name="employee" class="form-control" required>
								<option value="" >Select an employee</option>
								<option ng-repeat="employee in employees" ng-show="employee.status === true" value="{{employee.empId}}">{{employee.firstName}} {{employee.lastName}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Enabled</label>
						<div class="col-sm-10">
							<input type="checkbox" class="checkbox" ng-model="saveNewEnabled">
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