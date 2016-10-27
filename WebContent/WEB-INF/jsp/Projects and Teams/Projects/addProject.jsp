<div class="modal fade" tabindex="-1" role="dialog" id="addNewProjectModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Project</h4>
      </div>
      <div class="modal-body">
		<form name="addProjectForm" class="form-horizontal"
			ng-submit="addProjectForm.$valid && checkDuplicateProjectResult === false &&
				addProject(saveProjectName, saveProjectStatus, saveProjectStartDate, saveProjectClient)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addProjectForm.projectName.$error.required 
						&& addProjectForm.projectName.$dirty">
					<strong>Error!</strong> Project Name is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateProjectResult === true">
					<strong>Error!</strong> Project with this Project Name already exists.
				</div>
				<label class="col-sm-2 control-label">Project Name</label>
				<div class="col-sm-10">
					<input type="text" name="projectName" ng-model="saveProjectName" 
					class="form-control" required placeholder="Project Name"
					ng-change="checkDuplicateProject(saveProjectName)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addProjectForm.status.$error.required 
						&& addProjectForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="saveProjectStatus" name="status" class="form-control"
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
					ng-show="addProjectForm.startDate.$error.required 
						&& addProjectForm.startDate.$dirty">
					<strong>Error!</strong> Start Date is required.
				</div>
				<label class="col-sm-2 control-label">Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="saveProjectStartDate" class="form-control" 
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
					ng-show="addProjectForm.projectClient.$error.required 
						&& addProjectForm.projectClient.$dirty">
					<strong>Error!</strong> Project Client is required.
				</div>
				<label class="col-sm-2 control-label">Project Client</label>
				<div class="col-sm-10">
					<input type="text" name="projectClient" ng-model="saveProjectClient" 
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