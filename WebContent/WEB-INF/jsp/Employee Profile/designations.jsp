<div class="row">
	<div class="col-sm-12 addDesigBtn">
		<button class="btn btn-success pull-right" data-toggle="modal" data-target="#addDesigModal">
			<i class="fa fa-plus-circle fa-lg"></i> Add Designation
		</button>
	</div>
	<div class="col-sm-12 tpad-table">
		<table datatable="ng" dt-options="" dt-column-defs=""
			class="table table-hover">
			<thead>
				<tr>
					<th>Designation</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="designation in designations">
					<td ng-cloak>{{designation.name}}</td>
					<td ng-cloak>
						<button class="btn btn-primary" id="editDesig" data-toggle="modal" data-target="#editDesigModal" ng-click="editDesigMain(designation.designationId)"><i class="fa fa-pencil fa-lg"></i></button>
						<button class="btn btn-danger" id="deleteDesig" data-toggle="modal" data-target="#deleteDesigModal" ng-click="deleteDesigMain(designation.designationId)"><i class="fa fa-trash fa-lg"></i></button>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Modals -->
		<jsp:include page="editDesigModal.jsp"></jsp:include>
		<jsp:include page="deleteDesigModal.jsp"></jsp:include>
		<jsp:include page="addDesigModal.jsp"></jsp:include>
	</div>
</div>