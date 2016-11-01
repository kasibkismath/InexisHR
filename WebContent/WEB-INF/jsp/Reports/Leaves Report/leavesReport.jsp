<div class="row">
	<div class="col-sm-12">
		<jsp:include page="leavesReportForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="leavesReportOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Type of Leave</th>
					<th>From Date</th>
					<th>Reporting Back Date</th>
					<th>Leave Option</th>
					<th>No of Days</th>
					<th>Status</th>
					<th>Reason</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="leave in generateLeavesReportResult">
					<td>{{leave.employee.firstName}} {{leave.employee.lastName}}</td>
					<td>{{leave.leaveType.name}}</td>
					<td>{{leave.leave_from | date : 'yyyy-MM-dd'}}</td>
					<td>{{leave.leave_to | date : 'yyyy-MM-dd'}}</td>
					<td>{{leave.leave_option}}</td>
					<td>{{leave.no_days}}</td>
					<td>{{leave.status}}</td>
					<td>{{leave.reason}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>