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
	var currDate = new Date();
	currDate.setDate(currDate.getDate()-1);
	$scope.currentDate = currDate;
	
	$scope.init = function(){
		// variables
		$scope.checkForExpectedStartEndDateResult = false;
		$scope.checkForActualStartEndDateResult = false;
		$scope.checkDuplicateTaskResult = false;
		
		// functions
		$scope.getEmployeesByLeadId();
		$scope.getAllEmployees();
		$scope.getAssignedTasksByLeadId();
		$scope.leadCeoSummaryChart();
		$scope.getPendingTaskCount();
		$scope.getOnHoldTaskCount();
		$scope.getCompletedTaskCount();
		$scope.getTerminatedTaskCount();
		$scope.getOverdueTaskCount();
		$scope.getMyTask();
		
		// set datatable configs
		 // user and lead datatable
		$scope.dtOptionsLeadCEO = DTOptionsBuilder.newOptions()
	    .withOption('order', [4, 'desc']);
	};
	
	$scope.leadCeoSummaryChart = function() {
		
		 $scope.leadCeoLabels = [];
		 $scope.leadCeoData = [[]];
		 
		 $scope.getLoggedInEmployee()
		 .then(function(emp){
			 var assigned_by = emp.empId;
			 
			 var task = {
				assigned_by : {empId : assigned_by}	 
			 };
			 
			 $http.post($scope.baseURL + '/Tasks/GetEmployeeTaskCompletionPercentage', task)
			.success(function(result) {
				angular.forEach(result, function(value, key) {
					$scope.leadCeoLabels.push(value[0]);
					$scope.leadCeoData[0].push(value[1]);
				});
			})
			.error(function(data, status) {
				console.log(data);
			});
			 
		 });
		 
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
	
	// check if actual end date is less than expected start date
	$scope.checkForActualStartEndDate = function(startDate, endDate) {
		if(endDate < startDate)
			$scope.checkForActualStartEndDateResult = true;
		else 
			$scope.checkForActualStartEndDateResult = false;
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
			$scope.updateActStartDate = $filter('date')(result.actual_start_date, "yyyy-MM-dd");
			$scope.updateActEndDate = $filter('date')(result.actual_end_date, "yyyy-MM-dd");
			$scope.updateTaskId = result.task_id;
			$scope.updateTaskStatus = result.status;
			
			// store expStartDate to begin actStartDate
			var temp = $filter('date')(result.expected_start_date, "yyyy-MM-dd");
			var myAcutalStartDate = new Date(temp);
			myAcutalStartDate.setDate(myAcutalStartDate.getDate() - 1);
			$scope.actualStartDate = myAcutalStartDate;
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
	
	// called from task.jsp to set delete task_id
	$scope.deleteTaskMain = function(task_id) {
		$scope.deleteTaskId = task_id;
	};
	
	//actually delete task called from Delete Modal
	$scope.deleteTask = function(task_id) {
		
		var task = {
			task_id : task_id
		};
		
		// send request to delete task
		$http.post($scope.baseURL + '/Tasks/DeleteTask', task)
		.success(function(result) {
			$('#deleteTaskModal').modal('hide');
			toaster.pop('success', "Notification", "Task Delete Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#deleteTaskModal').modal('hide');
			toaster.pop('error', "Notification", "Task Deletion Failed");
			console.log(data);
		});
	};
	
	// get pending tasks by logged_in emp
	$scope.getPendingTaskCount = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by},
			};
			
			$http.post($scope.baseURL + '/Tasks/GetPendingTaskCount', task)
			.success(function(result) {
				$scope.getPendingTaskCountResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get on hold tasks by logged_in emp
	$scope.getOnHoldTaskCount = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by},
			};
			
			$http.post($scope.baseURL + '/Tasks/GetOnHoldTaskCount', task)
			.success(function(result) {
				$scope.getOnHoldTaskCountResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get completed tasks by logged_in emp
	$scope.getCompletedTaskCount = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by},
			};
			
			$http.post($scope.baseURL + '/Tasks/GetCompletedTaskCount', task)
			.success(function(result) {
				$scope.getCompletedTaskCountResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get terminated tasks by logged_in emp
	$scope.getTerminatedTaskCount = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by},
			};
			
			$http.post($scope.baseURL + '/Tasks/GetTerminatedTaskCount', task)
			.success(function(result) {
				$scope.getTerminatedTaskCountResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get overdue tasks by logged_in emp
	$scope.getOverdueTaskCount = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var assigned_by = emp.empId;
			
			var task = {
				assigned_by : {empId : assigned_by}
			};
			
			$http.post($scope.baseURL + '/Tasks/GetOverdueTaskCount', task)
			.success(function(result) {
				$scope.getOverdueTaskCountResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get logged in employee my tasks
	$scope.getMyTask = function() {
		$scope.getLoggedInEmployee()
		.then(function(emp) {
			var employee_id = emp.empId;
			
			var task = {
				employee : {empId : employee_id}
			};
			
			$http.post($scope.baseURL + '/Tasks/GetMyTasks', task)
			.success(function(result) {
				$scope.getMyTasks = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// update my task
	$scope.updateMyTask = function(task_id, status, actualStartDate, actualEndDate) {
		var task = {
			task_id: task_id,
			status : status,
			actual_start_date : actualStartDate,
			actual_end_date : actualEndDate
		};
			
		// send update my task request
		$http.post($scope.baseURL + '/Tasks/UpdateMyTask', task)
		.success(function(result) {
			$('#editMyTaskModal').modal('hide');
			toaster.pop('success', "Notification", "Task Updated Successfully");
			setTimeout(function () {
	               window.location.reload();
	        }, 1000);
		})
		.error(function(data, status) {
			$('#editMyTaskModal').modal('hide');
			toaster.pop('error', "Notification", "Task Updation Failed");
			console.log(data);
		});
	};
}]);