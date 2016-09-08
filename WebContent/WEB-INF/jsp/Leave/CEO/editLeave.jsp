<div class="modal fade" tabindex="-1" role="dialog" id="ceoEditLeaveModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Leave Status</h4>
      </div>
      <div class="modal-body">
		<form name="editLeaveForm" class="form-horizontal"
			ng-submit="editLeaveForm.$valid &&
				updateLeaveStatus(editLeaveId, editLeaveStatus)">
			
			<input type="hidden" ng-model="editLeaveId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editLeaveForm.leaveStatus.$error.required 
						&& editLeaveForm.leaveStatus.$dirty">
					<strong>Error!</strong> Leave Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Leave Status</label>
				<div class="col-sm-10">
					<select ng-model="editLeaveStatus" name="leaveStatus" class="form-control"
						required>
						<option value="">Select a Leave Status</option>
						<option value="Pending">Pending</option>
						<option value="Approved">Approved</option>
						<option value="Rejected">Rejected</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Reason</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="reason" 
						placeholder="Enter description" ng-model="editLeaveReason" ng-maxlength="150" 
						required char-count warning-count="50" danger-count="25" 
						ng-disabled="disabledCEOEditLeave"></textarea>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save changes</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>