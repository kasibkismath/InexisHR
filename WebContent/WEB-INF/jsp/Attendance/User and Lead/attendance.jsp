<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addAttendanceBtn" data-toggle="modal" 
			data-target="#addAttendanceModal">
			<i class="fa fa-plus-circle"></i> Add Attendance
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="dtOptionsUser" dt-column-defs=""
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
				 <tr ng-repeat="leave in leavesForLoggedInEmployee">
					<td ng-cloak>{{leave.leave_from | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{leave.leave_to | date : 'yyyy-MM-dd'}} </td>
					<td ng-cloak>{{leave.no_days == 0.5 ? leave.no_days * 2 : leave.no_days}}</td>
					<td ng-cloak>{{leave.leaveType.name}}</td>
					<td ng-cloak>{{leave.leave_option}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editLeaveModal"
							ng-click="getLeaveByLeaveId(leave.leave_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteLeaveModal" 
							ng-click="deleteLeaveMain(leave.leave_id, leave.leaveType.name, 
							leave.leave_from, leave.leave_to, leave.leave_option, leave.reason)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addAttendance.jsp"></jsp:include>
	</div>
</div>