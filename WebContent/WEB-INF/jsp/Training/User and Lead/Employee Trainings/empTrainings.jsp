<div class="row">
	<div class="col-sm-12">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Training Name</th>
					<th>Difficulty Level</th>
					<th>Type of Training</th>
					<th>Status</th>
					<th>Duration (In Days)</th>
					<th>Expected Start</th>
					<th>Expected End</th>
					<th>Actual Start</th>
					<th>Actual End</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="empTraining in myEmpTrainings">
				 	<td ng-cloak>{{empTraining.training.name}}</td>
				 	<td ng-cloak>{{empTraining.training.level_of_difficulty}}</td>
				 	<td ng-cloak>{{empTraining.training.type_of_training}}</td>
				 	<td ng-cloak>{{empTraining.status}}</td>
				 	<td ng-cloak>{{empTraining.training.duration}}</td>
				 	<td ng-cloak>{{empTraining.training.expected_start_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.training.expected_end_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.actual_start_date | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empTraining.actual_end_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#updateEmpTrainingModalUser"
							ng-click="getEmpTrainingByEmpTrainingId(empTraining.emp_training_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="editEmpTraining.jsp"></jsp:include>
	</div>
</div>