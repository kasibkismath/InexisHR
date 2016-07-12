var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 
                                               '720kb.datepicker', 'angular-character-count', 'ngFileUpload',
                                               'angular-capitalize', 'angular-convert-to-number', 'chart.js']);



/* Directives */
// unique employee - nicNo
empProfile.directive('ngUnique', ['$http', function (async) {
return {
    require: 'ngModel',
    link: function (scope, elem, attrs, ctrl) {
        elem.on('input', function (evt) {
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
	// Main ng-init function
	$scope.mainInit = function () {
		$scope.getAllEmployees();
		$scope.getAllDesignations();
		$scope.getEmpDesigChartData();
	};
	
	// Pagination Page Size
	$scope.pageSize = 4;
	
	$scope.baseURL = contextPath;
	
	//hireDate max limit date
	$scope.hireDate = new Date();
	
	//birthday max limit date
	$scope.birthday = new Date();
	
	// employee designation chart data and configs
	$scope.options = {
		responsive: true,
		animateScale:true,
		maintainAspectRatio: false
	};
	
		//get employee designation chart labels
	$scope.getEmpDesigChartData = function () {
		// get chart labels
		$http.get($scope.baseURL + '/employeeProfile/employee/getEmpDesignationData')
		.success(function(result) {
			$scope.labels = [];
			$scope.data = [];
			angular.forEach(result, function(value, key) {
				$scope.labels.push(value[0]);
				$scope.data.push(value[1]);
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// validate nic no - Add New Employee
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
	
	// Nic No Validation - Edit Employee
	$scope.editGetNicNo = '';
	$scope.nicPatternMatchEdit = false;
	
	$scope.$watch('editGetNicNo', function (newValue) {
		var patternEdit10 = /^[0-9]{9}[vVxX]$/;
		var patternEdit12 = /^[0-9]{12}$/;
		
		if(newValue === undefined) {
			$scope.nicPatternMatchEdit = false;
		}
		else if(newValue.length == 10 && newValue.match(patternEdit10)) { 
			$scope.nicPatternMatchEdit = true;
		}
		else if (newValue.length == 12 && newValue.match(patternEdit12)) {
			$scope.nicPatternMatchEdit = true;
		} else {
			$scope.nicPatternMatchEdit = false;
		}
	});
	
	// check whether the editEmpForm is dirty to prompt unsaved data
	// while navigating between panels
	$scope.$watch('editEmpForm.$dirty', function(newValue) {
		$scope.isBasicInfoDirty = newValue;
	});
	
	// check education form is dirty
	$scope.$watch('educationForm.$dirty', function(newValue) {
		$scope.isEducationDirty = newValue;
	});
	
	// check work history form is dirty
	$scope.$watch('workHistoryForm.$dirty', function(newValue) {
		$scope.isWorkHistoryDirty = newValue;
	});
	
	$('#basicInfo').on('show.bs.collapse', function () {
		// checks for education form
		if($scope.isEducationDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Education. Do you wish to proceed?');
			if(!confirmMsg) {
				('#education').collapse({
					collapse: true
				})
			} 
		}
		
		// checks for work history form
		if($scope.isWorkHistoryDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Work History. Do you wish to proceed?');
			if(!confirmMsg) {
				('#workHistory').collapse({
					collapse: true
				})
			} 
		}
	});
	
	$('#education').on('show.bs.collapse', function () {
		// checks for basic info form
		if($scope.isBasicInfoDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Basic Information. Do you wish to proceed?');
			if(!confirmMsg) {
				('#basicInfo').collapse({
					collapse: true
				})
			} 
		}
		
		// checks for work history form
		if($scope.isWorkHistoryDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Work History. Do you wish to proceed?');
			if(!confirmMsg) {
				('#workHistory').collapse({
					collapse: true
				})
			} 
		}
	});
	
	$('#workHistory').on('show.bs.collapse', function () {
		// checks for basic info form
		if($scope.isBasicInfoDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Basic Information. Do you wish to proceed?');
			if(!confirmMsg) {
				('#basicInfo').collapse({
					collapse: true
				})
			} 
		}
		// checks for education form
		if($scope.isEducationDirty == true) {
			var confirmMsg = confirm('You have unsaved work in Education. Do you wish to proceed?');
			if(!confirmMsg) {
				('#education').collapse({
					collapse: true
				})
			} 
		}
	});
	
	$scope.getAllEmployees = function(){
		// get all employees
		$http.get($scope.baseURL + '/employeeProfile/employee/all')
		.success(function(result) {
			$scope.employees = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	$scope.getAllDesignations = function () {
		// get all designations
		$http.get($scope.baseURL + '/desgination/all')
		.success(function(result) {
			$scope.designations = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// add new employee
	 $scope.addNewEmp = function(empId, firstName, lastName, nicNo, email, phoneNumber, mobileNumber, hireDate, designationId,
			 employmentType, salary, birthday, education, pastWork, file) {
	      
		 if(phoneNumber === undefined) {
			 phoneNumber = "";
		 };
		 
		 if(hireDate === undefined) {
			 hireDate = null;
		 };
		 
		 if(salary === undefined) {
			 salary = 0;
		 };
		 
		 if(birthday === undefined) {
			 birthday = null;
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
		 
		 $scope.imageURL = firstName + "-" + lastName + "-" + empId +  ".jpg";
		 
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
			// corrected image name with first name, last name and empId
			$scope.updateImageName = firstName + "-" + lastName + "-" + result + ".jpg";
			
			// callupdateImageURL function
			$scope.updateImageURL(result, $scope.updateImageName);
			
			// upload the image
			if ($scope.addNewEmpForm.file.$valid && $scope.file) {
	        	$scope.upload($scope.file, $scope.updateImageName);
			};
			$('#addNewEmpModal').modal('hide');
			toaster.pop('success', "Notification", "Employee created successfully");
			setTimeout(function () {
                window.location.reload();
            }, 4000);
		})
		.error(function(data, status){
			console.log(data);
			$('#addNewEmpModal').modal('hide');
			toaster.pop('error', "Notification", "Creating new employee failed");
		});
	 };
	 
	 $scope.editEmployee = function (empId) {
		 
		 // call the getAllDesignations function
		 $scope.getAllDesignations();
		 
		 var employee = {empId:empId};
		 
		 $http.post(contextPath + '/employeeProfile/employee/getEditEmp', employee)
			.success(function(result){
				$scope.editGetEmpId = result.empId;
				$scope.editGetFirstName = result.firstName;
				$scope.editGetLastName = result.lastName;
				$scope.editGetNicNo = result.nicNo;
				$scope.editGetEmail = result.email;
				$scope.editGetPhoneNo = result.phoneNumber;
				$scope.editGetMobileNo = result.mobileNumber;
				$scope.editGetHireDate = result.hireDate;
				$scope.editGetDesignation = result.designation.designationId;
				$scope.editGetEmpType = result.employmentType;
				$scope.editGetSalary = result.Salary;
				$scope.editGetBirthday = result.birthday;
				$scope.editGetImageURL = result.imageURL;
				$scope.editGetEducation = result.education;
				$scope.editGetPastWork = result.pastWork;
			})
			.error(function(data, status){
				console.log(data);
			});
	 };
	 
	 // update changes to employee
	 $scope.updateEmpDetails = function (empId, firstName, lastName, nicNo, email, phoneNumber, mobileNumber,
			 					hireDate, designationId, employmentType, salary, birthday, file, imageURL) {
		 
		 if(phoneNumber === undefined) {
			 phoneNumber = "";
		 };
		 
		 if(hireDate === undefined) {
			 hireDate = null;
		 };
		 
		 if(salary === undefined) {
			 salary = 0;
		 };
		 
		 if(birthday === undefined) {
			 birthday = null;
		 };
		 
		 if(firstName != null) {
			 firstName = capitalizeFilter(firstName);
		 };
		 
		 if(lastName != null) {
			 lastName = capitalizeFilter(lastName);
		 };
		 
		var employee = {
			empId : empId,
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
			imageURL : imageURL
		};
		
		$http.post(contextPath + '/employeeProfile/employee/updateEditBasicInfoEmp', employee)
		.success(function(result){
			if ($scope.editEmpForm.file.$valid && $scope.editGetFile) {
	        	$scope.upload($scope.editGetFile, imageURL);
			};
			toaster.pop('success', "Notification", "Employee details were updated");
			setTimeout(function () {
                window.location.reload();
            }, 5000);
		})
		.error(function(data, status){
			console.log(data);
			toaster.pop('error', "Notification", "Employee details were not updated");
		});
	 };
	 
	 // update employee education details
	 $scope.updateEmpEduDetails = function(empId, education) {
		 
		 // capitalize education details
		 education = capitalizeFilter(education);
		 
		 var employee = {
			empId : empId,
			education : education
		 };
		 
		 $http.post(contextPath + '/employeeProfile/employee/updateEditEduFormDetails', employee)
			.success(function(result){
				toaster.pop('success', "Notification", "Employee education details was updated");
				setTimeout(function () {
	                window.location.reload();
	            }, 3000);
			})
			.error(function(data, status){
				console.log(data);
				toaster.pop('error', "Notification", "Employee education details was not updated");
			});
		 };
		 
	// update work history
	$scope.updateWorkHistory = function(empId, pastWork) {
		
		// capitalize pastWork
		pastWork = capitalizeFilter(pastWork);
		 
		 var employee = {
			empId : empId,
			pastWork : pastWork
		 };
		 
		 $http.post(contextPath + '/employeeProfile/employee/updateWorkHistory', employee)
			.success(function(result){
				toaster.pop('success', "Notification", "Employee work history was updated");
				setTimeout(function () {
	                window.location.reload();
	            }, 3000);
			})
			.error(function(data, status){
				console.log(data);
				toaster.pop('error', "Notification", "Employee work history was not updated");
			});
		 
		 
	};
	
	// delete employee
	$scope.deleteEmployee = function(empId) {
		$scope.deleteEmp = function () {
			
			var employee = {
				empId: empId
			};
			
			$http.post(contextPath + '/employeeProfile/employee/deleteEmployee', employee)
			.success(function(result){
				$('#empDeleteModal').modal('hide');
				toaster.pop('success', "Notification", "Employee was deleted sucessfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 2000);
			})
			.error(function(data, status){
				console.log(data);
			});
		}
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
    
    // update imageURL in the database
    $scope.updateImageURL = function(empId, imageURL) {
    	var employee = {
    			empId: empId,
    			imageURL: imageURL
    	}
    	$http.post(contextPath + '/employeeProfile/employee/updateImageURL', employee)
		.success(function(result){
			toaster.pop('success', "Notification", "Update Employee Image URL");
		})
		.error(function(data, status){
			console.log(data);
			toaster.pop('error', "Notification", "Cannot Update Employee Image URL");
		});
    }
    
    // reset Emp data to it's original state
    $scope.resetEmpData = function (empId) {
		toaster.pop('success', "Notification", "Data was resetted");
		$scope.editEmployee(empId);
		setTimeout(function () {
            window.location.reload();
        }, 1000);
	};
	
}]);
