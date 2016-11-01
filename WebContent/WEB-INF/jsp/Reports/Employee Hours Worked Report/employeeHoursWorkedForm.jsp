<form name="empHoursWorkedForm" class="form-horizontal allAttendaceReportForm"
			ng-submit="empHoursWorkedForm.$valid && checkFromToDateResult === false &&
			getEmployeeHoursWorkedReport(saveEmpHoursWorkedFromDate, saveEmpHoursWorkedToDate)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="empHoursWorkedForm.fromDate.$error.required 
						&& empHoursWorkedForm.fromDate.$dirty">
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
							<input ng-model="saveEmpHoursWorkedFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(saveEmpHoursWorkedFromDate, saveEmpHoursWorkedToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="empHoursWorkedForm.toDate.$error.required 
						&& empHoursWorkedForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-3">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveEmpHoursWorkedToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(saveEmpHoursWorkedFromDate, saveEmpHoursWorkedToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<button type="submit" class="col-sm-offset-2 col-sm-3 btn btn-primary">Generate Hours Worked Report</button>
      	</form>	