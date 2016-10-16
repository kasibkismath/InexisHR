<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewTrainingBtn" data-toggle="modal" 
			data-target="#addNewTrainingModal">
			<i class="fa fa-plus-circle"></i> Add New Training
		</button>
	</div>
	<div class="col-sm-12">
	
		<!-- More codes above -->
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Difficulty Level</th>
					<th>Type</th>
					<th>Trained By</th>
					<th>Max Candidates</th>
					<th>Available Slots</th>
					<th>Cost</th>
					<th>Expected Start</th>
					<th>Expected End</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="training in allTrainings">
				 	<td ng-cloak>{{training.name}}</td>
				 	<td ng-cloak>{{training.level_of_difficulty}}</td>
				 	<td ng-cloak>{{training.type_of_training}}</td>
				 	<td ng-cloak>{{training.trained_by}}</td>
				 	<td ng-cloak>{{training.max_candidates}}</td>
				 	<td ng-cloak>{{training.max_candidates}}</td>
				 	<td ng-cloak>{{training.cost}}</td>
					<td ng-cloak>{{training.expected_start_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{training.expected_end_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editTrainingModal"
							ng-click="getTrainingByTrainingId(training.training_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteTrainingModal" 
							ng-click="deleteTrainingMain(training.training_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- More codes below -->
		<!-- Modal -->
		<jsp:include page="addTraining.jsp"></jsp:include>
		<jsp:include page="editTraining.jsp"></jsp:include>
		<jsp:include page="deleteTraining.jsp"></jsp:include>
	</div>
</div>