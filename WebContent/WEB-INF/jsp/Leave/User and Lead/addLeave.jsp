<div class="modal fade" tabindex="-1" role="dialog" id="addLeaveModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Leave</h4>
      </div>
      <div class="modal-body">
		<form name="addLeaveForm" class="form-horizontal"
			ng-submit="addLeave(addLeaveFromDate)">
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.leaveType.$error.required" 
					ng-if="addLeaveForm.leaveType.$dirty">
					<strong>Error!</strong> Leave Type is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Leave Type</label>
				<div class="col-sm-10">
					<select name="leaveType" class="form-control"
						required>
						<option value="">Select a Leave Type</option>
						<option value="Annual Leave">Annual Leave</option>
						<option value="Casual Leave">Casual Leave</option>
						<option value="Sick Leave">Sick Leave</option>
						<option value="Lieu Leave">Lieu Leave</option>
						<option value="Special Holiday Leave">Special Holiday Leave</option>
						<option value="Remote Work">Remote Work</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">From Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control" date-min-limit="{{fromLeaveDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="addLeaveFromDate" class="form-control" name="fromDate"
							placeholder="Choose a date">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control" date-min-limit="{{addLeaveFromDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="addLeaveToDate" class="form-control" 
							placeholder="Choose a date"
							ng-change="test(addLeaveToDate, addLeaveFromDate)"
							ng-disabled="addLeaveForm.fromDate.$pristine">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.leaveOption.$error.required" 
					ng-if="addLeaveForm.leaveOption.$dirty">
					<strong>Error!</strong> Leave Option is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Leave Type</label>
				<div class="col-sm-10">
					<select name="leaveOption" class="form-control"
						required>
						<option value="">Select a Leave Option</option>
						<option value="Full Day">Full Day</option>
						<option value="Half Day">Half Day</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Description</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="description" 
						placeholder="Enter description" ng-model="saveNewCEODesc" ng-maxlength="100" 
						required char-count warning-count="50" danger-count="25"></textarea>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        	<button type="button" class="btn btn-primary">Save changes</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>