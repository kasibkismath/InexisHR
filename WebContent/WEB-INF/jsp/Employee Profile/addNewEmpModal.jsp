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
					ng-submit="addNewEmpForm.$valid && addNewEmp(saveNewFirstName, saveNewLastName, saveNewNicNo,
					saveNewEmail, saveNewPhoneNo, saveNewMobileNo, saveNewHireDate, saveNewDesignation,
					saveNewEmploymentType, saveNewSalary, saveNewBirthday, saveNewEducation, saveNewPastWork,
					file)" enctype="multipart/form-data">
					
					<!-- Alerts when caps lock is on -->
					<div role="alert" class="alert alert-warning warningPad" 
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
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewEmpForm.nicNo.$error.unique"
							ng-if="addNewEmpForm.nicNo.$dirty">
							<strong>Error!</strong> Employee with this NIC Number already exists
						</div>
						<div role="alert" class="alert alert-danger padded" ng-if="addNewEmpForm.nicNo.$dirty"
							ng-show="nicPatternMatch === false">
							<strong>Error!</strong> Invalid NIC Number
						</div>
						<div ng-messages="addNewEmpForm.nicNo.$error" role="alert" ng-if="addNewEmpForm.nicNo.$dirty">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> NIC Number is required
							</div>
							<div ng-message="minlength, maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> NIC Number should be 10 or 12 characters long 
							</div>
						</div>
						<label class="col-sm-2 control-label">NIC Number</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="NIC Number"
								name="nicNo" ng-model="saveNewNicNo" ng-minlength="10" 
								ng-maxlength="12" ng-unique required>
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
								<strong>Error!</strong> Phone Number must be only 10 characters long 
							</div>
							<div ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Phone Number should be numeric
							</div>
						</div>
						<label class="col-sm-2 control-label">Phone Number</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Phone Number"
								name="phoneNumber" ng-model="saveNewPhoneNo" ng-minlength="10" 
								ng-maxlength="10" ng-pattern="/^\d+$/">
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.mobileNumber.$error" role="alert" ng-if="addNewEmpForm.mobileNumber.$dirty">
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
						<label class="col-sm-2 control-label">Mobile Number</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Mobile Number"
								name="mobileNumber" ng-model="saveNewMobileNo" ng-minlength="10" 
								ng-maxlength="10" ng-pattern="/^\d+$/" required>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-warning warningPad" 
							ng-show='error'>
							<strong>Error!</strong> {{error}}
						</div>
						<label class="col-sm-2 control-label">Hire Date</label>
						<div class="col-sm-10">
							<datepicker date-format="yyyy-MM-dd" selector="form-control" date-max-limit="{{hireDate | date:'yyyy-MM-dd'}}">
							    <div class="input-group">
							        <input class="form-control" placeholder="Choose a date" ng-model="saveNewHireDate"/>
							        <span class="input-group-addon" style="cursor: pointer">
							        <i class="fa fa-lg fa-calendar"></i>
							        </span>
							    </div>
							</datepicker>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewEmpForm.designation.$error.required" ng-if="addNewEmpForm.designation.$dirty">
							<strong>Error!</strong> Designation is required, please select one.
						</div>
						<label class="col-sm-2 control-label">Designation</label>
						<div class="col-sm-10">
							<select ng-model="saveNewDesignation" name="designation" class="form-control" required>
								<option value="" >Select a designation</option>
								<option ng-repeat="designation in designations" value="{{designation.designationId}}">{{designation.name}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="addNewEmpForm.employmentType.$error.required" ng-if="addNewEmpForm.employmentType.$dirty">
							<strong>Error!</strong> Employment Type is required, please select one.
						</div>
						<label class="col-sm-2 control-label">Type of Employment</label>
						<div class="col-sm-10">
							<select ng-model="saveNewEmploymentType" name="employmentType" class="form-control" required>
								<option value="" >Select an employment type</option>
								<option value="Permanent">Permanent</option>
								<option value="Temporary">Temporary</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.salary.$error" role="alert" ng-if="addNewEmpForm.salary.$dirty">
							<div ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Salary should be positive integer
							</div>
						</div>
						<label class="col-sm-2 control-label">Salary</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="Salary"
								name="salary" ng-model="saveNewSalary" ng-pattern="/^(0|[1-9][0-9]*)$/">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Birthday</label>
						<div class="col-sm-10">
							<datepicker date-format="yyyy-MM-dd" selector="form-control" date-max-limit="{{birthday | date:'yyyy-MM-dd'}}">
							    <div class="input-group">
							        <input class="form-control" placeholder="Choose a date" ng-model="saveNewBirthday"/>
							        <span class="input-group-addon" style="cursor: pointer">
							        <i class="fa fa-lg fa-calendar"></i>
							        </span>
							    </div>
							</datepicker>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.education.$error" role="alert" ng-if="addNewEmpForm.education.$dirty">
							<div ng-message="maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Education should be not more than 1000 characters
							</div>
						</div>
						<label class="col-sm-2 control-label">Education</label>
						<div class="col-sm-10">
							<textarea rows="8" class="form-control" name="education" placeholder="Education" 
								ng-model="saveNewEducation" ng-maxlength="1000" char-count warning-count="25" danger-count="10"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.pastWork.$error" role="alert" ng-if="addNewEmpForm.pastWork.$dirty">
								<div ng-message="maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Work Experience should be not more than 5000 characters
							</div>
						</div>
						<label class="col-sm-2 control-label">Work Experience</label>
						<div class="col-sm-10">
							<textarea rows="15" class="form-control" name="pastWork" placeholder="Work Experience" 
								ng-model="saveNewPastWork" ng-maxlength="5000" char-count warning-count="25" danger-count="10"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="addNewEmpForm.file.$error" role="alert" ng-if="addNewEmpForm.file.$dirty">
								<div ng-message="pattern" class="alert alert-danger padded">
								<strong>Error!</strong> Image Type should be .jpg
								</div>
								<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Image is required
								</div>
						</div>
						<label class="col-sm-2 control-label">Image Upload</label>
						<span class="imageTypeDesc">Image Type should be: .jpg</span>
						<div class="col-sm-10">
							<input type="file" ngf-select ng-model="file" name="file" ngf-pattern="'.jpg'"
   								 ngf-accept="'image/*'" ngf-max-size="2MB" ngf-min-height="50" 
    							 ngf-resize="{width: 200, height: 150}" required>
						</div>
					</div>
					<div class="form-group">
							<label class="col-sm-2 control-label">Image Preview</label>
							<div class="col-sm-10">
								<img ngf-thumbnail="file">
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