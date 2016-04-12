var userSetting = 
	angular.module('userSetting', ['ngMessages', 'ngCapsLock', 'validation.match', 'toaster', 'ngAnimate']);

userSetting.controller('mainController', ['$scope', '$http', 'toaster', function ($scope, $http, toaster) {
	
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
	
	$scope.updateUserSettingsProfile = function (username, email) {
		
		var user = {
					username : username,
					email : email
				};
		
		$http.post($scope.baseURL + '/user/settings/updateUser', user)
			 .success(function (result) {
				toaster.pop('success', "Notification", "User details were updated successfully");
				$scope.getUserDetails();
			 })
			 .error(function(data, status){
				console.log(data);
			});		
	}
	
	$scope.resetToDefault = function () {
		toaster.pop('success', "Notification", "User details were reset to default");
		$scope.getUserDetails();
	}
	
}]);