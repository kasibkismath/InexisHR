<div class="modal fade" tabindex="-1" role="dialog" id="empDisableModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Disable Employee</h4>
      </div>
      <div class="modal-body">
       	<form name="disableEmpForm">
       		<div class="form-group">
       			<input type="hidden">
       		</div>
       		<div class="form-group">
       			<label>Status</label>
       			<toggle-switch
             		ng-model="isEnabled"
              		on-label="Enabled"
              		off-label="Disabled"
              		knob-label="Status"
              		class="switch-primary">
            </toggle-switch>
       		</div>
       	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">
        	<i class="fa fa-times fa-lg"></i> Close
        </button>
        <button type="button" class="btn btn-success" ng-click="disableEmp(isEnabled)">
        	<i class="fa fa-check fa-lg"></i> Save
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->