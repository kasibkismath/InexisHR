<div class="row">
	<div class="col-md-12">
		<button class="btn btn-success pull-right addAppraisalBtn" data-toggle="modal" data-target="#LeadAddAppraisal">
			<i class="fa fa-plus-circle"></i> Add New Appraisal
		</button>
	</div>
	<div class="col-sm-12 tpad-table">
		<table datatable="ng" dt-options="dtOptions" dt-column-defs="dtColumnDefs"
			class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Team</th>
					<th>Year</th>
					<th>Status</th>
					<th>Actions</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="leadAppraisal in leadAppraisalsByLeadId">
					<td ng-cloak>{{leadAppraisal.employee.firstName}} {{leadAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{leadAppraisal.team.team_name}}</td>
					<td ng-cloak>{{leadAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{leadAppraisal.status}}</td>
					<td ng-cloak><button class="btn btn-primary" id="editLeadAppraisal" data-toggle="modal" data-target="#editLeadAppraisalModal" ng-click="editAppraisalMain(leadAppraisal.lead_appraisal_id)"><i class="fa fa-pencil fa-lg"></i></button></td>
					<td ng-cloak><button class="btn btn-danger" id="deleteLeadAppraisal" data-toggle="modal" data-target="#deleteLeadAppraisalModal" ng-click="deleteAppraisalMain(leadAppraisal.lead_appraisal_id)"><i class="fa fa-trash fa-lg"></i></button></td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<!-- Modals -->
	</div>
	<jsp:include page="addLeadAppraisal.jsp"></jsp:include>
</div>