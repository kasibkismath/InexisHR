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
					<th>Duration (In Days)</th>
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
				 <tr ng-repeat="training in allTrainings" 
				 ng-class="{'training-full': {{training[11]}} == 0 && training[9] > currentDate}">
				 	<td ng-cloak>{{training[1]}}</td>
				 	<td ng-cloak>{{training[2]}}</td>
				 	<td ng-cloak>{{training[4]}}</td>
				 	<td ng-cloak>{{training[5]}}</td>
				 	<td ng-cloak>{{training[6]}}</td>
				 	<td ng-cloak>{{training[7]}}</td>
				 	<td ng-cloak>{{training[11]}}</td>
				 	<td ng-cloak>{{training[8]}}</td>
					<td ng-cloak>{{training[9]}}</td>
					<td ng-cloak>{{training[10]}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editTrainingModal"
							ng-click="getTrainingByTrainingId(training[0])">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteTrainingModal" 
							ng-click="deleteTrainingMain(training[0])">
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