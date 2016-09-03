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
					ng-show="addLeaveForm.typeOfLeave.$error.required 
						&& addLeaveForm.typeOfLeave.$dirty">
					<strong>Error!</strong> Leave Type is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Leave Type</label>
				<div class="col-sm-10">
					<select ng-model="addLeaveTypeOfLeave" name="typeOfLeave" class="form-control"
						required
						ng-change=test(addLeaveTypeOfLeave)>
						<option value="">Select a Leave Type</option>
						<option ng-repeat="leaveType in leaveTypes" 
							value="{{leaveType.leave_type_id}}">
							{{leaveType.name}}
						</option>
						
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.fromDate.$error.required 
						&& addLeaveForm.fromDate.$dirty">
					<strong>Error!</strong> From Date is required, please select a date.
				</div>
				<label class="col-sm-2 control-label">From Date (inclusive)</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control" 
					date-min-limit="{{fromLeaveDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="addLeaveFromDate" class="form-control" name="fromDate"
							placeholder="Choose a date"
							ng-change="checkYear(addLeaveFromDate)" required>
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.toDate.$error.required 
						&& addLeaveForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required, please select a date.
				</div>
				<label class="col-sm-2 control-label">To Date (inclusive)</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control" 
					date-min-limit="{{addLeaveFromDate | date:'yyyy-MM-dd'}}"
					date-max-limit="{{maxDateLimitForFromDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="addLeaveToDate" class="form-control" 
							placeholder="Choose a date" name="toDate"
							ng-disabled="addLeaveForm.fromDate.$pristine" required>
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.noOfDays.$error.required 
						&& addLeaveForm.noOfDays.$dirty">
					<strong>Error!</strong> No of Days is required, please enter the days.
				</div>
				<label class="col-sm-2 control-label">No of Days (Without Holidays and Weekends)</label>
				<div class="col-sm-10">
					<input type="number" class="form-control" placeholder="No of days"
						name="noOfDays" ng-model="noOfDays" max=21 min=0 required>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.leaveOption.$error.required" 
					ng-if="addLeaveForm.leaveOption.$dirty">
					<strong>Error!</strong> Leave Option is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Leave Option</label>
				<div class="col-sm-10">
					<select ng-model="addLeaveOption" name="leaveOption" class="form-control"
						required ng-disabled="addLeaveForm.typeOfLeave.$pristine || 
							addLeaveForm.typeOfLeave.$invalid">
						<option value="">Select a Leave Option</option>
						<option value="Full Day">Full Day</option>
						<option ng-disabled="addLeaveTypeOfLeave != 2" value="Half Day">Half Day</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="addLeaveForm.reason.$error" role="alert" 
					ng-if="addLeaveForm.reason.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Reason should be not more than 150 characters
					</div>
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addLeaveForm.reason.$error.required" 
					ng-if="addLeaveForm.reason.$dirty">
					<strong>Error!</strong> Reason is required, please enter a reason.
				</div>
				<label class="col-sm-2 control-label">Reason</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="reason" 
						placeholder="Enter description" ng-model="addLeaveReason" ng-maxlength="150" 
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