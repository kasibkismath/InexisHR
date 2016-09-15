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
	
	
	
	$scope.init = function(){
		// variables
		$scope.checkForExpectedStartEndDateResult = false;
		
		// function
		$scope.getEmployeesByLeadId();
		$scope.getAllEmployees();
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
	
	$scope.checkForExpectedStartEndDate = function(startDate, endDate) {
		if(endDate < startDate)
			$scope.checkForExpectedStartEndDateResult = true;
	};
}]);