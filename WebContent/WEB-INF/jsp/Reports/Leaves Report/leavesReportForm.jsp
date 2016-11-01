<form name="leavesReportForm" class="form-horizontal allAttendaceReportForm"
			ng-submit="leavesReportForm.$valid && checkFromToDateResult === false &&
			generateLeavesReport(saveLeavesFromDate, saveLeavesToDate)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leavesReportForm.fromDate.$error.required 
						&& leavesReportForm.fromDate.$dirty">
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
							<input ng-model="saveLeavesFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(saveLeavesFromDate, saveLeavesToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="leavesReportForm.toDate.$error.required 
						&& leavesReportForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-3">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveLeavesToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(saveLeavesFromDate, saveLeavesToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<button type="submit" class="col-sm-offset-2 col-sm-3 btn btn-primary">Generate Leaves Report</button>
      	</form>	