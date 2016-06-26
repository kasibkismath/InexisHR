<form name="educationForm" ng-submit="educationForm.$valid && 
		updateEmpEduDetails(editGetEmpId, editGetEducation)">
	<div class="form-group">
   		<input type="hidden" ng-model="editGetEmpId" class="form-control">
	</div>
	<div class="form-group">
		<div ng-messages="educationForm.education.$error" role="alert" ng-if="educationForm.education.$dirty">
			<div ng-message="maxlength" class="alert alert-danger padded">
				<strong>Error!</strong> Education should be not more than 1000 characters
			</div>
		</div>
		<label>Education</label>
		<textarea rows="8" class="form-control" name="education" placeholder="Education" 
			ng-model="editGetEducation" ng-maxlength="1000" char-count warning-count="25" 
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