<div class="row">
	<div class="col-sm-12">
		<jsp:include page="allAttendanceForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<!-- More codes above -->
		<table datatable="ng" dt-options="getAllAttendanceReportOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee</th>
					<th>Date</th>
					<th>Project</th>
					<th>Task Type</th>
					<th>Status</th>
					<th>Time Spent (Hrs)</th>
					<th>Tasks</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="attendance in allAttendancesReportResult">
					<td ng-cloak>{{attendance.employee.firstName}} {{attendance.employee.lastName}}</td>
					<td ng-cloak>{{attendance.date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{attendance.project.project_name}} </td>
					<td ng-cloak>{{attendance.task_type}}</td>
					<td ng-cloak>{{attendance.status}}</td>
					<td ng-cloak>{{attendance.time_spent}}</td>
					<td ng-cloak>{{attendance.task}}</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
	</div>
</div>