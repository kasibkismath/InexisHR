<form name="workHistoryForm" ng-submit="workHistoryForm.$valid && 
		updateWorkHistory(editGetEmpId, editGetPastWork)">
	<div class="form-group">
   		<input type="hidden" ng-model="editGetEmpId" class="form-control">
	</div>
	<div class="form-group">
		<div ng-messages="workHistoryForm.pastWork.$error" role="alert" 
			ng-if="workHistoryForm.pastWork.$dirty">
			<div ng-message="maxlength" class="alert alert-danger padded">
				<strong>Error!</strong> Past Work should be not more than 5000 characters
			</div>
		</div>
		<label>Past Work</label>
		<textarea rows="15" class="form-control" name="pastWork" placeholder="Past Work" 
			ng-model="editGetPastWork" ng-maxlength="5000" char-count warning-count="50" 
			danger-count="10">
		</textarea>
	</div>
	<div class="pull-right">
		<button type="button" class="btn btn-danger" ng-click="resetEmpData(${empId})">
			<i class="fa fa-times fa-lg"></i> Reset
		</button>
		<button type="submit" class="btn btn-success">
			<i class="fa fa-check fa-lg"></i> Save
		</button>
	</div>
</form>