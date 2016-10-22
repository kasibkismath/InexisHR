<div class="modal fade" tabindex="-1" role="dialog" id="updateEmpTrainingModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Employee Training</h4>
      </div>
      <div class="modal-body">
		<form name="updateEmpTrainingForm" class="form-horizontal"
			ng-submit="updateEmpTrainingForm.$valid &&
				updateEmpTraining(updateEmpTrainingId, updateEmpTrainingRemarks)">
			
			<input type="hidden" ng-model="updateEmpTrainingId">
			
			<div class="form-group">
				<label class="col-sm-2 control-label">Training</label>
				<div class="col-sm-10">
					<select ng-model="updateEmpTraining_Id" name="training" class="form-control"
						ng-disabled="true" convert-to-number>
						<option value="">Select a training</option>
						<option value="{{training[0]}}" ng-repeat="training in allTrainings">
						{{training[1]}} {{training[2]}} {{training[4]}} {{training[9]}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="updateEmpTrainingEmp" name="employee" class="form-control"
						ng-disabled="true" convert-to-number>
						<option value="">Select an employee</option>
						<option value="{{employee.empId}}" 
						ng-repeat="employee in allEmpTrainingEmployees" 
						ng-hide="employee.designation.name == 'Ceo' || 
						employee.designation.name == 'Hr Manager'">
						{{employee.firstName}} {{employee.lastName}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="updateEmpTrainingForm.remarks.$error" role="alert" 
					ng-if="updateEmpTrainingForm.remarks.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Remarks should be not more than 1000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Remarks</label>
				<div class="col-sm-10">
					<textarea rows="10" class="form-control" name="remarks" 
						placeholder="Remarks" ng-model="updateEmpTrainingRemarks" 
						ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
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