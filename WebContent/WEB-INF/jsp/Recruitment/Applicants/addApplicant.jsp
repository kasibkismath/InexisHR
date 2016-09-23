<div class="modal fade" tabindex="-1" role="dialog" id="addApplicantModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Applicant</h4>
      </div>
      <div class="modal-body">
		<form name="addApplicantForm" class="form-horizontal"
			ng-submit="addApplicantForm.$valid && checkAppliedDateResult === false &&
				addApplicant(saveAppFirstName, saveAppLastName, saveAppVacancy, saveAppEmail, saveAppContactNo, 
				saveAppWorkExp, saveAppQualification, saveAppApplied, saveAppReferredBy)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.firstName.$error.required 
						&& addApplicantForm.firstName.$dirty">
					<strong>Error!</strong> First Name is required.
				</div>
				<label class="col-sm-2 control-label">First Name</label>
				<div class="col-sm-10">
					<input type="text" name="firstName" ng-model="saveAppFirstName" 
					class="form-control" required placeholder="First Name">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.lastName.$error.required 
						&& addApplicantForm.lastName.$dirty">
					<strong>Error!</strong> Last Name is required.
				</div>
				<label class="col-sm-2 control-label">Last Name</label>
				<div class="col-sm-10">
					<input type="text" name="lastName" ng-model="saveAppLastName" 
					class="form-control" required placeholder="Last Name">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.vacancy.$error.required 
						&& addApplicantForm.vacancy.$dirty">
					<strong>Error!</strong> Vacancy is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Vacancy</label>
				<div class="col-sm-10">
					<select ng-model="saveAppVacancy" name="vacancy" class="form-control"
						required>
						<option value="">Select a Vacancy</option>
						<option value="{{vacancy.vacancy_id}}" 
						ng-repeat="vacancy in getAllPendingNonExpiredVacanciesResult">
						{{vacancy.vacancy_title}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="addApplicantForm.email.$error" role="alert" 
					ng-if="addApplicantForm.email.$dirty">
					<div ng-message="required" class="alert alert-danger padded">
						<strong>Error!</strong> Email is required
					</div>
					<div ng-message="pattern" class="alert alert-danger padded">
						<strong>Error!</strong> Invalid Email
					</div>
				</div>
				<label class="col-sm-2 control-label">Email</label>
				<div class="col-sm-10">
					<input type="text" name="email" ng-model="saveAppEmail" 
					class="form-control" required placeholder="Email"
					ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/">
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="addApplicantForm.contactNo.$error" role="alert" 
					ng-if="addApplicantForm.contactNo.$dirty">
					<div ng-message="required" class="alert alert-danger padded">
						<strong>Error!</strong> Contact No is required
					</div>
					<div ng-message="minlength, maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Contact No must be only 10 characters long 
					</div>
					<div ng-message="pattern" class="alert alert-danger padded">
						<strong>Error!</strong> Contact No should be numeric
					</div>
				</div>
				<label class="col-sm-2 control-label">Contact No</label>
				<div class="col-sm-10">
					<input type="text" name="contactNo" ng-model="saveAppContactNo" 
					class="form-control" required placeholder="Contact No" ng-minlength="10"
					ng-maxlength="10" ng-pattern="/^\d+$/">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.workExp.$error.required 
						&& addApplicantForm.workExp.$dirty">
					<strong>Error!</strong> Work Experience is required.
				</div>
				<div ng-messages="addApplicantForm.workExp.$error" role="alert" 
					ng-if="addApplicantForm.workExp.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Work Experience should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Work Experience</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="workExp" 
						placeholder="Work Experience" ng-model="saveAppWorkExp" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.qualification.$error.required 
						&& addApplicantForm.qualification.$dirty">
					<strong>Error!</strong> Qualification is required.
				</div>
				<div ng-messages="addApplicantForm.qualification.$error" role="alert" 
					ng-if="addApplicantForm.qualification.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Qualification should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Qualification</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="qualification" 
						placeholder="Qualification" ng-model="saveAppQualification" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.appliedDate.$error.required 
						&& addVacancyForm.appliedDate.$dirty">
					<strong>Error!</strong> Applied Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkAppliedDateResult === true">
					<strong>Error!</strong> Applied date should be equal to or greater than the Vacancy Added Date
				</div>
				<label class="col-sm-2 control-label">Applied Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="saveAppApplied" class="form-control" 
							placeholder="Choose a date" name="appliedDate" required
							ng-change="checkAppliedDate(saveAppApplied, saveAppVacancy)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addApplicantForm.referredBy.$error.required 
						&& addApplicantForm.referredBy.$dirty">
					<strong>Error!</strong> Referred By is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Referred By</label>
				<div class="col-sm-10">
					<select ng-model="saveAppReferredBy" name="referredBy" class="form-control"
						required>
						<option value="">Select Referred By</option>
						<option value="Job Site">Job Site</option>
						<option value="Social Media">Social Media</option>
						<option value="Personal Reference">Personal Reference</option>
					</select>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>