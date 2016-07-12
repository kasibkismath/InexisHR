<div class="row">
	<div class="col-sm-12 tpad">
		<span><h3><i class="fa fa-check-circle fa-lg"></i> Designations</h3></span>
	</div>
	<div class="col-sm-12 tpad-table">
		<table datatable="" dt-options="dtOptions" dt-columns="dtColumns"
			class="table table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>Designation</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td ng-cloak>1</td>
					<td ng-cloak>Technical Support</td>
					<td ng-cloak><button class="btn btn-primary" id="editDesig" data-toggle="modal" data-target="#editDesigModal" ng-click="editDesigMain(designation.id)"><i class="fa fa-pencil fa-lg"></i> Edit</button></td>
					<td ng-cloak><button class="btn btn-danger" id="deleteDesig" data-toggle="modal" data-target="#deleteDesigModal" ng-click="deleteDesigMain(designation.id)"><i class="fa fa-trash fa-lg"></i> Delete</button></td>							
				</tr>
			</tbody>
		</table>
	</div>
</div>