<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addAttendanceBtn" data-toggle="modal" 
			data-target="#addAttendanceModal">
			<i class="fa fa-plus-circle"></i> Add Attendance
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="dtOptionsUserLead" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Date</th>
					<th>Project</th>
					<th>Task Type</th>
					<th>Status</th>
					<th>Time Spent (Hrs)</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="attendance in attendancesByEmpId">
					<td ng-cloak>{{attendance.date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{attendance.project.project_name}} </td>
					<td ng-cloak>{{attendance.task_type}}</td>
					<td ng-cloak>{{attendance.status}}</td>
					<td ng-cloak>{{attendance.time_spent}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editAttendanceModal"
							ng-click="getAttendanceByAttendanceId(attendance.attd_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteAttendanceModal" 
							ng-click="deleteAttendanceMain(attendance.attd_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addAttendance.jsp"></jsp:include>
		<jsp:include page="editAttendance.jsp"></jsp:include>
		<jsp:include page="deleteAttendance.jsp"></jsp:include>
	</div>
</div>