<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addLeaveBtn" data-toggle="modal" 
			data-target="#addLeaveModal">
			<i class="fa fa-plus-circle"></i> Add Leave
		</button>
	</div>
	<div class="col-sm-12">
		<table datatable="ng" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>From Date</th>
					<th>To Date</th>
					<th>No of Days</th>
					<th>Type of Leave</th>
					<th>Leave Option</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="hrAppraisal in hrAppraisals">
					<td ng-cloak>{{hrAppraisal.employee.firstName}} {{hrAppraisal.employee.lastName}}</td>
					<td ng-cloak>{{hrAppraisal.performance.date | date : 'yyyy'}} </td>
					<td ng-cloak>{{hrAppraisal.status}}</td>
					<td ng-cloak>{{hrAppraisal.total_score}}</td>
					<td ng-cloak>{{hrAppraisal.performance.final_score}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" id="editHRAppraisal" data-toggle="modal" 
							data-target="#editHRAppraisalModal"
							ng-click="editHRAppraisalMain(hrAppraisal.hr_appraisal_id, hrAppraisal.employee.empId, hrAppraisal.performance.date)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
						<button class="btn btn-danger" id="deleteHRAppraisal" data-toggle="modal" 
							data-target="#deleteHRAppraisalModal" 
							ng-click="deleteHRAppraisalMain(hrAppraisal.hr_appraisal_id, hrAppraisal.employee.empId, hrAppraisal.performance.date)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addLeave.jsp"></jsp:include>
	</div>
</div>