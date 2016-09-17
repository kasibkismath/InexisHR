var tasks = angular.module('tasks', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

tasks.controller('tasksMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;
	
	// user variables
	
	// expected start date
	var myExpStartDate = new Date();
	myExpStartDate.setDate(myExpStartDate.getDate() - 1);
	$scope.ExpStartDate = myExpStartDate;
	
	//current date
	$scope.currentDate = new Date();
	
	$scope.init = function(){
		// variables
		$scope.checkForExpectedStartEndDateResult = false;
		$scope.checkDuplicateTaskResult = false;
		
		// functions
		$scope.getEmployeesByLeadId();
		$scope.getAllEmployees();
		$scope.getAssignedTasksByLeadId();
		
		// set datatable configs
		 // user and lead datatable
		$scope.dtOptionsLeadCEO = DTOptionsBuilder.newOptions()
	    .withOption('order', [4, 'desc']);
	};
	
	// get logged in emp
	$scope.getLoggedInEmployee = function() {
		var def = $q.defer();
		
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/administration/user/currentUser', user)
		.success(function(result) {
			def.resolve(result.employee);
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
	};
	
	// get all active employees by lead id
	$scope.getEmployeesByLeadId = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var empId = emp.empId;
			
			var team = {
				employee : {empId : empId}
			};
			
			$http.post($scope.baseURL + '/Tasks/GetEmployeesByLeadId', team)
			.success(function(result) {
				$scope.employeesByLeadId = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
			
		});
	};
	
	// get all active employees
	$scope.getAllEmployees = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var empId = emp.empId;
			
			var emp = {
				empId : empId
			};
			
			$http.post($scope.baseURL + '/Tasks/GetAllEmployees', emp)
			.success(function(result) {
				$scope.allEmployees = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// check if expected end date is less than expected start date
	$scope.checkForExpectedStartEndDate = function(startDate, endDate) {
		if(endDate < startDate)
			$scope.checkForExpectedStartEndDateResult = true;
		else 
			$scope.checkForExpectedStartEndDateResult = false;
	};
	
	$scope.checkDuplicateTask = function(taskEmp, task_title) {
		
		if(taskEmp != undefined && task_title != undefined) {
			
			var task = {
				employee : {empId : taskEmp},
				task_title : task_title,
			};
			
			// check if task_title with taskEmp exists
			$http.post($scope.baseURL + '/Tasks/CheckDuplicateTask', task)
			.success(function(result) {
				$scope.checkDuplicateTaskResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	
	// get assigned tasks by lead_id
	$scope.getAssignedTasksByLeadId = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by},
			};
			
			$http.post($scope.baseURL + '/Tasks/GetAssignedTasksByLeadId', task)
			.success(function(result) {
				$scope.getAssignedTasksResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// add new task for an employee
	$scope.addTask = function(taskEmp, task_title, task_desc, priority, expStartDate, expEndDate) {
		
		// set new task status
		var status = "Pending";
		
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			// get current logged in empId as assigned employee empId
			var assigned_empId = emp.empId;
			
			// construct task object
			var task = {
				employee : {empId : taskEmp},
				assigned_by : {empId : assigned_empId},
				task_title : task_title,
				task_desc : task_desc,
				expected_start_date : expStartDate,
				expected_end_date : expEndDate,
				status : status,
				priority : priority
			};
			
			// send add task request
			$http.post($scope.baseURL + '/Tasks/AddTask', task)
			.success(function(result) {
				$('#addTaskModal').modal('hide');
				toaster.pop('success', "Notification", "Task Added Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 1000);
			})
			.error(function(data, status) {
				$('#addTaskModal').modal('hide');
				toaster.pop('error', "Notification", "Adding Task Failed");
				console.log(data);
			});
		});
	};
	
	// get task info by task_id
	$scope.getTaskByTaskId = function(task_id) {
		
		var task = {
			task_id : task_id
		};
		
		$http.post($scope.baseURL + '/Tasks/GetTaskByTaskId', task)
		.success(function(result) {
			$scope.updateTaskEmployee = result.employee.empId;
			$scope.updateTaskTitle = result.task_title;
			$scope.updateTaskDesc = result.task_desc;
			$scope.updateTaskPriority = result.priority;
			$scope.updateExpStartDate = $filter('date')(result.expected_start_date, "yyyy-MM-dd");
			$scope.updateExpEndDate = $filter('date')(result.expected_end_date, "yyyy-MM-dd");
			$scope.updateTaskId = result.task_id;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update task with given task info
	$scope.updateTask = function(taskId, taskEmp, taskTitle, taskDesc, priority, expStartDate, expEndDate) {
		
		// construct update task object
		var task = {
			task_id: taskId,
			employee : {empId : taskEmp},
			task_title : taskTitle,
			task_desc : taskDesc,
			priority : priority,
			expected_start_date : expStartDate,
			expected_end_date : expEndDate
		};
		
		// send update task request
		$http.post($scope.baseURL + '/Tasks/UpdateTask', task)
		.success(function(result) {
			$('#editTaskModal').modal('hide');
			toaster.pop('success', "Notification", "Task Updated Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#editTaskModal').modal('hide');
			toaster.pop('error', "Notification", "Task Updation Failed");
			console.log(data);
		});
	};
}]);