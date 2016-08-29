<div class="modal fade" tabindex="-1" role="dialog" id="editHRAppraisalModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit Appraisal</h4>
      </div>
      <div class="modal-body">
		  <div style="padding-bottom: 20px;">
	          <h5>
	          	<i class="fa fa-bullhorn"></i> 
	          	<b>NOTE :</b>  If CEO Appraisal for this employee and year is completed, 
	          	<b>HR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	          	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	          	&nbsp; &nbsp;
	          	Appraisal cannot be edited</b>.
	          </h5>
         </div>
          <form name="hrEditAppraisalForm" class="form-horizontal"
          	ng-submit="hrEditAppraisalForm.$valid && 
          		saveEditHRAppraisalMain(saveEditHRAppraisalId, saveEditHRStatus, 
          		saveEditHRTaskCompScore, saveEditHRCurrPerformanceScore)">
          	
          	<input type="hidden" ng-model="saveEditHRAppraisalId">
			
			<div class="form-group">
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveEditHREmployee" name="employee" class="form-control" 
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
					<select ng-model="saveEditHRYear" name="year" class="form-control"
						required disabled="true">
						<option value="">Select a year</option>
						<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="hrEditAppraisalForm.status.$error.required" 
					ng-if="hrEditAppraisalForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="saveEditHRStatus" name="status" class="form-control"
							ng-disabled="HREditResult" 
							required>
						<option value="">Select status</option>
						<option value="In-Progess">In Progess</option>
						<option value="Completed">Completed</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
						ng-show="hrEditAppraisalForm.taskCompScore.$error.required" 
						ng-if="hrEditAppraisalForm.taskCompScore.$dirty">
					<strong>Error!</strong> Task Completion Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Task Completion Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditHRTaskCompScore" name="taskCompScore" class="form-control" 
							convert-to-number ng-disabled="HREditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="hrEditAppraisalForm.currPerformanceScore.$error.required" 
					ng-if="hrEditAppraisalForm.currPerformanceScore.$dirty">
					<strong>Error!</strong> Current Performance Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Current Performance Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditHRCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
							convert-to-number ng-disabled="HREditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">
					<i class="fa fa-times"></i> Close
				</button>
				<button type="submit" class="btn btn-success" ng-disabled="HREditResult">
					<i class="fa fa-check"></i> Save
				</button>
			</div>
          </form>
      </div>
    </div>
  </div>
</div>