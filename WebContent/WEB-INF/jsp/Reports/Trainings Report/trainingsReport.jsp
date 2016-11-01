<div class="row">
	<div class="col-sm-12">
		<jsp:include page="trainingsReportForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="trainingsReportOption" dt-column-defs=""
			dt-instance="" class="table table-hover" id="trainingTable">
			<thead>
				<tr>
					<th>Training Name</th>
					<th>Difficulty Level</th>
					<th>Type of Training</th>
					<th>Duration (In Days)</th>
					<th>Trained By</th>
					<th>Expected Start Date</th>
					<th>Expected End Date</th>
					<th>Cost (LKR)</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="training in generateTrainingsReportResult" ng-cloak>
					<td>{{training.name}}</td>
					<td>{{training.level_of_difficulty}}</td>
					<td>{{training.type_of_training}}</td>
					<td>{{training.duration}}</td>
					<td>{{training.trained_by}}</td>
					<td>{{training.expected_start_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{training.expected_end_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{training.cost}}</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="font-weight: bold;">Total Cost (LKR): {{getTotal()}}</td>
					<td></td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>