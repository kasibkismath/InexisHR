<div class="modal fade" tabindex="-1" role="dialog" id="editLeadAppraisalModal">
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
	          	<b>NOTE :</b>  If HR Appraisal for this employee, year 
	          	and team is completed, <b>Team Lead &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	          	&nbsp; &nbsp;
	          	Appraisal cannot be edited</b>.
	          </h5>
         </div>
          <form name="leadEditAppraisalForm" class="form-horizontal"
          	ng-submit="leadEditAppraisalForm.$valid && 
          		saveEditLeadAppraisalMain(saveEditLeadAppraisalId, saveEditLeadStatus, 
          		saveEditLeadSkillScore, saveEditLeadMentorshipScore, saveEditLeadTaskCompScore, 
          		saveEditLeadCurrPerformanceScore)">
          	
          	<input type="hidden" ng-model="saveEditLeadAppraisalId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.employee.$error.required" 
					ng-if="leadEditAppraisalForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadEmployee" name="employee" class="form-control" 
						convert-to-number required disabled="true">
						<option value="">Select an employee</option>
						<option ng-repeat="teamMember in teamMembersByLead" value="{{teamMember.empId}}"
							ng-if="teamMember.empId != loggedInEmpId && teamMember.status === true">
							{{teamMember.firstName}} {{teamMember.lastName}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.year.$error.required" 
					ng-if="leadEditAppraisalForm.year.$dirty">
					<strong>Error!</strong> Year is required, please select one.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="appraisalYearResult === false">
					<strong>Error!</strong> Appraisal Year cannot be less than Employee Hired Date.
				</div>
				<label class="col-sm-2 control-label">Year</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadYear" name="year" class="form-control"
						required disabled="true">
						<option value="">Select a year</option>
						<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.status.$error.required" 
					ng-if="leadEditAppraisalForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadStatus" name="status" class="form-control"
							ng-disabled="TeamLeadEditResult" 
							required>
						<option value="">Select status</option>
						<option value="In-Progess">In Progess</option>
						<option value="Completed">Completed</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.team.$error.required" 
					ng-if="leadEditAppraisalForm.team.$dirty">
					<strong>Error!</strong> Team is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Team</label>
				<div class="col-sm-10">
					<select ng-model="saveEditTeam" name="team" class="form-control" convert-to-number
						required disabled="true">
						<option value="">Select a team</option>
						<option ng-repeat="team in teamsByLeadId"
							ng-show="team.status == 'Active'"
							value="{{team.team_Id}}">
							{{team.team_name}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.skillScore.$error.required" 
					ng-if="leadEditAppraisalForm.skillScore.$dirty">
					<strong>Error!</strong> Skill Level Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Skill Level Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadSkillScore" name="skillScore" class="form-control" 
							convert-to-number ng-disabled="TeamLeadEditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.mentorshipScore.$error.required" 
					ng-if="leadEditAppraisalForm.mentorshipScore.$dirty">
					<strong>Error!</strong> Mentorship Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Mentorship Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadMentorshipScore" name="mentorshipScore" class="form-control" 
							convert-to-number ng-disabled="TeamLeadEditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
						ng-show="leadEditAppraisalForm.taskCompScore.$error.required" 
						ng-if="leadEditAppraisalForm.taskCompScore.$dirty">
					<strong>Error!</strong> Task Completion Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Task Completion Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadTaskCompScore" name="taskCompScore" class="form-control" 
							convert-to-number ng-disabled="TeamLeadEditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leadEditAppraisalForm.currPerformanceScore.$error.required" 
					ng-if="leadEditAppraisalForm.currPerformanceScore.$dirty">
					<strong>Error!</strong> Current Performance Score is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Current Performance Score</label>
				<div class="col-sm-10">
					<select ng-model="saveEditLeadCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
							convert-to-number ng-disabled="TeamLeadEditResult" required>
						<option value="">Select score</option>
						<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">
					<i class="fa fa-times"></i> Close
				</button>
				<button type="submit" class="btn btn-success" ng-disabled="TeamLeadEditResult">
					<i class="fa fa-check"></i> Save
				</button>
			</div>
          </form>
      </div>
    </div>
  </div>
</div>