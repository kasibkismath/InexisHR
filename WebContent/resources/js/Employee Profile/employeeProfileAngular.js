var empProfile = angular.module('empProfile', []);

/* Controllers */
empProfile.controller('mainController', ['$scope', '$http', function($scope, $http){
	
	$scope.baseURL = contextPath;
	
	// get all employees
	$http.get($scope.baseURL + '/employeeProfile/employee/all')
	.success(function(result) {
		$scope.employees = result;
	})
	.error(function(data, status) {
		console.log(data);
	})
	
}]);
