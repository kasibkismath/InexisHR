<div class="row">
	<div class="col-sm-12 topPad">
			<div class="modal show" tabindex="-1" role="dialog" id="workInfoMyProfileModal">
  				<div class="modal-dialog">
    				<div class="modal-content">
    					<div class="modal-header">
        					<h3 class="modal-title">Work Experience</h3>
     					</div>
      					<div class="modal-body">
        					<form class="form-horizontal">
							  <div class="form-group">
							    <label class="col-sm-2 control-label">Work Experience</label>
							    <div class="col-sm-10">
							      <p class="form-control-static" ng-if="workExp === ''">Not Available</p>
							      <p class="form-control-static" ng-if="workExp != ''">{{workExp}}</p>
							    </div>
							  </div>
							</form>
      					</div>
				    </div>
				 </div>
			</div>
		</div>
</div>