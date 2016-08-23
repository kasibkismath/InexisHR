<div class="modal fade" tabindex="-1" role="dialog" id="HRAddAppraisal">
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
				<form name="hrAddAppraisalForm" class="form-horizontal"
					ng-submit="hrAddAppraisalForm.$valid && 
					appraisalYearResult === true && teamLeadAppraisalCompleted === true &&
					checkDuplicateHRAppraisalResult === false &&
					addHRAppraisal(saveNewHREmployee, saveNewHRYear, saveNewHRStatus, 
					saveNewHRTaskCompScore, saveNewHRCurrPerformanceScore)">
					
					<div role="alert" class="alert alert-danger padded" 
							ng-show="teamLeadAppraisalCompleted === false">
							<strong>Error!</strong> Team Lead Appraisal/s is/are not completed for the year. Please complete it.
					</div>
					
					<div role="alert" class="alert alert-danger padded" 
							ng-show="checkDuplicateHRAppraisalResult === true">
							<strong>Error!</strong> HR Appraisal already exists for this employee and year.
					</div>
					
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="hrAddAppraisalForm.employee.$error.required" 
							ng-if="hrAddAppraisalForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Employee</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewHREmployee" name="employee" class="form-control" 
								required
								ng-change="checkLeadAppraisalComplete(saveNewHREmployee, saveNewHRYear);
									checkDuplicateHRAppraisal(saveNewHREmployee, saveNewHRYear)">
								<option value="">Select an employee</option>
								<option ng-repeat="employee in employees" value="{{employee.empId}}"
								ng-if="employee.empId != loggedInEmpId && employee.designation.name != 'Ceo'">
								{{employee.firstName}} {{employee.lastName}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="hrAddAppraisalForm.year.$error.required" 
							ng-if="hrAddAppraisalForm.year.$dirty">
							<strong>Error!</strong> Year is required, please select one.
						</div>
						<div role="alert" class="alert alert-danger padded" 
							ng-show="appraisalYearResult === false">
							<strong>Error!</strong> Appraisal Year cannot be less than Employee Hired Date.
						</div>
						 <label class="col-sm-2 control-label">Year</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewHRYear" name="year" class="form-control"
								ng-change="checkAppraisalYear(saveNewHREmployee, saveNewHRYear); 
									checkLeadAppraisalComplete(saveNewHREmployee, saveNewHRYear);
									checkDuplicateHRAppraisal(saveNewHREmployee, saveNewHRYear)"
								required>
								<option value="">Select a year</option>
								<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="hrAddAppraisalForm.status.$error.required" 
							ng-if="hrAddAppraisalForm.status.$dirty">
							<strong>Error!</strong> Status is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Status</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewHRStatus" name="status" class="form-control" 
								required>
								<option value="">Select status</option>
								<option value="In-Progess">In Progess</option>
								<option value="Completed">Completed</option>
							</select>
						</div>
					</div>					
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="hrAddAppraisalForm.taskCompScore.$error.required" 
							ng-if="hrAddAppraisalForm.taskCompScore.$dirty">
							<strong>Error!</strong> Task Completion Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Task Completion Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewHRTaskCompScore" name="taskCompScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="hrAddAppraisalForm.currPerformanceScore.$error.required" 
							ng-if="hrAddAppraisalForm.currPerformanceScore.$dirty">
							<strong>Error!</strong> Current Performance Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Current Performance Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewHRCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
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