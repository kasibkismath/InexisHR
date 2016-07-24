var performance = angular.module('performance', ['toaster', 'ngAnimate']);

// Controllers
performance.controller('performanceMainController', ['$scope', '$http', function($scope, $http) {
	
	$scope.currentUser = currentUser;
	$scope.baseURL = contextPath;
	
}]);