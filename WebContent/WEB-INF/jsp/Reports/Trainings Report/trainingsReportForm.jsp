<form name="trainingsReportForm" class="form-horizontal allAttendaceReportForm"
			ng-submit="trainingsReportForm.$valid && checkFromToDateResult === false &&
			generateTrainingsReport(saveTrainingsFromDate, saveTrainingsToDate, 
			saveTrainingBudget)">
			
		<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="trainingsReportForm.fromDate.$error.required 
						&& trainingsReportForm.fromDate.$dirty">
					<strong>Error!</strong> From Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded errorMessage" 
					ng-show="checkFromToDateResult === true">
					<strong>Error!</strong> From Date should be less than To Date
				</div>
				<label class="col-sm-2 control-label">From Date</label>
				<div class="col-sm-3">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveTrainingsFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(saveTrainingsFromDate, saveTrainingsToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="trainingsReportForm.toDate.$error.required 
						&& trainingsReportForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-3">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveTrainingsToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(saveTrainingsFromDate, saveTrainingsToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded errorMessage" 
					ng-show="trainingsReportForm.budgetType.$error.required" 
					ng-if="trainingsReportForm.budgetType.$dirty">
					<strong>Error!</strong> Budget Type is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Budget Type</label>
				<div class="col-sm-3">
					<select ng-model="saveTrainingBudget" name="budgetType" class="form-control" 
						required>
						<option value="">Select a budget type</option>
						<option value="High Budget">High Budget</option>
						<option value="Medium Budget">Medium Budget</option>
						<option value="Low Budget">Low Budget</option>
						<option value="All Budget">All Budgets</option>
					</select>
				</div>
			</div>
	<button type="submit" class="col-sm-offset-2 col-sm-3 btn btn-primary">
		Generate Trainings Report
	</button>
</form>	