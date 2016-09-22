<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addVacancyBtn" data-toggle="modal" 
			data-target="#addVacancyModal">
			<i class="fa fa-plus-circle"></i> Add Vacancy
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-options="vacancyTableOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Vacancy Title</th>
					<th>Status</th>
					<th>Added Date</th>
					<th>Expiry Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="vacancy in getVacanciesByYearResult"
				 ng-class="{'expired-vacancy' : vacancy.expiry_date < currentDate && vacancy.status == 'Pending'}">
				 	<td ng-cloak>{{vacancy.vacancy_title}}</td>
				 	<td ng-cloak ng-class="{'alert-warning': vacancy.status == 'Pending',
					'alert-success': vacancy.status == 'Completed',
					'alert-danger': vacancy.status == 'Terminated'}">
					{{vacancy.status}}</td>
					<td ng-cloak>{{vacancy.added_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>{{vacancy.expiry_date | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#editVacancyModal"
							ng-click="getVacancyByVacancyId(vacancy.vacancy_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteVacancyModal" 
							ng-click="deleteVacancyMain(vacancy.vacancy_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addVacancy.jsp"></jsp:include>
		<jsp:include page="editVacancy.jsp"></jsp:include>
		<jsp:include page="deleteVacancy.jsp"></jsp:include>
	</div>
</div>