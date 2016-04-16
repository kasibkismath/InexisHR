<div class="modal fade" tabindex="-1" role="dialog" id="deleteUserModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Delete User</h4>
      </div>
      <div class="modal-body">
        <h3>Do you really want to delete this user?</h3>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times fa-lg"></i> Cancel</button>
        <button type="button" class="btn btn-success" id="deleteUserOK" ng-click="deleteUser()"><i class="fa fa-check fa-lg"></i> OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->