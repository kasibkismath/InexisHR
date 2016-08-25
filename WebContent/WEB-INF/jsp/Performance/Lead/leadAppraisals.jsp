<div class="row">
	<div class="col-md-12">
		<button class="btn btn-success pull-right addAppraisalBtn" data-toggle="modal" data-target="#LeadAddAppraisal">
			<i class="fa fa-plus-circle"></i> Add New Appraisal
		</button>
	</div>
	<div class="col-sm-12 tpad-table">
		<table datatable="" dt-options="dtOptions" dt-columns="dtColumns"
			class="table table-hover">
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Team</th>
					<th>Year</th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="designations in designation">
					<td ng-cloak>{{designation.designationId}}</td>
					<td ng-cloak>{{designation.name}}</td>
					<td ng-cloak><button class="btn btn-primary" id="editAppraisal" data-toggle="modal" data-target="#editAppraisalModal" ng-click="editAppraisalMain(designation.id)"><i class="fa fa-pencil fa-lg"></i> Edit</button></td>
					<td ng-cloak><button class="btn btn-danger" id="deleteAppraisal" data-toggle="modal" data-target="#deleteAppraisalModal" ng-click="deleteAppraisalMain(designation.id)"><i class="fa fa-trash fa-lg"></i> Delete</button></td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<!-- Modals -->
	</div>
	<jsp:include page="addLeadAppraisal.jsp"></jsp:include>
</div>