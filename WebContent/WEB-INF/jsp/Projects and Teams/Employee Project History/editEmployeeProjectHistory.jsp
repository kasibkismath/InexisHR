<div class="modal fade" tabindex="-1" role="dialog" id="editEmpProjectHistoryModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Employee Project Team History</h4>
      </div>
      <div class="modal-body">
		<form name="editEmpProjectHistoryForm" class="form-horizontal"
			ng-submit="editEmpProjectHistoryForm.$valid && 
			checkDuplicateEmpProjectHistoryResult === false &&
			checkFromToDateResult === false && 
			updateEmpProjectHistory(updateEmpProjectHistId, updateEmpProjectHistFromDate, 
			updateEmpProjectHistToDate)">
			
			<!-- Employee Project History Id -->
			<input type="hidden" ng-model="updateEmpProjectHistId">
			
			<div role="alert" class="alert alert-danger padded" 
				ng-show="checkDuplicateEmpProjectHistoryResult === true">
				<strong>Error!</strong> An employee cannot belong to the same team with same date ranges twice.
			</div>
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editEmpProjectHistoryForm.fromDate.$error.required 
						&& editEmpProjectHistoryForm.fromDate.$dirty">
					<strong>Error!</strong> From Date is required.
				</div>
				<label class="col-sm-2 control-label">From Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateEmpProjectHistFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(updateEmpProjectHistFromDate, 
							updateEmpProjectHistToDate); 
							checkDuplicateEmpProjectHistory(updateEmpProjectHistEmp, 
							updateEmpProjectHistTeam, 
							updateEmpProjectHistFromDate, updateEmpProjectHistToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="editEmpProjectHistoryForm.toDate.$error.required 
						&& editEmpProjectHistoryForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-if="checkFromToDateResult === true">
					<strong>Error!</strong> 'From Date' should be less than or equal to 'To Date'.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateEmpProjectHistToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(updateEmpProjectHistFromDate, 
							updateEmpProjectHistToDate);
							checkDuplicateEmpProjectHistory(updateEmpProjectHistEmp, 
							updateEmpProjectHistTeam, 
							updateEmpProjectHistFromDate, updateEmpProjectHistToDate)">
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