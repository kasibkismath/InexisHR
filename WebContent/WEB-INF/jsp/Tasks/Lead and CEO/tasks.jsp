<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addTaskBtn" data-toggle="modal" 
			data-target="#addAttendanceModal">
			<i class="fa fa-plus-circle"></i> Add Task
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="dtOptionsUserLead" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee</th>
					<th>Task Title</th>
					<th>Expected Start Date</th>
					<th>Expected Finish Date</th>
					<th>Actual Start Date</th>
					<th>Actual Finish Date</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="task in attendancesByEmpId">
					<td ng-cloak>{{task.date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{task.project.project_name}} </td>
					<td ng-cloak>{{task.task_type}}</td>
					<td ng-cloak>{{task.status}}</td>
					<td ng-cloak>{{task.time_spent}}</td>
					<th ng-cloak>{{task.assigned_by}}</th>
					<th ng-cloak>{{task.assigned_by}}</th>
					<th ng-cloak>{{task.assigned_by}}</th>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editTaskModal"
							ng-click="getTaskByTaskId(task.task_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteTaskModal" 
							ng-click="deleteTaskMain(task.task_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addTask.jsp"></jsp:include>
		<%-- <jsp:include page="editTask.jsp"></jsp:include>
		<jsp:include page="deleteTask.jsp"></jsp:include> --%>
	</div>
</div>