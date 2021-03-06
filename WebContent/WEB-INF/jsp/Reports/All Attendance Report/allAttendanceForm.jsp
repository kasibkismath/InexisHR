<form name="getAllAttdForm" class="form-horizontal allAttendaceReportForm"
			ng-submit="getAllAttdForm.$valid && checkFromToDateResult === false &&
			getAllAttendacesForReport(saveAllAttdFromDate, saveAllAttdToDate)">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="getAllAttdForm.fromDate.$error.required 
						&& getAllAttdForm.fromDate.$dirty">
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
							<input ng-model="saveAllAttdFromDate" class="form-control" 
							placeholder="Choose a date" name="fromDate" required
							ng-change="checkFromToDate(saveAllAttdFromDate, saveAllAttdToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="getAllAttdForm.toDate.$error.required 
						&& getAllAttdForm.toDate.$dirty">
					<strong>Error!</strong> To Date is required.
				</div>
				<label class="col-sm-2 control-label">To Date</label>
				<div class="col-sm-3">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-max-limit="{{currentDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveAllAttdToDate" class="form-control" 
							placeholder="Choose a date" name="toDate" required
							ng-change="checkFromToDate(saveAllAttdFromDate, saveAllAttdToDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<button type="submit" class="col-sm-offset-2 col-sm-3 btn btn-primary">Generate Attendance Report</button>
      	</form>	