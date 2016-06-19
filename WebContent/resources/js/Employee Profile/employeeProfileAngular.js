var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 
                                               '720kb.datepicker', 'angular-character-count', 'ngFileUpload',
                                               'angular-capitalize']);

/* Directives */
// unique employee - nicNo
empProfile.directive('ngUnique', ['$http', function (async) {
return {
    require: 'ngModel',
    link: function (scope, elem, attrs, ctrl) {
        elem.on('keyup', function (evt) {
            scope.$apply(function () {                   
                var val = elem.val();
                var req = { "nicNo": val }
                var ajaxConfiguration = { method: 'POST', url: contextPath + '/employeeProfile/employee/checkEmpExists', data: req };
                async(ajaxConfiguration)
                    .success(function(data, status, headers, config) {   
                    		ctrl.$setValidity('unique', data);
                    });
            });
        });
    }
}
}]);

/* Controllers */
empProfile.controller('mainController', ['$scope', '$http', 'Upload', 'capitalizeFilter', 'toaster',
                                         function($scope, $http, Upload, capitalizeFilter, toaster){
	$scope.saveNewNicNo = '';
	// Pagination Page Size
	$scope.pageSize = 4;
	
	$scope.baseURL = contextPath;
	
	//hireDate max limit date
	$scope.hireDate = new Date();
	
	//birthday max limit date
	$scope.birthday = new Date();
	
	// current year for NIC Number Issue Date
	$scope.currentYear = parseInt(new Date().getFullYear());
	
	// validate nic no
	$scope.saveNewNicNo = '';
	$scope.nicPatternMatch = false;
	
	$scope.$watch('saveNewNicNo', function (newValue) {
		var pattern10 = /^[0-9]{9}[vVxX]$/;
		var pattern12 = /^[0-9]{12}$/;
		
		if(newValue === undefined) {
			$scope.nicPatternMatch = false;
		}
		else if(newValue.length == 10 && newValue.match(pattern10)) { 
			$scope.nicPatternMatch = true;
		}
		else if (newValue.length == 12 && newValue.match(pattern12)) {
			$scope.nicPatternMatch = true;
		} else {
			$scope.nicPatternMatch = false;
		}
	});
	
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
	 $scope.addNewEmp = function(firstName, lastName, nicNo, email, phoneNumber, mobileNumber, hireDate, designationId,
			 employmentType, salary, birthday, education, pastWork, file) {
	      
		 $scope.fileType = file.type;
		 $scope.newFileType = $scope.fileType.substring(6);
		 
		 if($scope.newFileType === 'jpeg')
			 $scope.imageFileType = 'jpg';
		 
		 
		 if(phoneNumber === undefined) {
			 phoneNumber = "";
		 };
		 
		 if(hireDate === undefined) {
			 hireDate = new Date();
		 };
		 
		 if(salary === undefined) {
			 salary = 0;
		 };
		 
		 if(birthday === undefined) {
			 birthday = new Date();;
		 };
		 
		 if(education === undefined) {
			 education = "";
		 };
		 
		 if(pastWork === undefined) {
			 pastWork = "";
		 };
		 
		 if(firstName != null) {
			 firstName = capitalizeFilter(firstName);
		 };
		 
		 if(lastName != null) {
			 lastName = capitalizeFilter(lastName);
		 };
		 
		 if(education != null) {
			 console.log(capitalizeFilter(education));
		 };
		 
		 if(pastWork != null) {
			 console.log(capitalizeFilter(pastWork));
		 };
		 
		 $scope.imageURL = firstName + "-" + lastName + ".jpg";
		 
		if ($scope.addNewEmpForm.file.$valid && $scope.file) {
	        	$scope.upload($scope.file, $scope.imageURL);
	     };
		 
		var employee = {
			firstName : firstName,
			lastName : lastName,
			nicNo : nicNo,
			email : email,
			phoneNumber : phoneNumber,
			mobileNumber : mobileNumber,
			hireDate : hireDate,
			designation : {designationId: designationId},
			employmentType : employmentType,
			salary : salary,
			birthday : birthday,
			education : education,
			pastWork : pastWork,
			imageURL : $scope.imageURL
		};
		
		$http.post(contextPath + '/employeeProfile/employee/addNewEmp', employee)
		.success(function(result){
			$('#addNewEmpModal').modal('hide');
			toaster.pop('success', "Notification", "Employee created successfully");
			setTimeout(function () {
                window.location.reload();
            }, 2000);
		})
		.error(function(data, status){
			console.log(data);
			$('#addNewEmpModal').modal('hide');
			toaster.pop('error', "Notification", "Creating new employee failed");
		});
	 };
	
	// image upload
	$scope.upload = function (file, fileName) {
        Upload.upload({
            url: contextPath + '/FileUpload',
            method: 'POST',
            data: {file: file, fileName: fileName}
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
