<div class="modal fade" tabindex="-1" role="dialog" id="addNewEmpTrainingModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Employee Training</h4>
      </div>
      <div class="modal-body">
		<form name="addEmpTrainingForm" class="form-horizontal"
			ng-submit="addEmpTrainingForm.$valid && checkEmpTrainingDuplicateResult === false && 
				checkEmpTrainingAvailabilityResult === false &&
				addEmpTraining(saveEmpTrainingEmp, saveEmpTraining)">
			
			<div role="alert" class="alert alert-danger padded" 
				ng-if="checkEmpTrainingDuplicateResult === true">
					<strong>Error!</strong> Employee Training already exists.
			</div>
			
			<div role="alert" class="alert alert-danger padded" 
				ng-if="checkEmpTrainingAvailabilityResult === true">
					<strong>Error!</strong> The selected Training is full, please select another one.
			</div>
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addEmpTrainingForm.training.$error.required 
						&& addEmpTrainingForm.training.$dirty">
					<strong>Error!</strong> Training is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Training</label>
				<div class="col-sm-10">
					<select ng-model="saveEmpTraining" name="training" class="form-control"
						required
						ng-change="checkEmpTrainingDuplicate(saveEmpTrainingEmp, saveEmpTraining); 
							checkEmpTrainingAvailability(saveEmpTraining)">
						<option value="">Select a training</option>
						<option value="{{training[0]}}" ng-repeat="training in allTrainings">
						{{training[1]}} {{training[2]}} {{training[4]}} {{training[9]}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addEmpTrainingForm.employee.$error.required 
						&& addEmpTrainingForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveEmpTrainingEmp" name="employee" class="form-control"
						required
						ng-change="checkEmpTrainingDuplicate(saveEmpTrainingEmp, saveEmpTraining); 
							checkEmpTrainingAvailability(saveEmpTraining)"
						ng-disabled="(addEmpTrainingForm.training.$pristine) || checkEmpTrainingAvailabilityResult === true">
						<option value="">Select an employee</option>
						<option value="{{employee.empId}}" 
						ng-repeat="employee in allEmpTrainingEmployees" 
						ng-hide="employee.designation.name == 'Ceo' || 
						employee.designation.name == 'Hr Manager'">
						{{employee.firstName}} {{employee.lastName}}</option>
					</select>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>