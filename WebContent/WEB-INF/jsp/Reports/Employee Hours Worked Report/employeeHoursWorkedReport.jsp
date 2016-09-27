<div class="row">
	<div class="col-sm-12">
		<jsp:include page="employeeHoursWorkedForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<!-- More codes above -->
		<table datatable="ng" dt-options="employeeHoursWorkedReportOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>From Date</th>
					<th>To Date</th>
					<th>Hours Worked</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="empHoursWorked in employeeHoursWorkedReportResult">
					<td>{{empHoursWorked[0]}}</td>
					<td>{{empHoursWorked[1]}}</td>
					<td>{{empHoursWorked[2]}}</td>
					<td>{{empHoursWorked[3]}}</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
	</div>
</div>