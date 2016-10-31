<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-sm-12 contracts-ceo-table">
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
						<button class="btn btn-default"
							ng-click="viewContract(contract.contractURL)">
							<i class="fa fa-eye fa-lg"></i>
						</button>
						<button class="btn btn-primary"
							ng-click="downloadContract(contract.contractURL)">
							<i class="fa fa-download fa-lg"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>