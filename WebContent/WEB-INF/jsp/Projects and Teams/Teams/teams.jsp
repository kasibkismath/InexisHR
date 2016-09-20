<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewTeamBtn" data-toggle="modal" 
			data-target="#addNewTeamModal">
			<i class="fa fa-plus-circle"></i> Add New Team
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Team Name</th>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="team in allTeams">
				 	<td ng-cloak>{{team.team_name}}</td>
				 	<td ng-cloak>{{team.project.project_name}}</td>
					<td ng-cloak>{{team.employee.firstName}} {{team.employee.lastName}}</td>
					<td ng-cloak>{{team.status}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editTeamModal"
							ng-click="getTeamByTeamId(team.team_Id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteTeamModal" 
							ng-click="deleteTeamMain(team.team_Id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addTeam.jsp"></jsp:include>
		<jsp:include page="editTeam.jsp"></jsp:include>
		<jsp:include page="deleteTeam.jsp"></jsp:include>
	</div>
</div>