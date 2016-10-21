<div class="modal fade" tabindex="-1" role="dialog" id="updateTrainingModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Training</h4>
      </div>
      <div class="modal-body">
		<form name="updateTrainingForm" class="form-horizontal"
			ng-submit="updateTrainingForm.$valid && checkStartEndDateResult === false &&
			checkTrainingDuplicateResult === false && checkDurationErrorResult === false && 
			checkForDateRangeResult === false && checkForMaxCandidatesResult === false && 
			checkForCostResult === false && checkMaxCandidatesEmpTrainingResult === false &&
			updateTraining(updateTrainingId, updateTrainingName, updateDifficultyLevel, updateTrainingType, 
			updateExpStartDate, updateExpEndDate, updateDuration, updateTrainedBy, updateMaxCandidates, 
			updateCost, updateObjectives)">
			
			<input type="hidden" ng-model="updateTrainingId">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.trainingName.$error.required 
						&& updateTrainingForm.trainingName.$dirty">
					<strong>Error!</strong> Training Name is required.
				</div>
				<label class="col-sm-2 control-label">Training Name</label>
				<div class="col-sm-10">
					<input type="text" name="trainingName" ng-model="updateTrainingName" 
					class="form-control" required placeholder="Training Name"
					ng-change="checkTrainingDuplicate(updateTrainingName, updateDifficultyLevel, 
					updateTrainingType, updateExpStartDate, updateExpEndDate)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.difficultyLevel.$error.required 
						&& updateTrainingForm.difficultyLevel.$dirty">
					<strong>Error!</strong> Level of Difficulty is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Level of Difficulty</label>
				<div class="col-sm-10">
					<select ng-model="updateDifficultyLevel" name="difficultyLevel" class="form-control"
						required
						ng-change="checkTrainingDuplicate(updateTrainingName, updateDifficultyLevel, 
					updateTrainingType, updateExpStartDate, updateExpEndDate)">
						<option value="">Select Level of Difficulty</option>
						<option value="Basic">Basic</option>
						<option value="Intermediate">Intermediate</option>
						<option value="Advanced">Advanced</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.trainingType.$error.required 
						&& updateTrainingForm.trainingType.$dirty">
					<strong>Error!</strong> Type of Training is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Type of Training</label>
				<div class="col-sm-10">
					<select ng-model="updateTrainingType" name="trainingType" class="form-control"
						required
						ng-change="checkTrainingDuplicate(updateTrainingName, updateDifficultyLevel, 
					updateTrainingType, updateExpStartDate, updateExpEndDate)">
						<option value="">Select Type of Training</option>
						<option value="Online">Online</option>
						<option value="In-Person">In-Person</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.expStartDate.$error.required 
						&& updateTrainingForm.expStartDate.$dirty">
					<strong>Error!</strong> Expected Start Date.
				</div>
				<label class="col-sm-2 control-label">Expected Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateExpStartDate" class="form-control" 
							placeholder="Choose a date" name="expStartDate" required
							ng-change="checkStartEndDateRange(updateExpStartDate, updateExpEndDate); 
							checkTrainingDuplicate(updateTrainingName, updateDifficultyLevel, 
							updateTrainingType, updateExpStartDate, updateExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div role="alert" class="alert alert-danger padded" 
					ng-show="checkTrainingDuplicateResult === true">
					<strong>Error!</strong> Training already exists for this training name, 
					level of difficulty, type of training and expected start and end dates.
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.expEndDate.$error.required 
						&& updateTrainingForm.expEndDate.$dirty">
					<strong>Error!</strong> Expected End Date.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkStartEndDateResult === true">
					<strong>Error!</strong> Expected Start Date should be more than or equal to 
					Expected End Date
				</div>
				<label class="col-sm-2 control-label">Expected End Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="updateExpEndDate" class="form-control" 
							placeholder="Choose a date" name="expEndDate" required
							ng-change="checkStartEndDateRange(updateExpStartDate, updateExpEndDate); 
							checkTrainingDuplicate(updateTrainingName, updateDifficultyLevel, 
							updateTrainingType, updateExpStartDate, updateExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.duration.$error.required 
						&& updateTrainingForm.duration.$dirty">
					<strong>Error!</strong> Duration is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDurationErrorResult === true">
					<strong>Error!</strong> Duration should not be negative or equal to zero.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForDateRangeResult === true">
					<strong>Error!</strong> Duration should be less than, 
					Expected End Date - Expected Start Date
				</div>
				<label class="col-sm-2 control-label">Duration (In Days)</label>
				<div class="col-sm-10">
					<input type="number" name="duration" ng-model="updateDuration" 
					class="form-control" required placeholder="Duration (In Days)"
					ng-disabled="updateExpStartDate == undefined || updateExpEndDate == undefined"
					ng-change="checkDurationError(updateDuration); 
					checkForDateRange(updateExpStartDate, updateExpEndDate, updateDuration)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.trainedBy.$error.required 
						&& updateTrainingForm.trainedBy.$dirty">
					<strong>Error!</strong> Trained By is required.
				</div>
				<label class="col-sm-2 control-label">Trained By</label>
				<div class="col-sm-10">
					<input type="text" name="trainedBy" ng-model="updateTrainedBy" 
					class="form-control" required placeholder="Trained By">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.maxCandidates.$error.required 
						&& updateTrainingForm.maxCandidates.$dirty">
					<strong>Error!</strong> Max Candidates is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForMaxCandidatesResult === true">
					<strong>Error!</strong> Max Candidates should not be negative or equal to zero.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkMaxCandidatesEmpTrainingResult === true">
					<strong>Error!</strong> Max Candidates cannot be less than Total Number of Employee Trainings for this Training.
				</div>
				<label class="col-sm-2 control-label">Max Candidates</label>
				<div class="col-sm-10">
					<input type="number" name="maxCandidates" ng-model="updateMaxCandidates" 
					class="form-control" required placeholder="Max Candidates"
					ng-change="checkForMaxCandidates(updateMaxCandidates); 
					checkMaxCandidatesEmpTraining(updateTrainingId, updateMaxCandidates)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForCostResult === true">
					<strong>Error!</strong> Cost cannot be negative.
				</div>
				<label class="col-sm-2 control-label">Cost (In LKR)</label>
				<div class="col-sm-10">
					<input type="number" name="cost" ng-model="updateCost" 
					class="form-control" placeholder="Cost"
					ng-change="checkForCost(updateCost)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="updateTrainingForm.objectives.$error.required 
						&& updateTrainingForm.objectives.$dirty">
					<strong>Error!</strong> Training Objectives is required.
				</div>
				<div ng-messages="updateTrainingForm.objectives.$error" role="alert" 
					ng-if="updateTrainingForm.objectives.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Training Objectives should be not more than 5000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Training Objectives</label>
				<div class="col-sm-10">
					<textarea rows="10" class="form-control" name="objectives" 
						placeholder="Training Objectives" ng-model="updateObjectives" 
						ng-maxlength="5000" 
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