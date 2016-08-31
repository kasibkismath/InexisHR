<div class="modal fade" tabindex="-1" role="dialog" id="editCEOAppraisalModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit Appraisal</h4>
      </div>
      <div class="modal-body">
          <form name="ceoEditAppraisalForm" class="form-horizontal"
          	ng-submit="ceoEditAppraisalForm.$valid && 
          		saveEditCEOAppraisalMain(saveEditCEOAppraisalId, saveEditCEOEmployee, 
          		saveEditCEOPerformanceId, saveEditCEOYear, saveEditCEOStatus, 
          		saveEditCEOSkillScore, saveEditCEOMentorshipScore, saveEditCEOTaskCompScore, 
          		saveEditCEOCurrPerformanceScore, saveEditCEODesc)">
          	
          	<input type="hidden" ng-model="saveEditCEOAppraisalId">
          	<input type="hidden" ng-model="saveEditCEOPerformanceId">
			
			<div class="form-group">
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOEmployee" name="employee" class="form-control" 
						convert-to-number required disabled="true">
						<option value="">Select an employee</option>
						<option ng-repeat="employee in employees" value="{{employee.empId}}"
								ng-if="employee.empId != loggedInEmpId && employee.designation.name != 'Ceo' && employee.status === true">
								{{employee.firstName}} {{employee.lastName}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Year</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOYear" name="year" class="form-control"
						required disabled="true">
						<option value="">Select a year</option>
						<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.status.$error.required" 
					ng-if="ceoEditAppraisalForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOStatus" name="status" class="form-control"
							required>
						<option value="">Select status</option>
						<option value="In-Progess">In Progess</option>
						<option value="Completed">Completed</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.skillScore.$error.required" 
					ng-if="ceoEditAppraisalForm.skillScore.$dirty">
					<strong>Error!</strong> Skill Level Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Skill Level Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOSkillScore" name="skillScore" class="form-control" 
							convert-to-number required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.mentorshipScore.$error.required" 
					ng-if="ceoEditAppraisalForm.mentorshipScore.$dirty">
					<strong>Error!</strong> Mentorship Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Mentorship Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOMentorshipScore" name="mentorshipScore" class="form-control" 
							convert-to-number required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
						ng-show="ceoEditAppraisalForm.taskCompScore.$error.required" 
						ng-if="ceoEditAppraisalForm.taskCompScore.$dirty">
					<strong>Error!</strong> Task Completion Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Task Completion Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOTaskCompScore" name="taskCompScore" class="form-control" 
							convert-to-number required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.currPerformanceScore.$error.required" 
					ng-if="ceoEditAppraisalForm.currPerformanceScore.$dirty">
					<strong>Error!</strong> Current Performance Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Current Performance Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditCEOCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
							convert-to-number required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.description.$error.maxlength" 
					ng-if="ceoEditAppraisalForm.description.$dirty">
					<strong>Error!</strong> Description should be less than or equal 10,000 characters long.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="ceoEditAppraisalForm.description.$error.required" 
					ng-if="ceoEditAppraisalForm.description.$dirty">
					<strong>Error!</strong> Description is required.
				</div>
				<label class="col-sm-2 control-label">Description</label>
				<div class="col-sm-10">
					<textarea rows="15" class="form-control" name="description" 
						placeholder="Enter description" ng-model="saveEditCEODesc" ng-maxlength="10000" 
						required char-count warning-count="25" danger-count="10">
					</textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">
					<i class="fa fa-times"></i> Close
				</button>
				<button type="submit" class="btn btn-success">
					<i class="fa fa-check"></i> Save
				</button>
			</div>
          </form>
      </div>
    </div>
  </div>
</div>