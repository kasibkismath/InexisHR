var attendance = angular.module('attendance', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

attendance.controller('attendanceMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;
	$scope.checkAttendanceDuplicateResult = false;
	$scope.timeSpentValidationError = false;
	
	// initializations
	$scope.saveAttendanceDate = $filter('date')(new Date(), "yyyy-MM-dd");
	
	$scope.init = function(){
		$scope.getProjects();
		$scope.getProjectsByEmpId();
		$scope.getAttendancesByEmpId();
		
		// set datatable configs
		 // user and lead datatable
		$scope.dtOptionsUserLead = DTOptionsBuilder.newOptions()
	    .withOption('order', [0, 'desc']);
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
	
	// gets all In-Progress and On-Hold Projects
	$scope.getProjects = function() {
		$http.get($scope.baseURL + '/Attendance/GetProjects')
		.success(function(result) {
			//$scope.projects = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all In-Progress and On-Hold Projects by EmpId
	$scope.getProjectsByEmpId = function() {
		$scope.getLoggedInEmployee()
		.then(function(employee) {
			var empId = employee.empId;
			
			var attendance = {
				employee : {empId : empId}
			};
			
			$http.post($scope.baseURL + '/Attendance/GetProjectsByEmpId', attendance)
			.success(function(result) {
				$scope.projects = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// get attendances for the logged in emp and current year
	$scope.getAttendancesByEmpId = function() {
		$scope.getLoggedInEmployee()
		.then(function(employee) {
			var empId = employee.empId;
			
			var attendance = {
				employee : {empId : empId}
			};
				
			$http.post($scope.baseURL + '/Attendance/GetAttendancesByEmpId', attendance)
			.success(function(result) {
				$scope.attendancesByEmpId = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
			
		});
	};
	
	// check time spent is less than 0.5 or more than 16.0
	$scope.timeSpentValidation = function(timeSpent) {
		if(timeSpent<0.50 || timeSpent>16.00) {
			$scope.timeSpentValidationError = true;
		} else {
			$scope.timeSpentValidationError = false;
		}
	};
	
	// check for duplicate attendance
	$scope.checkDuplicateAttendance = function(date, project, taskType) {
		if(date != undefined && project != undefined && taskType != undefined) {
			
			// get current user employee
			$scope.getLoggedInEmployee()
			.then(function(result) {
				var empId = result.empId;
				
				//construct attd object with empId and other data
				var attendance = {
					employee : {empId : empId},
					project : {project_id : project},
					task_type : taskType,
					date : date
				};
				
				// send request to check if duplicate attendance exists
				$http.post($scope.baseURL + '/Attendance/CheckAttendanceDuplicate', attendance)
				.success(function(result) {
					$scope.checkAttendanceDuplicateResult = result;
				})
				.error(function(data, status) {
					console.log(data);
				});
				
			});
		} else {
			$scope.checkAttendanceDuplicateResult = false;
		}
	};
	
	$scope.addAttendance = function(date, project, taskType, tasks, timeSpent, status) {
		$scope.getLoggedInEmployee()
		.then(function(result) {
			var empId = result.empId;
			
			var attendance = {
				employee : {empId : empId},
				project : {project_id : project},
				task_type : taskType,
				date : date,
				task : tasks,
				status : status,
				time_spent : timeSpent
			};
			
			$http.post($scope.baseURL + '/Attendance/AddAttendance', attendance)
			.success(function(result) {
				$('#addAttendanceModal').modal('hide');
				toaster.pop('success', "Notification", "Attendance Added Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 1000);
			})
			.error(function(data, status) {
				$('#addAttendanceModal').modal('hide');
				toaster.pop('error', "Notification", "Adding Attendance Failed");
				console.log(data);
			});
			
		});
	};
	
	// get attendance by attd_id
	$scope.getAttendanceByAttendanceId = function(attd_id) {
		var attendance = {
			attd_id : attd_id
		};
		
		$http.post($scope.baseURL + '/Attendance/GetAttendanceByAttendanceId', attendance)
		.success(function(result) {
			$scope.editAttendanceDate = $filter('date')(result.date, "yyyy-MM-dd");
			$scope.editAttendanceProject = result.project.project_id;
			$scope.editAttendanceTaskType = result.task_type;
			$scope.editAttendanceTasks = result.task;
			$scope.editAttendanceTimeSpent = result.time_spent;
			$scope.editAttendanceStatus = result.status;
			$scope.editAttendanceId = result.attd_id;
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	$scope.updateAttendance = function(attd_id, date, project, taskType, tasks, timeSpent, status) {
		
		var attendance = {
			attd_id : attd_id,
			project : {project_id : project},
			task_type : taskType,
			date : date,
			task : tasks,
			status : status,
			time_spent : timeSpent
		};
		
		$http.post($scope.baseURL + '/Attendance/UpdateAttendance', attendance)
		.success(function(result) {
			$('#editAttendanceModal').modal('hide');
			toaster.pop('success', "Notification", "Attendance Updated Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#editAttendanceModal').modal('hide');
			toaster.pop('error', "Notification", "Updating Attendance Failed");
			console.log(data);
		});
	};

}]);