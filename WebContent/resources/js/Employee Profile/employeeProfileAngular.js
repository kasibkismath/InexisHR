var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', '720kb.datepicker']);

//covert to number -- select option
empProfile.directive('convertToNumber', function() {
	  return {
	    require: 'ngModel',
	    link: function(scope, element, attrs, ngModel) {
	      ngModel.$parsers.push(function(val) {
	        return val ? parseInt(val, 10) : null;
	      });
	      ngModel.$formatters.push(function(val) {
	        return val ? '' + val : null;
	      });
	    }
	  };
	});


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
	});
	
	// get all designations
	$http.get($scope.baseURL + '/desgination/all')
	.success(function(result) {
		$scope.designations = result;
		console.log($scope.designations);
	})
	.error(function(data, status) {
		console.log(data);
	});
	
}]);
