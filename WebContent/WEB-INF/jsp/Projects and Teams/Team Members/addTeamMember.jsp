<div class="modal fade" tabindex="-1" role="dialog" id="addTeamMemberModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Team Member</h4>
      </div>
      <div class="modal-body">
		<form name="addTeamMemberForm" class="form-horizontal"
			ng-submit="addTeamMemberForm.$valid && checkDuplicateTeamMemberResult === false && 
				checkDuplicateEmpProjectHistoryResult === false &&
				checkFromToDateResult === false &&
				addTeamMember(saveTeamMemberEmp, saveTeamMemberTeam, saveTeamMemberFromDate, 
				saveTeamMemberToDate)">
				
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamMemberForm.employee.$error.required 
						&& addTeamMemberForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateTeamMemberResult === true">
					<strong>Error!</strong> Team Member already exists.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateEmpProjectHistoryResult === true">
					<strong>Error!</strong> An employee cannot belong to the same team with same date ranges twice.
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamMemberEmp" name="employee" class="form-control"
						required
						ng-change="checkTeamMemberDuplicate(saveTeamMemberEmp, saveTeamMemberTeam);
						checkDuplicateEmpProjectHistory(saveTeamMemberEmp, saveTeamMemberTeam, 
						saveTeamMemberFromDate, saveTeamMemberToDate)">
						<option value="">Select an Employee</option>
						<option value="{{employee.empId}}" 
							ng-repeat="employee in allLeadEmployees" ng-show="employee.status == true">
							{{employee.firstName}} {{employee.lastName}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamMemberForm.project.$error.required 
						&& addTeamMemberForm.project.$dirty">
					<strong>Error!</strong> Project is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Project</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamMemberProject" name="project" class="form-control"
						required
						ng-change="getActiveTeamsByProject(saveTeamMemberProject); 
						checkTeamMemberDuplicate(saveTeamMemberEmp, saveTeamMemberTeam); 
						checkDuplicateEmpProjectHistory(saveTeamMemberEmp, saveTeamMemberTeam, 
						saveTeamMemberFromDate, saveTeamMemberToDate)">
						<option value="">Select a Project</option>
						<option value="{{project.project_id}}" 
							ng-repeat="project in allInProgessAndOnHoldProjects">
							{{project.project_name}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamMemberForm.team.$error.required 
						&& addTeamMemberForm.team.$dirty">
					<strong>Error!</strong> Team is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Team</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamMemberTeam" name="team" class="form-control"
						required
						ng-change="checkTeamMemberDuplicate(saveTeamMemberEmp, saveTeamMemberTeam);
						checkDuplicateEmpProjectHistory(saveTeamMemberEmp, saveTeamMemberTeam, 
						saveTeamMemberFromDate, saveTeamMemberToDate)">
						<option value="">Select a Team</option>
						<option value="{{team.team_Id}}" 
							ng-repeat="team in getActiveTeamsByProjectResult">
							{{team.team_name}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamMemberForm.fromDate.$error.required 
						&& addTeamMemberForm.fromDate.$dirty">
					<strong>Error!</strong> From Date is required.
				</div>
				<label class="col-sm-2 control-label">From Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="saveTeamMemberFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(saveTeamMemberFromDate, 
							saveTeamMemberToDate); 
							checkDuplicateEmpProjectHistory(saveTeamMemberEmp, saveTeamMemberTeam, 
							saveTeamMemberFromDate, saveTeamMemberToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamMemberForm.toDate.$error.required 
						&& addTeamMemberForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-if="checkFromToDateResult === true">
					<strong>Error!</strong> 'From Date' should be less than or equal to 'To Date'.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="saveTeamMemberToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(saveTeamMemberFromDate, 
							saveTeamMemberToDate);
							checkDuplicateEmpProjectHistory(saveTeamMemberEmp, saveTeamMemberTeam, 
							saveTeamMemberFromDate, saveTeamMemberToDate)">
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