<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="modal fade" tabindex="-1" role="dialog" id="editMyTaskModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update My Task</h4>
      </div>
      <div class="modal-body">
		<form name="editMyTaskForm" class="form-horizontal"
			ng-submit="editMyTaskForm.$valid && checkForActualStartEndDateResult === false && 
				updateMyTask(updateTaskId, updateTaskStatus, updateActStartDate, updateActEndDate)">
				
			<!-- task_id -->
			<input type="hidden" ng-model="updateTaskId">
			

			<div class="form-group">
				<label class="col-sm-2 control-label">Task Description</label>
				<div class="col-sm-10">
					<textarea rows="8" class="form-control" name="taskDesc" readonly
						placeholder="Tasks Description" ng-model="updateTaskDesc">
					</textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editMyTaskForm.status.$error.required && editMyTaskForm.status.$dirty">
					<strong>Error!</strong> Task Status is required
				</div>
				<label class="col-sm-2 control-label">Task Status</label>
				<div class="col-sm-10">
					<select ng-model="updateTaskStatus" name="status" class="form-control"
						required>
						<option value="">Select Task Status</option>
						<option value="Completed">Completed</option>
						<option value="Pending">Pending</option>
						<option value="On-Hold">On-Hold</option>
						<option value="Terminated">Terminated</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editMyTaskForm.actStartDate.$error.required 
						&& editMyTaskForm.actStartDate.$dirty">
					<strong>Error!</strong> Actual Start Date is required.
				</div>
				<label class="col-sm-2 control-label">Actual Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
						date-min-limit="{{actualStartDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="updateActStartDate" class="form-control" 
							placeholder="Choose a date" name="actStartDate" required
							ng-change="checkForActualStartEndDate(updateActStartDate, updateActEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<!-- Actual Task End Date -->
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editMyTaskForm.actEndDate.$error.required 
						&& editMyTaskForm.actEndDate.$dirty">
					<strong>Error!</strong> Actual End Date is required.
				</div>
				<!-- IF Acutal End Date is less than Actual Start Date, error message is displayed -->
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForActualStartEndDateResult === true">
					<strong>Error!</strong> Actual End Date is cannot be less than Actual Start Date.
				</div>
				<label class="col-sm-2 control-label">Actual End Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-min-limit="{{actualStartDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<!-- Calls checkForActualStartEndDate() to validate actual start and end dates-->
							<input ng-model="updateActEndDate" class="form-control" 
							placeholder="Choose a date" name="actEndDate" required
							ng-change="checkForActualStartEndDate(updateActStartDate, updateActEndDate)">
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