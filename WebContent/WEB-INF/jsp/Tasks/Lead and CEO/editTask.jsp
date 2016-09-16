<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="modal fade" tabindex="-1" role="dialog" id="editTaskModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Task</h4>
      </div>
      <div class="modal-body">
		<form name="addTaskForm" class="form-horizontal"
			ng-submit="addTaskForm.$valid && checkForExpectedStartEndDateResult === false && 
				checkDuplicateTaskResult === false && 
				addTask(saveTaskEmployee, saveTaskTitle, saveTaskDesc, saveTaskPriority, 
				saveExpStartDate, saveExpEndDate)">
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.employee.$error.required 
						&& addTaskForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveTaskEmployee" name="employee" class="form-control"
						required
						ng-change="checkDuplicateTask(saveTaskEmployee, saveTaskTitle)">
						<option value="">Select an Employee</option>
						<sec:authorize access="hasRole('ROLE_LEAD')">
						<option ng-repeat="empByLead in employeesByLeadId" 
							value="{{empByLead.empId}}">
							{{empByLead.firstName}} {{empByLead.lastName}}
						</option>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_CEO')">
						<option ng-repeat="emp in allEmployees" 
							value="{{emp.empId}}" ng-show="emp.empId != loggedInEmpId">
							{{emp.firstName}} {{emp.lastName}}
						</option>
						</sec:authorize>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.taskTitle.$error.required 
						&& addTaskForm.taskTitle.$dirty">
					<strong>Error!</strong> Task Title is Required
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.taskTitle.$error.maxlength
						&& addTaskForm.taskTitle.$dirty">
					<strong>Error!</strong> Task Title should be less than 101 characters
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.taskTitle.$error.minlength
						&& addTaskForm.taskTitle.$dirty">
					<strong>Error!</strong> Task Title should be more than 5 characters
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkDuplicateTaskResult === true">
					<strong>Error!</strong> Task already exists for this employee and task title
				</div>
				<label class="col-sm-2 control-label">Task Title</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" placeholder="Task Title"
						name="taskTitle" ng-model="saveTaskTitle" required
						ng-maxlength="100" ng-minlength="5"
						ng-change="checkDuplicateTask(saveTaskEmployee, saveTaskTitle)">
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="addTaskForm.taskDesc.$error" role="alert" 
					ng-if="addTaskForm.taskDesc.$dirty">
					<div ng-message="maxlength" class="alert alert-danger padded">
						<strong>Error!</strong> Task Description should be not more than 1000 characters
					</div>
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.taskDesc.$error.required" 
					ng-if="addTaskForm.taskDesc.$dirty">
					<strong>Error!</strong> Task Description is required.
				</div>
				<label class="col-sm-2 control-label">Task Description</label>
				<div class="col-sm-10">
					<textarea rows="5" class="form-control" name="taskDesc" 
						placeholder="Tasks Description" ng-model="saveTaskDesc" ng-maxlength="1000" 
						required char-count warning-count="100" danger-count="50"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.priority.$error.required 
						&& addTaskForm.priority.$dirty">
					<strong>Error!</strong> Priority is required, please select one.
				</div>
				<label class="col-sm-2 control-label">Priority</label>
				<div class="col-sm-10">
					<select ng-model="saveTaskPriority" name="priority" class="form-control"
						required>
						<option value="">Select a Priority Level</option>
						<option value="Low">Low</option>
						<option value="Medium">Medium</option>
						<option value="High">High</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.expStartDate.$error.required 
						&& addTaskForm.expStartDate.$dirty">
					<strong>Error!</strong> Expected Start Date is required.
				</div>
				<label class="col-sm-2 control-label">Expected Start Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
						date-min-limit="{{ExpStartDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveExpStartDate" class="form-control" 
							placeholder="Choose a date" name="expStartDate" required
							ng-change="checkForExpectedStartEndDate(saveExpStartDate, saveExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addTaskForm.expEndDate.$error.required 
						&& addTaskForm.expEndDate.$dirty">
					<strong>Error!</strong> Expected End Date is required.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-show="checkForExpectedStartEndDateResult === true">
					<strong>Error!</strong> Expected End Date is cannot be less than Expected Start Date.
				</div>
				<label class="col-sm-2 control-label">Expected End Date</label>
				<div class="col-sm-10">
					<datepicker date-format="yyyy-MM-dd" selector="form-control"
					date-min-limit="{{ExpStartDate | date:'yyyy-MM-dd'}}">
						<div class="input-group">
							<input ng-model="saveExpEndDate" class="form-control" 
							placeholder="Choose a date" name="expEndDate" required
							ng-disabled="addTaskForm.expStartDate.$pristine"
							ng-change="checkForExpectedStartEndDate(saveExpStartDate, saveExpEndDate)">
							<span class="input-group-addon" style="cursor: pointer">
								<i class="fa fa-lg fa-calendar"></i>
							</span>
						</div>
					</datepicker>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>