var userSetting = 
	angular.module('userSetting', ['ngMessages', 'ngCapsLock', 'validation.match', 'toaster', 'ngAnimate']);

userSetting.controller('mainController', ['$scope', '$http', 'toaster', '$window', 
                        function ($scope, $http, toaster, $window) {
	
	// username from userSettings.jsp
	$scope.username = currentUser;
	
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
				toaster.pop('success', "Notification", "User details were  not updated");
				console.log(data);
			});		
	}
	
	$scope.UpdateChangePassword = function (password, email) {
		var user = {
				username : username,
				password : password
		};
		
		$http.post($scope.baseURL + '/user/settings/updateUserPassword', user)
		 .success(function (result) {
			$scope.sendMail(email);
			toaster.pop('success', "Notification", "Password was changed successfully");
			setTimeout(function () {
				$window.location.href = contextPath + "/";
            }, 2000);
		 })
		 .error(function(data, status){
			 toaster.pop('error', "Notification", "Password was not changed");
			 console.log(data);
		});
		
	}
	
	$scope.sendMail = function (email) {
		$http.post($scope.baseURL + '/sendChangePasswordMail', {"email" : email})
		 .success(function (result) {
			 })
			 .error(function(data, status){
				toaster.pop('error', "Notification", "Sending password changed email failed");
				console.log(data);
			});		
	} 
	
	$scope.resetToDefault = function () {
		toaster.pop('success', "Notification", "User details were reset to default");
		$scope.getUserDetails();
	}
	
	$scope.resetToDefaultPassword = function () {
		$scope.changePassword = '';
		$scope.confirmChangePassword = '';
		toaster.pop('success', "Notification", "User details were reset to default");
	}
	
}]);