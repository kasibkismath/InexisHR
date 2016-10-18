<div class="row">
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Year</th>
					<th>Status</th>
					<th>Project</th>
					<th>Team</th>
					<th>Lead Name</th>
					<th>Skill Level</th>
					<th>Mentorship</th>
					<th>Task Completion</th>
					<th>Current Performance</th>
					<th>Total Score</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="leadAppraisal in leadAppraisals">
					<td ng-cloak>{{leadAppraisal.employee.firstName}} {{leadAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{leadAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{leadAppraisal.status}}</td>
					<td ng-cloak>{{leadAppraisal.team.project.project_name}}</td>
					<td ng-cloak>{{leadAppraisal.team.team_name}}</td>
					<td ng-cloak>{{leadAppraisal.team.employee.firstName}} {{leadAppraisal.team.employee.lastName}}</td>
					<td ng-cloak>{{leadAppraisal.score_skill}}</td>
					<td ng-cloak>{{leadAppraisal.score_mentorship}}</td>
					<td ng-cloak>{{leadAppraisal.score_task_completion}}</td>
					<td ng-cloak>{{leadAppraisal.score_current_performance}}</td>
					<td ng-cloak>{{leadAppraisal.total_score}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>