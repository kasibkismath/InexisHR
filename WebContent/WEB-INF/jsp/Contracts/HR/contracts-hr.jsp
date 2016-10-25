<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-sm-12">
		<button class="btn btn-success pull-right addNewContractBtn" data-toggle="modal" 
			data-target="#addContractModal">
			<i class="fa fa-plus-circle"></i> Add Contract
		</button>
	</div>
	<div class="col-sm-12">
	
		<!-- More codes above -->
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Employee Name</th>
					<th>Document Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="contract in contracts">
				 	<td ng-cloak>{{contract.employee.firstName}} {{contract.employee.lastName}}</td>
				 	<td ng-cloak>{{contract.contractURL}}</td>
					<td ng-cloak>
						<a class="btn btn-primary" data-toggle="modal" 
							href="<c:url value='/Contracts/DownloadContract?fileName={{contract.contractURL}}'/>">
							<i class="fa fa-download fa-lg"></i>
						</a>
						<button class="btn btn-danger" data-toggle="modal" 
							data-target="#deleteEmpTrainingModal" 
							ng-click="deleteEmpTrainingMain(empTraining.emp_training_id)">
							<i class="fa fa-trash fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modal -->
		<jsp:include page="addContract.jsp"></jsp:include>
		<jsp:include page="deleteContract.jsp"></jsp:include>
	</div>
</div>