<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewProjectBtn" data-toggle="modal" 
			data-target="#addNewProjectModal">
			<i class="fa fa-plus-circle"></i> Add New Project
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Project Name</th>
					<th>Status</th>
					<th>Start Date</th>
					<th>Client Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="project in allProjects">
				 	<td ng-cloak>{{project.project_name}}</td>
				 	<td ng-cloak>{{project.status}}</td>
					<td ng-cloak>{{project.project_start | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{project.project_client}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editProjectModal"
							ng-click="getProjectByProjectId(project.project_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteProjectModal" 
							ng-click="deleteProjectMain(project.project_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addProject.jsp"></jsp:include>
		<jsp:include page="editProject.jsp"></jsp:include>
		<jsp:include page="deleteProject.jsp"></jsp:include>
	</div>
</div>