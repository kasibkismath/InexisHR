<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-sm-12 contracts-user-lead-table">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Document Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				 <tr ng-repeat="contract in myContracts">
				 	<td ng-cloak>{{contract.contractURL}}</td>
					<td ng-cloak>
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