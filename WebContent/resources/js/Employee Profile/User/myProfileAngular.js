var myProfile = angular.module('myProfile', []);

// Controllers
myProfile.controller('myProfileMainController', ['$scope', '$http', function($scope, $http) {
	
	$scope.currentUser = currentUser;
	$scope.baseURL = contextPath;
	
	$scope.getEmployeeInfoByUsername = function () {
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/employeeProfile/MyProfile/getEmployee', user)
		.success(function(result) {
			$scope.firstName = result.employee.firstName;
			$scope.lastName = result.employee.lastName;
			$scope.email = result.employee.email;
			$scope.designation = result.employee.designation.name;
			$scope.employmentType = result.employee.employmentType;
			$scope.phoneNumber = result.employee.phoneNumber;
			$scope.mobileNumber = result.employee.mobileNumber;
			$scope.nicNo = result.employee.nicNo;
			$scope.status = result.employee.status;
			$scope.hireDate = result.employee.hireDate;
			$scope.birthDate = result.employee.birthDate;
			$scope.salary = result.employee.salary;
			$scope.birthDate = result.employee.birthDate;
			$scope.education = result.employee.education;
			$scope.workExp = result.employee.pastWork;
			$scope.imageURL = result.employee.imageURL;
			console.log(result)
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
}]);