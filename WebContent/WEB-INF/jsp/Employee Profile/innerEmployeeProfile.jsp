		<div id="profileHead">
		<div class="row">
			<div class="col-sm-3 employeeSearchBox">
					<div class="input-group">
						<span class="input-group-addon" id="searchBoxGlyp"><i
							class="fa fa-search fa-lg"></i></span> <input type="text"
							class="form-control" ng-model="q" placeholder="Search" id="searchBox">
					</div>
			</div>
			<div class="col-sm-offset-7 col-sm-2" id="addNewEmpBtn"> <button class="btn btn-success" data-toggle="modal" data-target="#addNewEmpModal"><i class="fa fa-plus-circle fa-lg"></i> Add New Employee</button></div>
		</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				
			</div>
			<!-- <div class="col-sm-2 col-sm-offset-7" id="noOfItems">
				<div class="input-group">
					<span class="input-group-addon" id="showListGlyp">No of Items</span> <input type="number" min="10"
						max="100" class="form-control" ng-model="pageSize" id="showListBox">
				</div>
			</div> -->
		</div>
		<!-- List Group Start -->
		<ul class="list-group tpad">
			<!-- List Group Item Start -->
			<li class="list-group-item colored customList col-md-offset-2 col-md-2"
				dir-paginate="employee in count = (employees | filter:q ) | itemsPerPage: pageSize">
				<div class="row">
					<br>
					<div class="col-md-3 col-sm-3 text-center">
						<a href="#"><img alt=""
							ng-src="${pageContext.request.contextPath}/static/images/EmpProfileImages/{{employee.imageURL}}"
							class="img-circle employee-image"></a>
					</div>
					<div class="col-md-9 col-sm-9">
						<div class="">
							<div class="">
								<h3 class="empName" id="empNameId" ng-cloak>{{employee.firstName}}
									{{employee.lastName}}</h3>
								<h4 class="designationText">
									<small ng-cloak>{{employee.designation.name}}</small>
								</h4>
								<h4> 
									<span class="label label-success" ng-show="employee.status === true"> Status: Enabled</span>
									<span class="label label-warning" ng-show="employee.status === false"> Status: Disabled</span>
								</h4>
								<h5>
									<small class="text-muted"><a href="${pageContext.request.contextPath}/employeeProfile/employee/getById?EmpID={{employee.empId}}"
										class="btn btn-info" ng-cloak><i class="fa fa-pencil"></i></a></small>
										<small class="text-muted"><a href=""
										class="btn btn-danger" data-toggle="modal" data-target="#empDeleteModal" ng-cloak ng-click="deleteEmployee(employee.empId)"><i class="fa fa-trash"></i></a></small>
										<small class="text-muted" ng-if="employee.status === false"><a href=""
										class="btn btn-success" data-toggle="modal" data-target="#empDisableModal" ng-cloak ng-click="disableEmpMain(employee.empId)"><i class="fa fa-ban"></i></a></small>
										<small class="text-muted" ng-if="employee.status === true"><a href=""
										class="btn btn-warning" data-toggle="modal" data-target="#empDisableModal" ng-cloak ng-click="disableEmpMain(employee.empId)"><i class="fa fa-ban"></i></a></small>
								</h5>
							</div>
						</div>
					</div>
				</div>
				<hr>
			</li>
		</ul>
		<div class="text-center">
	          <dir-pagination-controls id="employeeDirPagination" boundary-links="true" template-url="${pageContext.request.contextPath}/static/js/General/dirPagination.tpl.html"></dir-pagination-controls>
	    </div>
		<jsp:include page="addNewEmpModal.jsp"></jsp:include>
		<jsp:include page="employeeDeleteModal.jsp"></jsp:include>
		<jsp:include page="employeeDisableModal.jsp"></jsp:include>
		<div ng-hide="count.length" class="alert alert-warning padded">
			<span class=""><strong>Warning!</strong> Cannot find the employee.</span>
		</div>