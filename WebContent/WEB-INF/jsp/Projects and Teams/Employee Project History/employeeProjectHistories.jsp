<div class="row">
	<div class="col-sm-12 empProjectTable">
		<table datatable="ng" dt-options="empProjectTableOption" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee</th>
					<th>Project</th>
					<th>Team</th>
					<th>From Date</th>
					<th>To Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="empProjectHistory in allEmpProjectHistories">
				 	<td ng-cloak>{{empProjectHistory.employee.firstName}} {{empProjectHistory.employee.lastName}}</td>
				 	<td ng-cloak>{{empProjectHistory.team.project.project_name}}</td>
				 	<td ng-cloak>{{empProjectHistory.team.team_name}}</td>
				 	<td ng-cloak>{{empProjectHistory.fromDate | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empProjectHistory.toDate | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editEmpProjectHistoryModal"
							ng-click="getEmpProjectById(empProjectHistory.emp_proj_history_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteEmpProjectHistoryModal"
							ng-click="deleteEmpHistoryMain(empProjectHistory.emp_proj_history_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="editEmployeeProjectHistory.jsp"></jsp:include>
		<jsp:include page="deleteEmployeeProjectHistory.jsp"></jsp:include>
	</div>
</div>