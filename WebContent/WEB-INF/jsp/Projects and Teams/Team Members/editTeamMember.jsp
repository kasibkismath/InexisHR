<div class="modal fade" tabindex="-1" role="dialog" id="editTeamMemberModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Team</h4>
      </div>
      <div class="modal-body">
		<form name="editTeamMemberForm" class="form-horizontal"
			ng-submit="editTeamMemberForm.$valid && checkDuplicateTeamMemberResult === false &&
				updateTeamMember(updateTeamMemberId, updateTeamMemberEmp, updateTeamMemberTeam)">
			
			<!-- Team Member Id -->
			<input type="hidden" ng-model="updateTeamMemberId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editTeamMemberForm.employee.$error.required 
						&& editTeamMemberForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateTeamMemberResult === true">
					<strong>Error!</strong> Team Member already exists
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="updateTeamMemberEmp" name="employee" class="form-control"
						required
						ng-change="checkTeamMemberDuplicate(updateTeamMemberEmp, updateTeamMemberTeam)"
						convert-to-number>
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
					ng-show="editTeamMemberForm.project.$error.required 
						&& editTeamMemberForm.project.$dirty">
					<strong>Error!</strong> Project is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Project</label>
				<div class="col-sm-10">
					<select ng-model="updateTeamMemberProject" name="project" class="form-control"
						required
						ng-change="getActiveTeamsByProject(updateTeamMemberProject); 
						checkTeamMemberDuplicate(updateTeamMemberEmp, updateTeamMemberTeam)"
						convert-to-number>
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
					ng-show="editTeamMemberForm.team.$error.required 
						&& editTeamMemberForm.team.$dirty">
					<strong>Error!</strong> Team is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Team</label>
				<div class="col-sm-10">
					<select ng-model="updateTeamMemberTeam" name="team" class="form-control"
						required
						ng-change="checkTeamMemberDuplicate(updateTeamMemberEmp, updateTeamMemberTeam)"
						convert-to-number>
						<option value="">Select a Team</option>
						<option value="{{team.team_Id}}" 
							ng-repeat="team in getActiveTeamsByProjectResult">
							{{team.team_name}}
						</option>
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