<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewTeamBtn" data-toggle="modal" 
			data-target="#addTeamMemberModal">
			<i class="fa fa-plus-circle"></i> Add Team Member
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee</th>
					<th>Project</th>
					<th>Team</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="teamMember in allTeamMembers">
				 	<td ng-cloak>{{teamMember.employee.firstName}} {{teamMember.employee.lastName}}</td>
				 	<td ng-cloak>{{teamMember.team.project.project_name}}</td>
				 	<td ng-cloak>{{teamMember.team.team_name}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editTeamMemberModal"
							ng-click="getTeamMemberByTeamMemberId(teamMember.team_emp_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteTeamMemberModal" 
							ng-click="deleteTeamMemberMain(teamMember.team_emp_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addTeamMember.jsp"></jsp:include>
		<jsp:include page="editTeamMember.jsp"></jsp:include>
		<jsp:include page="deleteTeamMember.jsp"></jsp:include>
	</div>
</div>