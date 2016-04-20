var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination']);

/* Controllers */
empProfile.controller('mainController', ['$scope', '$http', function($scope, $http){
	
	// Pagination Page Size
	$scope.pageSize = 10;
	
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
