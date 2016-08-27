<div class="modal fade" tabindex="-1" role="dialog" id="deleteLeadAppraisalModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Delete Appraisal</h4>
      </div>
      <div class="modal-body">
   		<h3><i class="fa fa-question"></i> Do you really want to delete this Team Lead Appraisal?</h3>
        	<div style="padding-bottom: 20px; padding-top: 20px;">
	          <h6>
	          	<i class="fa fa-bullhorn fa-lg"></i> 
	          	<b>NOTE :</b>  If HR Appraisal for this employee, year 
	          	and team is completed, <b>Team Lead Appraisal cannot be deleted</b>.
	          </h6>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">
			<i class="fa fa-times"></i> Close
		</button>
		<button type="button" class="btn btn-success" ng-disabled="TeamLeadDeleteResult"
			ng-click="deleteLeadAppraisal(deleteLeadAppraisalId)">
			<i class="fa fa-check"></i> Delete
		</button>
      </div>
    </div>
  </div>
</div>