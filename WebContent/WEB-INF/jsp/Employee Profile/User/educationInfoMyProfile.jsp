<div class="row">
	<div class="col-sm-12 topPad">
			<div class="modal show" tabindex="-1" role="dialog" id="educationInfoMyProfileModal">
  				<div class="modal-dialog">
    				<div class="modal-content">
    					<div class="modal-header">
        					<h3 class="modal-title">Education & Qualifications</h3>
     					</div>
      					<div class="modal-body">
        					<form class="form-horizontal">
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Education</label>
							    <div class="col-sm-10">
							      <p class="form-control-static" ng-if="education === ''">Not Available</p>
							      <p class="form-control-static" ng-if="education != ''">{{education}}</p>
							    </div>
							  </div>
							</form>
      					</div>
				    </div>
				 </div>
			</div>
		</div>
</div>