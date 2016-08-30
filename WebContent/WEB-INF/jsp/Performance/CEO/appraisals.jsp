<div class="row">
	<div class="col-md-12">
		<button class="btn btn-success pull-right addAppraisalBtn" data-toggle="modal" data-target="#CEOAddAppraisal">
			<i class="fa fa-plus-circle"></i> Add New Appraisal
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
				class="table table-hover">
				<thead>
					<tr>
						<th>Name</th>
						<th>Year</th>
						<th>Status</th>
						<th>Total Score</th>
						<th>Final Status</th>
						<th>Final Score</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					 <tr ng-repeat="ceoAppraisal in ceoAppraisals">
						<td ng-cloak>{{ceoAppraisal.employee.firstName}} {{ceoAppraisal.employee.lastName}}</td>
						<td ng-cloak>{{ceoAppraisal.performance.date | date : 'yyyy'}} </td>
						<td ng-cloak>{{ceoAppraisal.status}}</td>
						<td ng-cloak>{{ceoAppraisal.total_score}}</td>
						<td ng-cloak>{{ceoAppraisal.performance.status}}</td>
						<td ng-cloak>{{ceoAppraisal.performance.final_score}}</td>
						<td ng-cloak>
							<button class="btn btn-primary" id="editCEOAppraisal" data-toggle="modal" 
								data-target="#editCEOAppraisalModal"
								ng-click="editCEOAppraisalMain(ceoAppraisal.ceo_appraisal_id)">
								<i class="fa fa-pencil fa-lg"></i>
							</button>
							<button class="btn btn-danger" id="deleteCEOAppraisal" data-toggle="modal" 
								data-target="#deleteCEOAppraisalModal" 
								ng-click="deleteCEOAppraisalMain(ceoAppraisal.ceo_appraisal_id, ceoAppraisal.employee.empId, ceoAppraisal.performance.date)">
								<i class="fa fa-trash fa-lg"></i>
							</button>
						</td>
					</tr>
				</tbody>
			</table>
		<!-- Modals -->
		<jsp:include page="addAppraisal.jsp"></jsp:include>
		<jsp:include page="editCEOAppraisal.jsp"></jsp:include>
	</div>
</div>