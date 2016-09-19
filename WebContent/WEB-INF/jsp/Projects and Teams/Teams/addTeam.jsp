<div class="modal fade" tabindex="-1" role="dialog" id="addNewTeamModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Team</h4>
      </div>
      <div class="modal-body">
		<form name="addTeamForm" class="form-horizontal"
			ng-submit="addTeamForm.$valid && checkDuplicateTeamResult === false &&
				addProject(saveProjectName, saveProjectStatus, saveProjectStartDate, saveProjectClient)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamForm.teamName.$error.required 
						&& addTeamForm.teamName.$dirty">
					<strong>Error!</strong> Team Name is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateTeamResult === true">
					<strong>Error!</strong> Team with this Team Name already exists.
				</div>
				<label class="col-sm-2 control-label">Team Name</label>
				<div class="col-sm-10">
					<input type="text" name="teamName" ng-model="saveTeamName" 
					class="form-control" required placeholder="Team Name"
					ng-change="checkDuplicateTeam(saveTeamName)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamForm.project.$error.required 
						&& addTeamForm.project.$dirty">
					<strong>Error!</strong> Project is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Project</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamProject" name="project" class="form-control"
						required>
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
					ng-show="addTeamForm.teamLead.$error.required 
						&& addTeamForm.teamLead.$dirty">
					<strong>Error!</strong> Team Lead is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Team Lead</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamLead" name="teamLead" class="form-control"
						required>
						<option value="">Select a Team Lead</option>
						<option value="{{employee.empId}}" 
							ng-repeat="employee in allLeadEmployees" ng-show="employee.status == true">
							{{employee.firstName}} {{employee.lastName}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTeamForm.status.$error.required 
						&& addTeamForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="saveTeamStatus" name="status" class="form-control"
						required>
						<option value="">Select a Status</option>
						<option value="Active">Active</option>
						<option value="In-Active">In-Active</option>
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