<div class="modal fade" tabindex="-1" role="dialog" id="editProjectModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Project</h4>
      </div>
      <div class="modal-body">
		<form name="editProjectForm" class="form-horizontal"
			ng-submit="editProjectForm.$valid && checkDuplicateProjectResult === false &&
				updateProject(updateProjectId, updateProjectName, updateProjectStatus, 
				updateProjectStartDate, 
				updateProjectClient)">
				
			<input type="hidden" ng-model="updateProjectId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editProjectForm.projectName.$error.required 
						&& editProjectForm.projectName.$dirty">
					<strong>Error!</strong> Project Name is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateProjectResult === true">
					<strong>Error!</strong> Project with this Project Name already exists.
				</div>
				<label class="col-sm-2 control-label">Project Name</label>
				<div class="col-sm-10">
					<input type="text" name="projectName" ng-model="updateProjectName" 
					class="form-control" required placeholder="Project Name"
					ng-change="checkDuplicateProject(updateProjectName)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editProjectForm.status.$error.required 
						&& editProjectForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="updateProjectStatus" name="status" class="form-control"
						required>
						<option value="">Select a Status</option>
						<option value="In-Progress">In-Progress</option>
						<option value="Completed">Completed</option>
						<option value="On-Hold">On-Hold</option>
						<option value="Terminated">Terminated</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editProjectForm.startDate.$error.required 
						&& editProjectForm.startDate.$dirty">
					<strong>Error!</strong> Start Date.
				</div>
				<label class="col-sm-2 control-label">Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateProjectStartDate" class="form-control" 
							placeholder="Choose a date" name="startDate" required>
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editProjectForm.projectClient.$error.required 
						&& editProjectForm.projectClient.$dirty">
					<strong>Error!</strong> Project Client is required.
				</div>
				<label class="col-sm-2 control-label">Project Client</label>
				<div class="col-sm-10">
					<input type="text" name="projectClient" ng-model="updateProjectClient" 
					class="form-control" required placeholder="Project Client">
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