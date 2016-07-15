<div class="modal fade" tabindex="-1" role="dialog" id="editDesigModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Designation</h4>
      </div>
      <div class="modal-body">
	      <form class="form-horizontal" name="updateDesignationForm">
	      	<div class="form-group">
				<label class="col-sm-2 control-label">ID</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" placeholder="ID"
						name="id" ng-model="getEditDesignationId" disabled>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
							ng-show="updateDesignationForm.designation.$error.unique"
							ng-if="updateDesignationForm.designation.$dirty">
							<i class="fa fa-frown-o fa-lg"></i>
							This designation already exists, try again.
				</div>
				<label class="col-sm-2 control-label">Designation</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" placeholder="Designation"
						name="designation" ng-model="getEditDesignationName" ng-unique-designation>
				</div>
			</div>
		  	<div class="modal-footer">
		  		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		    </div>
		   </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->