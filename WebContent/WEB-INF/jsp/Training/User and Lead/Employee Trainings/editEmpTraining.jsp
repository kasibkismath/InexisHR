<div class="modal fade" tabindex="-1" role="dialog" id="updateEmpTrainingModalUser">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Training</h4>
      </div>
      <div class="modal-body">
		<form name="updateEmpTrainingUserForm" class="form-horizontal"
			ng-submit="updateEmpTrainingUserForm.$valid &&
				updateUserEmpTraining(updateEmpTrainingId, updateEmpTrainingStatus, 
				updateEmpTrainingActStartDate, updateEmpTrainingActEndDate)">
			
			<input type="hidden" ng-model="updateEmpTrainingId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateEmpTrainingUserForm.status.$error.required 
						&& updateEmpTrainingUserForm.status.$dirty">
					<strong>Error!</strong> Status is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Status</label>
				<div class="col-sm-10">
					<select ng-model="updateEmpTrainingStatus" name="status" class="form-control"
						required>
						<option value="">Select a status</option>
						<option value="Pending">Pending</option>
						<option value="In-Progress">In-Progress</option>
						<option value="Completed">Completed</option>
						<option value="Terminated">Terminated</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateEmpTrainingUserForm.actStartDate.$error.required 
						&& updateEmpTrainingUserForm.actStartDate.$dirty">
					<strong>Error!</strong> Actual Start Date is required.
				</div>
				<label class="col-sm-2 control-label">Actual Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateEmpTrainingActStartDate" class="form-control" 
							placeholder="Choose a date" name="actStartDate" required>
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateEmpTrainingUserForm.actEndDate.$error.required 
						&& updateEmpTrainingUserForm.actEndDate.$dirty">
					<strong>Error!</strong> Actual End Date is required.
				</div>
				<label class="col-sm-2 control-label">Actual Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateEmpTrainingActEndDate" class="form-control" 
							placeholder="Choose a date" name="actEndDate" required
							ng-change="">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Remarks</label>
				<div class="col-sm-10">
					<textarea rows="10" class="form-control" name="remarks" 
						placeholder="Remarks" ng-model="updateEmpTrainingRemarks" readonly></textarea>
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