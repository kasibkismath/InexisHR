var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 
                                               '720kb.datepicker', 'angular-character-count', 'ngFileUpload']);

/* Controllers */
empProfile.controller('mainController', ['$scope', '$http', 'Upload', function($scope, $http, Upload){
	
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
	
	 $scope.addNewEmp = function(firstName, lastName, email, phoneNo, mobileNo, hireDate, designation,
			 employmentType, salary, birthday, education, pastWork, file) {
	      /*if ($scope.form.file.$valid && $scope.file) {
	        $scope.upload($scope.file);
	      }*/
		 
		 $scope.fileType = file.type;
		 $scope.newFileType = $scope.fileType.substring(6);
		 
		 if(phoneNo === undefined) {
			 phoneNo = "";
		 }
		  
		 $scope.fileName = firstName + "-" + lastName + "." + $scope.newFileType;
	      
	      console.log(firstName + " " +  lastName + " " +  email + " " +  phoneNo + " " + mobileNo + " " +  
	    		  hireDate + " " + designation + " " + employmentType + " " +  salary + " " +  birthday + " " +  
	    		  education + " " +  pastWork + " " +  file.name + " " + $scope.fileName);
	 };
	
	// image upload
	$scope.upload = function (file) {
        Upload.upload({
            url: 'upload/url',
            method: 'POST',
            data: {file: file}
        }).then(function (resp) {
            console.log('Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data);
        }, function (resp) {
            console.log('Error status: ' + resp.status);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };
	
}]);
