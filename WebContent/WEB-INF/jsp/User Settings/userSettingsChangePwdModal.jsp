<div class="modal show" tabindex="-1" role="dialog" id="userSettingsModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<form class="form-horizontal" name="updateChangePasswordForm">
					<div class="col-sm-10">
							<input type="hidden" class="form-control" 
							name="email" ng-model="getEmail">
					</div>
					<div>
						<h4 id="userSettingsModalTitle">Change Password</h4>
						<hr>
					</div>
					<!-- Alerts when caps lock is on -->
					<div role="alert" class="alert alert-warning padded" 
							ng-show='isCapsLockOn'>
							<strong>Warning!</strong> Caps Lock is ON
					</div>
					<div class="form-group">
						<div ng-messages="updateChangePasswordForm.password.$error" 
							role="alert" ng-if="updateChangePasswordForm.password.$dirty">
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
							name="password" ng-model="changePassword" ng-maxlength="25"
							ng-minlength="8">
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="updateChangePasswordForm.confirmPassword.$error.match" 
							ng-if="updateChangePasswordForm.confirmPassword.$dirty">
							<strong>Error!</strong> Confirm Password does not match Password
						</div>
						<label class="col-sm-2 control-label">Confirm Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" placeholder="Confirm Password"
								name="confirmPassword" ng-model="confirmChangePassword" 
								match="changePassword" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" 
						ng-click="resetToDefaultPassword()">
						<i class="fa fa-times fa-lg"></i> Reset To Default</button>
						
						<button type="button" class="btn btn-success" 
						ng-click="UpdateChangePassword(changePassword, getEmail)">
						<i class="fa fa-floppy-o fa-lg"></i> Save Changes</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</div>
<!-- /.modal -->