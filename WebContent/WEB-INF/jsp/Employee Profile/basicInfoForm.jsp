									<form name="editEmpForm"
									ng-submit="editEmpForm.$valid && updateEmpDetails(editGetEmpId, editGetFirstName, editGetLastName, 
									editGetNicNo, editGetEmail, editGetPhoneNo, editGetMobileNo, 
									editGetHireDate, editGetDesignation, editGetEmpType, editGetSalary, 
									editGetBirthday, editGetFile)" enctype="multipart/form-data">
									
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
										</div>
  										<label>Image Upload</label>
  										<span class="imageTypeDesc">Image Type should be: .jpg</span>
  										<input type="file" ngf-select ng-model="editGetFile" name="file" 
  										ngf-pattern="'.jpg'" ngf-accept="'image/*'" ngf-max-size="2MB" 
  										ngf-min-height="50" ngf-resize="{width: 200, height: 150}">
  									</div>
  									<div class="form-group">
  										<label>Image Preview</label>
  										<img ngf-thumbnail="editGetFile">
  									</div>
  									<div class="pull-right">
	  									<button type="button" class="btn btn-danger" ng-click="resetBasicForm(${empId})">
											<i class="fa fa-times fa-lg"></i> Reset
										</button>
										<button type="submit" class="btn btn-success" id="editEmpSaveBtn">
											<i class="fa fa-check fa-lg"></i> Save
										</button>
									</div>
								</form>