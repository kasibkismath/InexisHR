<div class="modal fade" tabindex="-1" role="dialog" id="deleteAttendanceModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Delete Attendance</h4>
      </div>
      <div class="modal-body">
   		<h3><i class="fa fa-question"></i> Do you really want to delete this attendance?</h3>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">
			<i class="fa fa-times"></i> Close
		</button>
		<button type="button" class="btn btn-success" ng-click="deleteAttendance(deleteAttd_id)">
			<i class="fa fa-check"></i> Delete
		</button>
      </div>
    </div>
  </div>
</div>