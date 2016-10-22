<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewTrainingBtn" data-toggle="modal" 
			data-target="#addNewEmpTrainingModal">
			<i class="fa fa-plus-circle"></i> Add Employee Training
		</button>
	</div>
	<div class="col-sm-12">
	
		<!-- More codes above -->
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Training Name</th>
					<th>Difficulty Level</th>
					<th>Type of Training</th>
					<th>Status</th>
					<th>Expected Start</th>
					<th>Expected End</th>
					<th>Actual Start</th>
					<th>Actual End</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="empTraining in allEmpTrainings">
				 	<td ng-cloak>{{empTraining.employee.firstName}} {{empTraining.employee.lastName}}</td>
				 	<td ng-cloak>{{empTraining.training.name}}</td>
				 	<td ng-cloak>{{empTraining.training.level_of_difficulty}}</td>
				 	<td ng-cloak>{{empTraining.training.type_of_training}}</td>
				 	<td ng-cloak>{{empTraining.status}}</td>
				 	<td ng-cloak>{{empTraining.training.expected_start_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.training.expected_end_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.actual_start_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.actual_end_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#updateEmpTrainingModal"
							ng-click="getEmpTrainingByEmpTrainingId(empTraining.emp_training_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteEmpTrainingModal" 
							ng-click="deleteEmpTrainingMain(empTraining.emp_training_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addEmpTraining.jsp"></jsp:include>
		<jsp:include page="editEmpTraining.jsp"></jsp:include>
		<jsp:include page="deleteEmpTraining.jsp"></jsp:include>
	</div>
</div>