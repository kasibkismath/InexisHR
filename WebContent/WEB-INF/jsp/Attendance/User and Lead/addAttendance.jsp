<div class="modal fade" tabindex="-1" role="dialog" id="addAttendanceModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Attendance</h4>
      </div>
      <div class="modal-body">
		<form name="addAttendanceForm" class="form-horizontal"
			ng-submit="addAttendanceForm.$valid
				addAttendance()">
			
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>