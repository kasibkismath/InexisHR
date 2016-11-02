<div class="row">
	<div class="col-sm-12 allTasks">
		<table datatable="ng" dt-options="dtOptionsLeadCEO" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee</th>
					<th>Task Title</th>
					<th>Status</th>
					<th>Priority</th>
					<th>Assigned By</th>
					<th>Expected Start Date</th>
					<th>Expected Finish Date</th>
					<th>Actual Start Date</th>
					<th>Actual Finish Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="task in getAllTasksByYearResult" 
				 	ng-class="{
				 		'overdue-task': task.expected_end_date < currentDate &&
				 		(task.status == 'On-Hold' || task.status == 'Pending')
				 		}">
				 	<td ng-cloak>{{task.assigned_by.firstName}} {{task.assigned_by.firstName}}</td>
				 	<td ng-cloak>{{task.task_title}}</td>
				 	<td ng-cloak>{{task.status}}</td>
				 	<td ng-cloak ng-class="{'alert-success': task.priority == 'Low', 
						'alert-warning': task.priority == 'Medium', 
						'alert-danger': task.priority == 'High'}">{{task.priority}}</td>
					<td ng-cloak>{{task.assigned_by.firstName}} {{task.assigned_by.lastName}}</td>
					<td ng-cloak>{{task.expected_start_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{task.expected_end_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{task.actual_start_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{task.actual_end_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editAllaskModal"
							ng-click="getTaskByTaskId(task.task_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="editTask.jsp"></jsp:include>
	</div>
</div>