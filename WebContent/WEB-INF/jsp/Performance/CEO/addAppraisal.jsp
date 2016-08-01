<div class="modal fade" tabindex="-1" role="dialog" id="CEOAddAppraisal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Add Appraisal</h4>
			</div>
			<div class="modal-body">
				<form name="ceoAddAppraisalForm" class="form-horizontal">
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.employee.$error.required" 
							ng-if="ceoAddAppraisalForm.employee.$dirty">
							<strong>Error!</strong> Employee is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Employee</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOEmployee" name="employee" class="form-control" 
								required>
								<option value="" >Select an employee</option>
								<option value="2" >Kasib Kismath</option>
								<option value="3" >Safeer Hussain</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.year.$error.required" 
							ng-if="ceoAddAppraisalForm.year.$dirty">
							<strong>Error!</strong> Year is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Year</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOYear" name="year" class="form-control" 
								required>
								<option value="">Select an Year</option>
								<option ng-repeat="year in years">{{year}}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.status.$error.required" 
							ng-if="ceoAddAppraisalForm.status.$dirty">
							<strong>Error!</strong> Status is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Status</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOStatus" name="status" class="form-control" 
								required>
								<option value="">Select status</option>
								<option value="Pending">Pending</option>
								<option value="In-Progess">In Progess</option>
								<option value="Completed">Completed</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.skillScore.$error.required" 
							ng-if="ceoAddAppraisalForm.skillScore.$dirty">
							<strong>Error!</strong> Skill Level Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Skill Level Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOSkillScore" name="skillScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.mentorshipScore.$error.required" 
							ng-if="ceoAddAppraisalForm.mentorshipScore.$dirty">
							<strong>Error!</strong> Mentorship Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Mentorship Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOMentorshipScore" name="mentorshipScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.taskCompScore.$error.required" 
							ng-if="ceoAddAppraisalForm.taskCompScore.$dirty">
							<strong>Error!</strong> Task Completion Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Skill Level Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOTaskCompScore" name="taskCompScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div role="alert" class="alert alert-danger padded" 
							ng-show="ceoAddAppraisalForm.currPerformanceScore.$error.required" 
							ng-if="ceoAddAppraisalForm.currPerformanceScore.$dirty">
							<strong>Error!</strong> Current Performance Score is required, please select one.
						</div>
						 <label class="col-sm-2 control-label">Current Performance Score</label>
						 <div class="col-sm-10">
							<select ng-model="saveNewCEOCurrPerformanceScore" name="currPerformanceScore" class="form-control" 
								required>
								<option value="">Select score</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div ng-messages="ceoAddAppraisalForm.description.$error" role="alert" 
							ng-show="ceoAddAppraisalForm.description.$dirty">
							<div ng-message="required" class="alert alert-danger padded">
								<strong>Error!</strong> Description is required
							</div>
							<div ng-message="maxlength" class="alert alert-danger padded">
								<strong>Error!</strong> Description should be not more than 10,000 characters
							</div>
						</div>
						 <label class="col-sm-2 control-label">Description</label>
						 <div class="col-sm-10">
							<textarea rows="15" class="form-control" name="description" 
							 ng-model="saveNewCEODescription" ng-maxlength="10000" required 
							char-count warning-count="25" danger-count="10"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>