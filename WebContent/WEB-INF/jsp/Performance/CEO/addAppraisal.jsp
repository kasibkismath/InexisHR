<div class="modal fade" tabindex="-1" role="dialog" id="CEOAddAppraisal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Add Appraisal</h4>
			</div>
			<div class="modal-body">
				<form name="ceoAddAppraisalForm" class="form-horizontal"
					ng-submit="ceoAddAppraisalForm.$valid && appraisalYearResult === true &&
					checkHRAppraisalExistsResult === true && checkCEOAppraisalExistsResult === false &&
					addCEOAppraisal(saveNewCEOEmployee, saveNewCEOYear, saveNewCEOStatus, 
					saveNewCEOSkillScore, saveNewCEOMentorshipScore, saveNewCEOTaskCompScore, 
					saveNewCEOCurrPerformanceScore, saveNewCEODesc)">
					
					<div role="alert" class="alert alert-danger padded" 
						ng-show="checkHRAppraisalExistsResult === false">
							<strong>Error!</strong> 
							HR Appraisal is not completed for the selected year. Please complete it.
					</div>
					
					<div role="alert" class="alert alert-danger padded" 
						ng-show="checkCEOAppraisalExistsResult === true">
							<strong>Error!</strong> 
							CEO Appraisal Exists for this employee and year.
					</div>
					
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.employee.$error.required" 
							ng-if="ceoAddAppraisalForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Employee</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOEmployee" name="employee" class="form-control" 
								required
								ng-change="checkHRAppraisalExists(saveNewCEOEmployee, saveNewCEOYear);
									checkCEOAppraisalExists(saveNewCEOEmployee, saveNewCEOYear)">
								<option value="">Select an employee</option>
								<option ng-repeat="employee in employees" value="{{employee.empId}}"
								ng-if="employee.empId != loggedInEmpId && employee.status === true">{{employee.firstName}} {{employee.lastName}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.year.$error.required" 
							ng-if="ceoAddAppraisalForm.year.$dirty">
							<strong>Error!</strong> Year is required, please select one.
						</div>
						<div role="alert" class="alert alert-danger padded" 
							ng-show="appraisalYearResult === false">
							<strong>Error!</strong> Appraisal Year cannot be less than Employee Hired Date.
						</div>
						 <label class="col-sm-2 control-label">Year</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOYear" name="year" class="form-control" 
								required
								ng-change="checkAppraisalYear(saveNewCEOEmployee, saveNewCEOYear); 
								checkHRAppraisalExists(saveNewCEOEmployee, saveNewCEOYear);
								checkCEOAppraisalExists(saveNewCEOEmployee, saveNewCEOYear)">
								<option value="">Select a year</option>
								<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.status.$error.required" 
							ng-if="ceoAddAppraisalForm.status.$dirty">
							<strong>Error!</strong> Status is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Status</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOStatus" name="status" class="form-control" 
								required>
								<option value="">Select status</option>
								<option value="In-Progess">In Progess</option>
								<option value="Completed">Completed</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.skillScore.$error.required" 
							ng-if="ceoAddAppraisalForm.skillScore.$dirty">
							<strong>Error!</strong> Skill Level Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Skill Level Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOSkillScore" name="skillScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.mentorshipScore.$error.required" 
							ng-if="ceoAddAppraisalForm.mentorshipScore.$dirty">
							<strong>Error!</strong> Mentorship Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Mentorship Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOMentorshipScore" name="mentorshipScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.taskCompScore.$error.required" 
							ng-if="ceoAddAppraisalForm.taskCompScore.$dirty">
							<strong>Error!</strong> Task Completion Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Task Completion Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOTaskCompScore" name="taskCompScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.currPerformanceScore.$error.required" 
							ng-if="ceoAddAppraisalForm.currPerformanceScore.$dirty">
							<strong>Error!</strong> Current Performance Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Current Performance Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.description.$error.maxlength" 
							ng-if="ceoAddAppraisalForm.description.$dirty">
							<strong>Error!</strong> Description should be less than or equal 10,000 characters long.
						</div>
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.description.$error.required" 
							ng-if="ceoAddAppraisalForm.description.$dirty">
							<strong>Error!</strong> Description is required.
						</div>
						<label class="col-sm-2 control-label">Description</label>
						<div class="col-sm-10">
							<textarea rows="15" class="form-control" name="description" 
								placeholder="Enter description" ng-model="saveNewCEODesc" ng-maxlength="10000" 
								required char-count warning-count="25" danger-count="10"></textarea>
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