<div class="modal fade" tabindex="-1" role="dialog" id="addVacancyModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Vacancy</h4>
      </div>
      <div class="modal-body">
		<form name="addVacancyForm" class="form-horizontal"
			ng-submit="addVacancyForm.$valid && checkMinDaysResult === false &&
				checkDuplicateVacancyResult === false &&
				addVacancy(saveVacancyTitle, saveVacancyJob, saveVacancyRolesAndResp, saveVacancyWorkExp,
				saveVacancyQualification, saveVacancyExpiry)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.title.$error.required 
						&& addVacancyForm.title.$dirty">
					<strong>Error!</strong> Vacancy Title is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateVacancyResult === true">
					<strong>Error!</strong> Vacancy Exists with this title and added date
				</div>
				<label class="col-sm-2 control-label">Vacancy Title</label>
				<div class="col-sm-10">
					<input type="text" name="title" ng-model="saveVacancyTitle" 
					class="form-control" required placeholder="Vacancy Title"
					ng-change="checkDuplicateVacancy(saveVacancyTitle)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.jobDesc.$error.required 
						&& addVacancyForm.jobDesc.$dirty">
					<strong>Error!</strong> Job Description is required.
				</div>
				<div ng-messages="addVacancyForm.jobDesc.$error" role="alert" 
					ng-if="addVacancyForm.jobDesc.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Job Description should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Job Description</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="jobDesc" 
						placeholder="Job Description" ng-model="saveVacancyJob" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.rolesAndResp.$error.required 
						&& addVacancyForm.rolesAndResp.$dirty">
					<strong>Error!</strong> Roles & Responsibilities is required.
				</div>
				<div ng-messages="addVacancyForm.rolesAndResp.$error" role="alert" 
					ng-if="addVacancyForm.rolesAndResp.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Roles & Responsibilities should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Roles</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="rolesAndResp" 
						placeholder="Roles & Responsibilities" ng-model="saveVacancyRolesAndResp" 
						ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.workExp.$error.required 
						&& addVacancyForm.workExp.$dirty">
					<strong>Error!</strong> Work Experience is required.
				</div>
				<div ng-messages="addVacancyForm.workExp.$error" role="alert" 
					ng-if="addVacancyForm.workExp.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Work Experience should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Work Experience</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="workExp" 
						placeholder="Work Experience" ng-model="saveVacancyWorkExp" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.qualification.$error.required 
						&& addVacancyForm.qualification.$dirty">
					<strong>Error!</strong> Qualification is required.
				</div>
				<div ng-messages="addVacancyForm.qualification.$error" role="alert" 
					ng-if="addVacancyForm.qualification.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Qualification should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Qualification</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="qualification" 
						placeholder="Qualification" ng-model="saveVacancyQualification" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addVacancyForm.expiryDate.$error.required 
						&& addVacancyForm.expiryDate.$dirty">
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
							<input ng-model="saveVacancyExpiry" class="form-control" 
							placeholder="Choose a date" name="expiryDate" required
							ng-change="checkMinDays(saveVacancyExpiry)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
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