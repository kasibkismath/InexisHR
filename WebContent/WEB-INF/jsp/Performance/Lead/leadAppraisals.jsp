<div class="row">
	<div class="col-md-12">
		<span data-toggle="modal" data-target="#LeadAddAppraisal">
			<button class="btn btn-success pull-right addAppraisalBtn" title="Add Appraisal">
				<i class="fa fa-plus-circle"></i> Add New Appraisal
			</button>
		</span>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Team</th>
					<th>Year</th>
					<th>Status</th>
					<th>Total Score</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="leadAppraisal in leadAppraisalsByLeadId">
					<td ng-cloak>{{leadAppraisal.employee.firstName}} {{leadAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{leadAppraisal.team.team_name}}</td>
					<td ng-cloak>{{leadAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{leadAppraisal.status}}</td>
					<td ng-cloak>{{leadAppraisal.total_score}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" id="editLeadAppraisal" data-toggle="modal" 
							data-target="#editLeadAppraisalModal"
							ng-click="editAppraisalMain(leadAppraisal.lead_appraisal_id, leadAppraisal.employee.empId, leadAppraisal.performance.date)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" id="deleteLeadAppraisal" data-toggle="modal" 
							data-target="#deleteLeadAppraisalModal" 
							ng-click="deleteAppraisalMain(leadAppraisal.lead_appraisal_id, leadAppraisal.employee.empId, leadAppraisal.performance.date)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modals -->
		<jsp:include page="addLeadAppraisal.jsp"></jsp:include>
		<jsp:include page="editLeadAppraisal.jsp"></jsp:include>
		<jsp:include page="deleteLeadAppraisal.jsp"></jsp:include>
		<jsp:include page="scoresLeadAppraisal.jsp"></jsp:include>
	</div>
</div>