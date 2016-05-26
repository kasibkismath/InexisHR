<div class="modal fade" tabindex="-1" role="dialog" id="editUserModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Edit User</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="editUserForm">
					<div class="form-group">
						<label class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Username"
								ng-model="getEditUsername" disabled>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="editUserForm.email.$error" role="alert">
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
								name="email" ng-model="getEditEmail"
								ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Authority</label>
						<div class="col-sm-10">
							<select ng-model="getEditAuthority" class="form-control">
								<option value="" disabled>Select a user role</option>
								<option value="ROLE_ADMIN">ROLE_ADMIN</option>
								<option value="ROLE_CEO">ROLE_CEO</option>
								<option value="ROLE_HR">ROLE_HR</option>
								<option value="ROLE_USER" >ROLE_USER</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="editUserForm.employee.$error.required" ng-if="editUserForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						<label class="col-sm-2 control-label">Employee</label>
						<div class="col-sm-10">
							<select ng-model="getEditEmpId" name="employee" class="form-control"  convert-to-number required>
								<option value="" >Select an employee</option>
								<option ng-repeat="employee in employees" value="{{employee.empId}}">{{employee.firstName}} {{employee.lastName}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Enabled</label>
						<div class="col-sm-10">
							<input type="checkbox" class="checkbox" ng-model="getEditEnabled">
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">
					<i class="fa fa-times fa-lg"></i> Close
				</button>
				<button type="button" class="btn btn-success" ng-click="editUserForm.$valid && updateEditUser(getEditUsername, getEditEmail, getEditAuthority, getEditEnabled, getEditEmpId)">
					<i class="fa fa-check fa-lg"></i> Save changes
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