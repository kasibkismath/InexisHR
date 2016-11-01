<div class="row">
	<div class="col-sm-12">
		<jsp:include page="vacanciesReportForm.jsp"></jsp:include>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="vacanciesReportOption" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Vacancy Title</th>
					<th>Added Date</th>
					<th>Expiry Date</th>
					<th>Status</th>
					<th>Job Description</th>
					<th>Roles & Responsibilities</th>
					<th>Experience</th>
					<th>Qualification</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="vacancy in generateVacanciesReportResult" ng-cloak>
					<td>{{vacancy.vacancy_title}}</td>
					<td>{{vacancy.added_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{vacancy.expiry_date | date : 'yyyy-MM-dd'}}</td>
					<td>{{vacancy.status}}</td>
					<td>{{vacancy.job_desc}}</td>
					<td>{{vacancy.roles_responsibilities}}</td>
					<td>{{vacancy.experience}}</td>
					<td>{{vacancy.qualification}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>