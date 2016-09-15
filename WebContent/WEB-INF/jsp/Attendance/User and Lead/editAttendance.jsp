<div class="modal fade" tabindex="-1" role="dialog" id="editAttendanceModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Attendance</h4>
      </div>
      <div class="modal-body">
		<form name="editAttendanceForm" class="form-horizontal"
			ng-submit="editAttendanceForm.$valid && checkAttendanceDuplicateResult === false &&
				timeSpentValidationError === false &&
				updateAttendance(editAttendanceId, editAttendanceDate, editAttendanceProject, 
				editAttendanceTaskType, editAttendanceTasks, editAttendanceTimeSpent, editAttendanceStatus)">
			
			<input type="hidden" ng-model="editAttendanceId">	
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.date.$error.required 
						&& editAttendanceForm.date.$dirty">
					<strong>Error!</strong> Date is required.
				</div>
				<label class="col-sm-2 control-label">Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="editAttendanceDate" class="form-control" 
							placeholder="Choose a date" name="date" required
							ng-change="checkDuplicateAttendance(editAttendanceDate,
							editAttendanceProject,editAttendanceTaskType)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.project.$error.required 
						&& editAttendanceForm.project.$dirty">
					<strong>Error!</strong> Project is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Project</label>
				<div class="col-sm-10">
					<select ng-model="editAttendanceProject" name="project" class="form-control"
						required
						ng-change="checkDuplicateAttendance(editAttendanceDate,
							editAttendanceProject,editAttendanceTaskType)" convert-to-number>
						<option value="">Select a Project</option>
						<option ng-repeat="project in projects" 
							value="{{project[2].project_id}}">
							{{project[2].project_name}}
						</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkAttendanceDuplicateResult == true">
					<strong>Error!</strong> Attendance Exists for this Date, Project and Task Type
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.taskType.$error.required 
						&& editAttendanceForm.taskType.$dirty">
					<strong>Error!</strong> Task Type is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Task Type</label>
				<div class="col-sm-10">
					<select ng-model="editAttendanceTaskType" name="taskType" class="form-control"
						required
						ng-change="checkDuplicateAttendance(editAttendanceDate,
							editAttendanceProject,editAttendanceTaskType)">
						<option value="">Select a Task Type</option>
						<option value="Development">Development</option>
						<option value="Business Analysis">Business Analysis</option>
						<option value="Testing">Testing</option>
						<option value="Data Migration">Data Migration</option>
						<option value="Meeting">Meeting</option>
						<option value="R & D">R & D</option>
						<option value="Investigation a Bug">Investigation a Bug</option>
						<option value="Bug Fixing">Bug Fixing</option>
						<option value="Deployment">Deployment</option>
						<option value="UAT">UAT</option>
						<option value="Internal Process">Internal Process</option>
						<option value="Tech Support">Tech Support</option>
						<option value="UI Design">UI Design</option>
						<option value="Training">Training</option>
						<option value="Digital Marketing">Digital Marketing</option>
						<option value="General">General</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="editAttendanceForm.reason.$error" role="alert" 
					ng-if="editAttendanceForm.tasks.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Tasks should be not more than 1000 characters
					</div>
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.tasks.$error.required" 
					ng-if="editAttendanceForm.tasks.$dirty">
					<strong>Error!</strong> Tasks is required, please enter task/s.
				</div>
				<label class="col-sm-2 control-label">Tasks</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="tasks" 
						placeholder="Enter Tasks" ng-model="editAttendanceTasks" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.timeSpent.$error.required 
						&& editAttendanceForm.timeSpent.$dirty">
					<strong>Error!</strong> Time Spent is Required
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="timeSpentValidationError == true">
					<strong>Error!</strong> Time spent should be between 0.50 to 16.00
				</div>
				<label class="col-sm-2 control-label">Time Spent (Hours)</label>
				<div class="col-sm-10">
					<input type="number" class="form-control" step="0.01" placeholder="Time Spent"
						name="timeSpent" ng-model="editAttendanceTimeSpent" required
						ng-keyup="timeSpentValidation(editAttendanceTimeSpent)"
						ng-mouseup="timeSpentValidation(saveAttendanceTimeSpent)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editAttendanceForm.status.$error.required 
						&& editAttendanceForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="editAttendanceStatus" name="status" class="form-control"
						required>
						<option value="">Select a Status</option>
						<option value="Completed">Completed</option>
						<option value="In-Progress">In-Progress</option>
						<option value="On-Hold">On-Hold</option>
						<option value="Terminated">Terminated</option>
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