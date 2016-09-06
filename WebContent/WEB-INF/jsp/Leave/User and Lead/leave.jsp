<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addLeaveBtn" data-toggle="modal" 
			data-target="#addLeaveModal">
			<i class="fa fa-plus-circle"></i> Apply Leave
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="dtOptionsUser" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>From Date</th>
					<th>Reporting Back Date</th>
					<th>No of Days</th>
					<th>Type of Leave</th>
					<th>Leave Option</th>
					<th>Status</th>
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
					<td ng-cloak>{{leave.status}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editLeaveModal"
							ng-click="getLeaveByLeaveId(leave.leave_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteLeaveModal" 
							ng-click="deleteLeaveMain(leave.leave_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addLeave.jsp"></jsp:include>
		<jsp:include page="editLeave.jsp"></jsp:include>
	</div>
</div>