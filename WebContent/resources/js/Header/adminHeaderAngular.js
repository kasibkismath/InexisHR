var adminHeader = angular.module('adminHeader', []);

/* Controllers */
adminHeader.controller('headerController', ['$scope', '$http', function($scope, $http){
	
	 // loggedIn User details - loggedIn User Image
	 $scope.getCurrentUser = function() {
		 var user = {
			 username : currentUser
		 };
		 
		 $http.post(contextPath + '/administration/user/currentUser', user)
			.success(function(result){
				$scope.userImage = result.employee.imageURL;
			})
			.error(function(data, status){
				console.log(data);
			});
	 };
	
}]);
