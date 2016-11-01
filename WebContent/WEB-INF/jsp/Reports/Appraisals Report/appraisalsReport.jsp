<div class="row">
	<div class="col-sm-12">
		<jsp:include page="appraisalsReportForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="appraisalsReportOption" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Year</th>
					<th>Status</th>
					<th>Final Score</th>
					<th>CEO's Remarks</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="appraisal in generateAppraisalsReportResult" ng-cloak>
					<td>{{appraisal[0]}} {{appraisal[1]}}</td>
					<td>{{appraisal[2] | date : 'yyyy'}}</td>
					<td>{{appraisal[3]}}</td>
					<td>{{appraisal[4]}}</td>
					<td>{{appraisal[5]}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>