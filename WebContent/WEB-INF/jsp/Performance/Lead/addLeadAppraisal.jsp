<div class="modal fade" tabindex="-1" role="dialog" id="LeadAddAppraisal">
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
				<form name="leadAddAppraisalForm" class="form-horizontal"
					ng-submit="leadAddAppraisalForm.$valid && appraisalYearResult === true &&
					addLeadAppraisal(saveNewLeadEmployee, saveNewLeadYear, saveNewLeadStatus, saveNewTeam, 
					saveNewLeadSkillScore, saveNewLeadMentorshipScore, saveNewLeadTaskCompScore, 
					saveNewLeadCurrPerformanceScore)">
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.employee.$error.required" 
							ng-if="leadAddAppraisalForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Employee</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadEmployee" name="employee" class="form-control" 
								required>
								<option value="">Select an employee</option>
								<option ng-repeat="teamMember in teamMembersByLead" value="{{teamMember.empId}}"
								ng-if="teamMember.empId != loggedInEmpId && teamMember.status === true">
								{{teamMember.firstName}} {{teamMember.lastName}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.year.$error.required" 
							ng-if="leadAddAppraisalForm.year.$dirty">
							<strong>Error!</strong> Year is required, please select one.
						</div>
						<div role="alert" class="alert alert-danger padded" 
							ng-show="appraisalYearResult === false">
						<strong>Error!</strong> Appraisal Year cannot be less than Employee Hired Date.
						</div>
						 <label class="col-sm-2 control-label">Year</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadYear" name="year" class="form-control" 
								required 
								ng-change="checkAppraisalYear(saveNewLeadEmployee,saveNewLeadYear)">
								<option value="">Select a year</option>
								<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.status.$error.required" 
							ng-if="leadAddAppraisalForm.status.$dirty">
							<strong>Error!</strong> Status is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Status</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadStatus" name="status" class="form-control" 
								required>
								<option value="">Select status</option>
								<option value="In-Progess">In Progess</option>
								<option value="Completed">Completed</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.team.$error.required" 
							ng-if="leadAddAppraisalForm.team.$dirty">
							<strong>Error!</strong> Team is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Team</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewTeam" name="team" class="form-control" 
								required>
								<option value="">Select a team</option>
								<option ng-repeat="team in teamsByLeadId" value="{{team.team_Id}}">
								{{team.team_name}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.skillScore.$error.required" 
							ng-if="leadAddAppraisalForm.skillScore.$dirty">
							<strong>Error!</strong> Skill Level Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Skill Level Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadSkillScore" name="skillScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.mentorshipScore.$error.required" 
							ng-if="leadAddAppraisalForm.mentorshipScore.$dirty">
							<strong>Error!</strong> Mentorship Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Mentorship Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadMentorshipScore" name="mentorshipScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.taskCompScore.$error.required" 
							ng-if="leadAddAppraisalForm.taskCompScore.$dirty">
							<strong>Error!</strong> Task Completion Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Task Completion Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadTaskCompScore" name="taskCompScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option ng-repeat="scoreValue in scoreValues" value="{{scoreValue}}">{{scoreValue}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="leadAddAppraisalForm.currPerformanceScore.$error.required" 
							ng-if="leadAddAppraisalForm.currPerformanceScore.$dirty">
							<strong>Error!</strong> Current Performance Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Current Performance Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewLeadCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
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