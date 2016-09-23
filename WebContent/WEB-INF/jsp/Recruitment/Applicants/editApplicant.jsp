<div class="modal fade" tabindex="-1" role="dialog" id="editApplicantModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Applicant</h4>
      </div>
      <div class="modal-body">
		<form name="editApplicantForm" class="form-horizontal"
			ng-submit="editApplicantForm.$valid && checkAppliedDateResult === false &&
				updateApplicant(updateAppId, updateAppFirstName, updateAppLastName, updateAppVacancy, 
				updateAppEmail, updateAppContactNo, updateAppWorkExp, updateAppQualification, updateAppApplied,
				updateAppReferredBy, updateAppStatus, updateAppExamResult, updateAppInterviewResult)">
				
			<!-- Applicant Id -->
			<input type="hidden" ng-model="updateAppId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.firstName.$error.required 
						&& editApplicantForm.firstName.$dirty">
					<strong>Error!</strong> First Name is required.
				</div>
				<label class="col-sm-2 control-label">First Name</label>
				<div class="col-sm-10">
					<input type="text" name="firstName" ng-model="updateAppFirstName" 
					class="form-control" required placeholder="First Name">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.lastName.$error.required 
						&& editApplicantForm.lastName.$dirty">
					<strong>Error!</strong> Last Name is required.
				</div>
				<label class="col-sm-2 control-label">Last Name</label>
				<div class="col-sm-10">
					<input type="text" name="lastName" ng-model="updateAppLastName" 
					class="form-control" required placeholder="Last Name">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.vacancy.$error.required 
						&& editApplicantForm.vacancy.$dirty">
					<strong>Error!</strong> Vacancy is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Vacancy</label>
				<div class="col-sm-10">
					<select ng-model="updateAppVacancy" name="vacancy" class="form-control"
						required convert-to-number>
						<option value="">Select a Vacancy</option>
						<option value="{{vacancy.vacancy_id}}" 
						ng-repeat="vacancy in getVacanciesByYearResult">
						{{vacancy.vacancy_title}} - {{vacancy.added_date | date : 'yyyy-MM-dd'}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="editApplicantForm.email.$error" role="alert" 
					ng-if="editApplicantForm.email.$dirty">
					<div ng-message="required" class="alert alert-danger padded">
						<strong>Error!</strong> Email is required
					</div>
					<div ng-message="pattern" class="alert alert-danger padded">
						<strong>Error!</strong> Invalid Email
					</div>
				</div>
				<label class="col-sm-2 control-label">Email</label>
				<div class="col-sm-10">
					<input type="text" name="email" ng-model="updateAppEmail" 
					class="form-control" required placeholder="Email"
					ng-pattern="/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/">
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="editApplicantForm.contactNo.$error" role="alert" 
					ng-if="editApplicantForm.contactNo.$dirty">
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
					<input type="text" name="contactNo" ng-model="updateAppContactNo" 
					class="form-control" required placeholder="Contact No" ng-minlength="10"
					ng-maxlength="10" ng-pattern="/^\d+$/">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.workExp.$error.required 
						&& editApplicantForm.workExp.$dirty">
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
						placeholder="Work Experience" ng-model="updateAppWorkExp" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.qualification.$error.required 
						&& editApplicantForm.qualification.$dirty">
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
						placeholder="Qualification" ng-model="updateAppQualification" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.appliedDate.$error.required 
						&& editApplicantForm.appliedDate.$dirty">
					<strong>Error!</strong> Applied Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkAppliedDateResult === true">
					<strong>Error!</strong> Applied date should be equal to or greater than the Vacancy Added Date
				</div>
				<label class="col-sm-2 control-label">Applied Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="updateAppApplied" class="form-control" 
							placeholder="Choose a date" name="appliedDate" required
							ng-change="checkAppliedDate(updateAppApplied, updateAppVacancy)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.referredBy.$error.required 
						&& editApplicantForm.referredBy.$dirty">
					<strong>Error!</strong> Referred By is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Referred By</label>
				<div class="col-sm-10">
					<select ng-model="updateAppReferredBy" name="referredBy" class="form-control"
						required>
						<option value="">Select Referred By</option>
						<option value="Job Site">Job Site</option>
						<option value="Social Media">Social Media</option>
						<option value="Personal Reference">Personal Reference</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editApplicantForm.status.$error.required 
						&& editApplicantForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="updateAppStatus" name="status" class="form-control"
						required>
						<option value="">Select a Status</option>
						<option value="Pending">Pending</option>
						<option value="Short-Listed">Short-Listed</option>
						<option value="Selected">Selected</option>
						<option value="Rejected">Rejected</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Exam Result</label>
				<div class="col-sm-10">
					<select ng-model="updateAppExamResult" name="examResult" class="form-control">
						<option value="">Select Exam Result</option>
						<option value="Pass">Pass</option>
						<option value="Fail">Fail</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Interview Result</label>
				<div class="col-sm-10">
					<select ng-model="updateAppInterviewResult" name="interviewResult" class="form-control">
						<option value="">Select Interview Result</option>
						<option value="Pass">Pass</option>
						<option value="Fail">Fail</option>
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