<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addVacancyBtn" data-toggle="modal" 
			data-target="#addApplicantModal">
			<i class="fa fa-plus-circle"></i> Add Applicant
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="applicantTableOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Applicant Name</th>
					<th>Applied Vacancy</th>
					<th>Applied Date</th>
					<th>Status</th>
					<th>Exam Result</th>
					<th>Interview Result</th>
					<th>Referred By</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="applicant in getApplicantsByCurrentYearResult">
				 	<td ng-cloak>{{applicant.firstName}} {{applicant.lastName}}</td>
					<td ng-cloak>{{applicant.vacancy.vacancy_title}}</td>
					<td ng-cloak>{{applicant.applied_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{applicant.status}}</td>
					<td ng-cloak>{{applicant.exam_result}}</td>
					<td ng-cloak>{{applicant.interview_result}}</td>
					<td ng-cloak>{{applicant.referred_by}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editApplicantModal"
							ng-click="getApplicantByApplicantId(applicant.applicant_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteApplicantModal" 
							ng-click="deleteApplicantMain(applicant.applicant_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addApplicant.jsp"></jsp:include>
	</div>
</div>