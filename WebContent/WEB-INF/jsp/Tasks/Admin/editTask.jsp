<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="modal fade" tabindex="-1" role="dialog" id="editAllaskModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update My Task</h4>
      </div>
      <div class="modal-body">
			<div class="form-group">
				<label class="col-sm-2 control-label">Task Description</label>
				<div class="col-sm-10">
					<textarea rows="8" class="form-control" name="taskDesc" readonly
						placeholder="Tasks Description" ng-model="updateTaskDesc">
					</textarea>
				</div>
			</div>
      </div>
      <div class="modal-footer">
	      <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	 </div>
    </div>
  </div>
</div>