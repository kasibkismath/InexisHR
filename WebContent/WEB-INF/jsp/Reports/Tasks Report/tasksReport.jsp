<div class="row">
	<div class="col-sm-12">
		<jsp:include page="tasksReportForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="tasksReportOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Task Title</th>
					<th>Assigned By</th>
					<th>Expected Start Date</th>
					<th>Expected End Date</th>
					<th>Actual Start Date</th>
					<th>Actual End Date</th>
					<th>Status</th>
					<th>Priority</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="task in generateTasksReportResult" ng-cloak>
					<td>{{task.employee.firstName}} {{task.employee.lastName}}</td>
					<td>{{task.task_title}}</td>
					<td>{{task.assigned_by.firstName}} {{task.assigned_by.lastName}}</td>
					<td>{{task.expected_start_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{task.expected_end_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{task.actual_start_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{task.actual_end_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{task.status}}</td>
					<td>{{task.priority}}</td>
					<td>{{task.task_desc}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>