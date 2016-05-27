<div class="modal show" tabindex="-1" role="dialog" id="userSettingsModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<form class="form-horizontal" ng-init="getUserDetails()" name="updateUserSettingsForm">
					<div>
						<h4 id="userSettingsModalTitle">Profile</h4>
						<hr>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Username"
								ng-model="getUsername" disabled>
						</div>
					</div>
					<div ng-cloak ng-messages="updateUserSettingsForm.email.$error" role="alert">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Email is required
							</div>
							<div ng-cloak ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Invalid Email
							</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" placeholder="Email"
								ng-model="getEmail" name="email" 
								ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" ng-click="resetToDefault()">
						<i class="fa fa-times fa-lg"></i> Reset To Default</button>
						<button type="button" class="btn btn-success" 
						ng-click="updateUserSettingsForm.$valid && updateUserSettingsProfile(getUsername, getEmail)">
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