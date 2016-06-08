var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 
                                               '720kb.datepicker', 'angular-character-count', 'ngFileUpload',
                                               'angular-capitalize']);

/* Controllers */
empProfile.controller('mainController', ['$scope', '$http', 'Upload', 'capitalizeFilter', 
                                         function($scope, $http, Upload, capitalizeFilter){
	
	// Pagination Page Size
	$scope.pageSize = 10;
	
	$scope.baseURL = contextPath;
	
	
	//hireDate max limit date
	$scope.hireDate = new Date();
	
	//birthday max limit date
	$scope.birthday = new Date();

	
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
	
	
	// add new employee
	 $scope.addNewEmp = function(firstName, lastName, email, phoneNo, mobileNo, hireDate, designation,
			 employmentType, salary, birthday, education, pastWork, file) {
	      
		 
		/* if ($scope.form.file.$valid && $scope.file) {
	        $scope.upload($scope.file);
	      }*/
		 
		 $scope.fileType = file.type;
		 $scope.newFileType = $scope.fileType.substring(6);
		 $scope.fileName = firstName + "-" + lastName + "." + $scope.newFileType;
		 
		 if(phoneNo === undefined) {
			 phoneNo = "";
		 };
		 
		 if(hireDate === undefined) {
			 hireDate = "";
		 };
		 
		 if(salary === undefined) {
			 salary = 0;
		 };
		 
		 if(birthday === undefined) {
			 birthday = "";
		 };
		 
		 if(education === undefined) {
			 education = "";
		 };
		 
		 if(pastWork === undefined) {
			 pastWork = "";
		 };
		 
		 if(firstName != null) {
			 console.log(capitalizeFilter(firstName));
		 };
		 
		 if(lastName != null) {
			 console.log(capitalizeFilter(lastName));
		 };
		 
		 if(education != null) {
			 console.log(capitalizeFilter(education));
		 };
		 
		 if(pastWork != null) {
			 console.log(capitalizeFilter(pastWork));
		 };
		 
		  
		var employee = {
			firstName : firstName,
			lastName : lastName,
			email : email,
			phoneNo : phoneNo,
			mobileNo : mobileNo,
			hireDate : hireDate,
			designation : {desginationId : designation},
			employmentType : employmentType,
			salary : salary,
			birthday : birthday,
			education : education,
			pastWork : pastWork,
			imageURL : $scope.fileName
		}
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
