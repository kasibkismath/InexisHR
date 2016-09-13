<div class="row">
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Year</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="hrAppraisal in hrAppraisals">
					<td ng-cloak>{{hrAppraisal.employee.firstName}} {{hrAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{hrAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{hrAppraisal.status}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>