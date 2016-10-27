<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-sm-12 empHistoryTable">
		<table datatable="ng" dt-options="empHistoryTableOptions" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Designation</th>
					<th>Salary</th>
					<th>Added Date</th>
					<th>Effective Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="empHistory in empHistories">
				 	<td ng-cloak>{{empHistory.employee.firstName}} {{empHistory.employee.lastName}}</td>
				 	<td ng-cloak>{{empHistory.designation.name}}</td>
				 	<td ng-cloak>{{empHistory.salary}}</td>
				 	<td ng-cloak>{{empHistory.addedDate | date : 'yyyy-MM-dd'}}</td>
				 	<td ng-cloak>{{empHistory.effectiveDate | date : 'yyyy-MM-dd'}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" data-toggle="modal" 
							data-target="#updateEmpHistoryModal"
							ng-click="getEmpHistoryById(empHistory.emp_history_id)">
							<i class="fa fa-pencil fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="editEmpHistory.jsp"></jsp:include>
	</div>
</div>