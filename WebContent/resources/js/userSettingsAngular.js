var userSetting = 
	angular.module('userSetting', ['ngMessages', 'ngCapsLock', 'validation.match']);

userSetting.controller('mainController', ['$scope', '$http', function ($scope, $http) {
	
	// username from userSettings.jsp
	$scope.username = username;
	
	// application base url
	$scope.baseURL = contextPath;
	
	$scope.getUserDetails = function () {
		// user object with username
		var user = {username : $scope.username};
		
		$http.post($scope.baseURL + '/user/settings/getUser', user)
			 .success(function (result) {
				 $scope.getUsername = result.username;
				 $scope.getEmail = result.email;
			 })
			 .error(function(data, status){
				console.log(data);
			});
	};
	
}]);