<div class="modal fade" tabindex="-1" role="dialog" id="empDeleteModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Delete Employee</h4>
      </div>
      <div class="modal-body">
       	<h3><i class="fa fa-question" aria-hidden="true"></i> Do you really want to delete this employee?</h3>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-danger" ng-click="deleteEmp()">Delete</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->