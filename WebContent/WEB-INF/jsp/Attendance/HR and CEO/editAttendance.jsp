<div class="modal fade" tabindex="-1" role="dialog" id="viewAttendanceModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Detailed Attendance View</h4>
      </div>
      <div class="modal-body">
		<form name="editAttendanceForm" class="form-horizontal">
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
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>