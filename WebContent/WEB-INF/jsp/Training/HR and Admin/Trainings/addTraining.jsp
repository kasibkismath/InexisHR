<div class="modal fade" tabindex="-1" role="dialog" id="addNewTrainingModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Training</h4>
      </div>
      <div class="modal-body">
		<form name="addTrainingForm" class="form-horizontal"
			ng-submit="addTrainingForm.$valid && checkStartEndDateResult === false">
			
			<div role="alert" class="alert alert-danger padded" 
					ng-show="checkTrainingDuplicateResult === true">
					<strong>Error!</strong> Duplicate Training.
				</div>
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.trainingName.$error.required 
						&& addTrainingForm.trainingName.$dirty">
					<strong>Error!</strong> Training Name is required.
				</div>
				<label class="col-sm-2 control-label">Training Name</label>
				<div class="col-sm-10">
					<input type="text" name="trainingName" ng-model="saveTrainingName" 
					class="form-control" required placeholder="Training Name"
					ng-change="checkTrainingDuplicate(saveTrainingName, saveDifficultyLevel, 
					saveTrainingType, saveExpStartDate, saveExpEndDate)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.difficultyLevel.$error.required 
						&& addTrainingForm.difficultyLevel.$dirty">
					<strong>Error!</strong> Level of Difficulty is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Level of Difficulty</label>
				<div class="col-sm-10">
					<select ng-model="saveDifficultyLevel" name="difficultyLevel" class="form-control"
						required
						ng-change="checkTrainingDuplicate(saveTrainingName, saveDifficultyLevel, 
						saveTrainingType, saveExpStartDate, saveExpEndDate)">
						<option value="">Select Level of Difficulty</option>
						<option value="Basic">Basic</option>
						<option value="Intermediate">Intermediate</option>
						<option value="Advanced">Advanced</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.trainingType.$error.required 
						&& addTrainingForm.trainingType.$dirty">
					<strong>Error!</strong> Type of Training is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Type of Training</label>
				<div class="col-sm-10">
					<select ng-model="saveTrainingType" name="trainingType" class="form-control"
						required
						ng-change="checkTrainingDuplicate(saveTrainingName, saveDifficultyLevel, 
						saveTrainingType, saveExpStartDate, saveExpEndDate)">
						<option value="">Select Type of Training</option>
						<option value="Online">Online</option>
						<option value="In-Person">In-Person</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.expStartDate.$error.required 
						&& addTrainingForm.expStartDate.$dirty">
					<strong>Error!</strong> Expected Start Date.
				</div>
				<label class="col-sm-2 control-label">Expected Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control">
						<div class="input-group">
							<input ng-model="saveExpStartDate" class="form-control" 
							placeholder="Choose a date" name="expStartDate" required
							ng-change="checkStartEndDateRange(saveExpStartDate, saveExpEndDate); 
							checkTrainingDuplicate(saveTrainingName, saveDifficultyLevel, 
							saveTrainingType, saveExpStartDate, saveExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.expEndDate.$error.required 
						&& addTrainingForm.expEndDate.$dirty">
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
							<input ng-model="saveExpEndDate" class="form-control" 
							placeholder="Choose a date" name="expEndDate" required
							ng-change="checkStartEndDate(saveExpStartDate, saveExpEndDate);
							checkTrainingDuplicate(saveTrainingName, saveDifficultyLevel, 
							saveTrainingType, saveExpStartDate, saveExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.duration.$error.required 
						&& addTrainingForm.duration.$dirty">
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
					<input type="number" name="duration" ng-model="saveDuration" 
					class="form-control" required placeholder="Duration (In Days)"
					ng-disabled="(addTrainingForm.expStartDate.$pristine) || 
					(addTrainingForm.expEndDate.$pristine)"
					ng-change="checkDurationError(saveDuration); 
					checkForDateRange(saveExpStartDate, saveExpEndDate, saveDuration)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.trainedBy.$error.required 
						&& addTrainingForm.trainedBy.$dirty">
					<strong>Error!</strong> Trained By is required.
				</div>
				<label class="col-sm-2 control-label">Trained By</label>
				<div class="col-sm-10">
					<input type="text" name="trainedBy" ng-model="saveTrainedBy" 
					class="form-control" required placeholder="Trained By">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.maxCandidates.$error.required 
						&& addTrainingForm.maxCandidates.$dirty">
					<strong>Error!</strong> Max Candidates is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForMaxCandidatesResult === true">
					<strong>Error!</strong> Max Candidates should not be negative or equal to zero.
				</div>
				<label class="col-sm-2 control-label">Max Candidates</label>
				<div class="col-sm-10">
					<input type="number" name="maxCandidates" ng-model="saveMaxCandidates" 
					class="form-control" required placeholder="Max Candidates"
					ng-change="checkForMaxCandidates(saveMaxCandidates)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForCostResult === true">
					<strong>Error!</strong> Cost cannot be negative.
				</div>
				<label class="col-sm-2 control-label">Cost (In LKR)</label>
				<div class="col-sm-10">
					<input type="number" name="cost" ng-model="saveCost" 
					class="form-control" placeholder="Cost"
					ng-change="checkForCost(saveCost)">
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTrainingForm.objectives.$error.required 
						&& addTrainingForm.objectives.$dirty">
					<strong>Error!</strong> Training Objectives is required.
				</div>
				<div ng-messages="addTrainingForm.objectives.$error" role="alert" 
					ng-if="addTrainingForm.objectives.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Training Objectives should be not more than 5000 characters
					</div>
				</div>
				<label class="col-sm-2 control-label">Training Objectives</label>
				<div class="col-sm-10">
					<textarea rows="10" class="form-control" name="objectives" 
						placeholder="Training Objectives" ng-model="saveObjectives" 
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