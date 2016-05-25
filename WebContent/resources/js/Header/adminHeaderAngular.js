var adminHeader = angular.module('adminHeader', []);

/* Controllers */
adminHeader.controller('headerController', ['$scope', '$http', function($scope, $http){
	$scope.baseURL = contextPath;
	console.log($scope.baseURL);
	
}]);
