<form name="appraisalsReportForm" class="form-horizontal allAttendaceReportForm"
			ng-submit="appraisalsReportForm.$valid &&
			generateAppraisalsReport(saveAppraisalYear)">
			
	<div class="form-group">
		<div role="alert" class="alert alert-danger padded errorMessage" 
			ng-show="appraisalsReportForm.year.$error.required" 
			ng-if="appraisalsReportForm.year.$dirty">
			<strong>Error!</strong> Appraisal Year is required, please select one.
		</div>
		<label class="col-sm-2 control-label">Appraisal Year</label>
		<div class="col-sm-3">
			<select ng-model="saveAppraisalYear" name="year" class="form-control" 
				required>
				<option value="">Select an appraisal year</option>
				<option ng-repeat="year in years" value="{{year}}">{{year}}</option>
			</select>
		</div>
	</div>
	<button type="submit" class="col-sm-offset-2 col-sm-3 btn btn-primary">
		Generate Appraisals Report
	</button>
</form>	