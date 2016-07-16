<div class="modal fade" tabindex="-1" role="dialog" id="addDesigModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Designation</h4>
      </div>
      <div class="modal-body">
	      <form class="form-horizontal" name="addDesignationForm"
	      	ng-submit="addDesignationForm.$valid && 
	      		addDesignation(addDesignationName)">
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
							ng-show="addDesignationForm.designation.$error.unique"
							ng-if="addDesignationForm.designation.$dirty">
							<i class="fa fa-frown-o fa-lg"></i>
							This designation already exists, try again.
				</div>
				<div ng-messages="addDesignationForm.designation.$error" role="alert" 
					ng-if="addDesignationForm.designation.$dirty">
					<div ng-message="required" class="alert alert-danger padded">
						<i class="fa fa-frown-o fa-lg"></i> Designation is required
					</div>
				</div>
				<label class="col-sm-2 control-label">Designation</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" placeholder="Designation"
						name="designation" ng-model="addDesignationName" ng-unique-designation
						required>
				</div>
			</div>
		  	<div class="modal-footer">
		  		<button type="button" class="btn btn-danger" data-dismiss="modal">
		  			<i class="fa fa-times fa-lg"></i> Close
		  		</button>
		        <button type="submit" class="btn btn-success">
		        	<i class="fa fa-check fa-lg"></i>Save
		        </button>
		    </div>
		   </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->