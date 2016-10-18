<div class="row">
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Year</th>
					<th>Status</th>
					<th>Task Completion</th>
					<th>Current Performance</th>
					<th>Total Score</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="hrAppraisal in hrAppraisals">
					<td ng-cloak>{{hrAppraisal.employee.firstName}} {{hrAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{hrAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{hrAppraisal.status}}</td>
					<td ng-cloak>{{hrAppraisal.score_task_completion}}</td>
					<td ng-cloak>{{hrAppraisal.score_current_performance}}</td>
					<td ng-cloak>{{hrAppraisal.total_score}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>