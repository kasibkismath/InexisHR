<div class="modal fade" tabindex="-1" role="dialog" id="updateEmpHistoryModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Employee History</h4>
      </div>
      <div class="modal-body">
		<form name="updateEmpHistoryForm" class="form-horizontal"
			ng-submit="updateEmpHistoryForm.$valid && 
			updateEmpHistory(updateEmpHistoryId, updateEffectiveDate)">
			
			<input type="hidden" ng-model="updateEmpHistoryId">
			
			<div class="form-group">
				<label class="col-sm-2 control-label">Effective Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateEffectiveDate" class="form-control" 
							placeholder="Choose a date" name="effectiveDate">
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