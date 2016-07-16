<div class="modal fade" tabindex="-1" role="dialog" id="deleteDesigModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Delete Designation</h4>
      </div>
      <div class="modal-body">
        	<h3><i class="fa fa-question"></i> Do you really want to delete this designation?</h3>
        	<div class="desigDeletionInfo">
        		<span>
        			<small><i class="fa fa-bullhorn"></i> Before deleting this designation, make sure that you delete all the employees 
        			 belonging to this designation.
        			</small>
        		</span>
        	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">
        <i class="fa fa-times fa-lg"></i> Close
        </button>
        <button type="button" class="btn btn-success" ng-click="deleteDesignation()">
        <i class="fa fa-check fa-lg"></i> Delete
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->