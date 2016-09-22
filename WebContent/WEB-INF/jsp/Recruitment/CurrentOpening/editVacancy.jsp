<div class="modal fade" tabindex="-1" role="dialog" id="editVacancyModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Vacancy</h4>
      </div>
      <div class="modal-body">
		<form name="editVacancyForm" class="form-horizontal"
			ng-submit="editVacancyForm.$valid && checkMinDaysResult === false &&
				checkDuplicateVacancyResult === false &&
				updateVacancy(updateVacancyId, updateVacancyTitle, updateVacancyJob, updateVacancyRolesAndResp, 
				updateVacancyWorkExp, updateVacancyQualification, updateVacancyExpiry, updateVacancyStatus)">
				
			<!-- Vacancy Id -->
			<input type="hidden" ng-model="updateVacancyId">
						
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.title.$error.required 
						&& editVacancyForm.title.$dirty">
					<strong>Error!</strong> Vacancy Title is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateVacancyResult === true">
					<strong>Error!</strong> Vacancy Exists with this title and added date
				</div>
				<label class="col-sm-2 control-label">Vacancy Title</label>
				<div class="col-sm-10">
					<input type="text" name="title" ng-model="updateVacancyTitle" 
					class="form-control" required placeholder="Vacancy Title"
					ng-change="checkDuplicateVacancy(updateVacancyTitle)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.jobDesc.$error.required 
						&& editVacancyForm.jobDesc.$dirty">
					<strong>Error!</strong> Job Description is required.
				</div>
				<div ng-messages="editVacancyForm.jobDesc.$error" role="alert" 
					ng-if="editVacancyForm.jobDesc.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Job Description should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Job Description</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="jobDesc" 
						placeholder="Job Description" ng-model="updateVacancyJob" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.rolesAndResp.$error.required 
						&& editVacancyForm.rolesAndResp.$dirty">
					<strong>Error!</strong> Roles & Responsibilities is required.
				</div>
				<div ng-messages="editVacancyForm.rolesAndResp.$error" role="alert" 
					ng-if="editVacancyForm.rolesAndResp.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Roles & Responsibilities should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Roles</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="rolesAndResp" 
						placeholder="Roles & Responsibilities" ng-model="updateVacancyRolesAndResp" 
						ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.workExp.$error.required 
						&& editVacancyForm.workExp.$dirty">
					<strong>Error!</strong> Work Experience is required.
				</div>
				<div ng-messages="editVacancyForm.workExp.$error" role="alert" 
					ng-if="editVacancyForm.workExp.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Work Experience should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Work Experience</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="workExp" 
						placeholder="Work Experience" ng-model="updateVacancyWorkExp" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.qualification.$error.required 
						&& editVacancyForm.qualification.$dirty">
					<strong>Error!</strong> Qualification is required.
				</div>
				<div ng-messages="editVacancyForm.qualification.$error" role="alert" 
					ng-if="editVacancyForm.qualification.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Qualification should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Qualification</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="qualification" 
						placeholder="Qualification" ng-model="updateVacancyQualification" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.expiryDate.$error.required 
						&& editVacancyForm.expiryDate.$dirty">
					<strong>Error!</strong> Expiry Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkMinDaysResult === true">
					<strong>Error!</strong> Expiry Date should be at least one week from today's date
				</div>
				<label class="col-sm-2 control-label">Expiry Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateVacancyExpiry" class="form-control" 
							placeholder="Choose a date" name="expiryDate" required
							ng-change="checkMinDays(updateVacancyExpiry)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editVacancyForm.status.$error.required 
						&& editVacancyForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="updateVacancyStatus" name="status" class="form-control"
						required>
						<option value="">Select a Status</option>
						<option value="Pending">Pending</option>
						<option value="Completed">Completed</option>
						<option value="Terminated">Terminated</option>
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