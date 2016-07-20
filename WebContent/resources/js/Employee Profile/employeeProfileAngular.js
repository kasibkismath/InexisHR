var empProfile = angular.module('empProfile', ['angularUtils.directives.dirPagination', 
                                               'ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 
                                               '720kb.datepicker', 'angular-character-count', 'ngFileUpload',
                                               'angular-capitalize', 'angular-convert-to-number', 'chart.js',
                                               'datatables', 'toggle-switch']);



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

// check for duplicate designation name
empProfile.directive('ngUniqueDesignation', ['$http', function (async) {
	return {
	    require: 'ngModel',
	    link: function (scope, elem, attrs, ctrl) {
	        elem.on('input', function (evt) {
	            scope.$apply(function () {                   
	                var val = elem.val();
	                var req = { "name": val }
	                var ajaxConfiguration = { method: 'POST', url: contextPath + '/designation/checkDesignationExists', data: req };
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
empProfile.controller('mainController', ['$scope', '$http', '$compile', 'Upload', 'capitalizeFilter', 
                                         'toaster', 'DTOptionsBuilder', 'DTColumnBuilder',
                                         function($scope, $http, $compile, Upload, capitalizeFilter, toaster, 
                                        		 DTOptionsBuilder, DTColumnBuilder){
	// Angular Designation Data Table configuration
	
	$scope.dtColumns = [
	                    //here We will add .withOption('name','column_name') for send column name to the server 
	                    DTColumnBuilder.newColumn("designationId", "ID").withOption('name', 'designationId'),
	                    DTColumnBuilder.newColumn("name", "Designation").withOption('name', 'name'),
	                    DTColumnBuilder.newColumn(null).withTitle('Actions')
	                    	.renderWith(function(data, type, full, meta) {
	                        return '<button class="btn btn-primary" id="editDesig" data-toggle="modal" data-target="#editDesigModal" ng-click="editDesigMain('+ data.designationId +')"><i class="fa fa-pencil fa-lg"></i> Edit</button>' +
	                            '<button class="btn btn-danger" id="deleteDesig" data-toggle="modal" data-target="#deleteDesigModal" ng-click="deleteDesigMain(' + data.designationId + ')"><i class="fa fa-trash fa-lg"></i> Delete</button>';
	                    })
	                ];
	
	 $scope.dtOptions = DTOptionsBuilder.newOptions()
	 .withOption('ajax', {
         url: contextPath + '/desgination/all',
         type:"GET"
     })
     .withOption('createdRow', function(row, data, dataIndex) {
              $compile(angular.element(row).contents())($scope);
      })
     .withPaginationType('full_numbers')
     .withDisplayLength(10);
	
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
	
	// init add new employee status switch
	$scope.saveNewEmpIsEnabled = true;
	
	// employee designation chart data and configs
	$scope.options = {
		responsive: true,
		animateScale:true,
		maintainAspectRatio: false,
		tooltipEvents: [],
		showTooltips: true,
		tooltipCaretSize: 0,
		onAnimationComplete: function () {
			this.showTooltip(this.segments, true);
		},
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
	
	$scope.getAllEmployees = function() {
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
	 $scope.addNewEmp = function(empId, firstName, lastName, nicNo, status, 
			 email, phoneNumber, mobileNumber, hireDate, designationId,
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
			status : status,
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
				$scope.editGetStatus = result.status;
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
	
	// designation update modal data retrival
	$scope.editDesigMain = function(id) {
		var designation = {designationId : id};
		
		$http.post($scope.baseURL + '/designation/getDesignationById', designation)
		.success(function(result){
			$scope.getEditDesignationId = result.designationId;
			$scope.getEditDesignationName = result.name;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// update designation details
	$scope.updateDesignation = function (designationId, name) {
		
		// make every first letter of name as uppercase
		name = capitalizeFilter(name)
		
		var designation = {
			designationId: designationId,
			name: name
		};
		
		$http.post($scope.baseURL + '/designation/updateDesignation', designation)
		.success(function(result){
			$('#editDesigModal').modal('hide');
			toaster.pop('success', "Notification", "Updated Designation");
			setTimeout(function () {
                window.location.reload();
            }, 2000);
		})
		.error(function(data, status){
			console.log(data);
		});
	}
	
	// designation delete
	$scope.deleteDesigMain = function(designationId){
		$scope.deleteDesignation = function() {
			var designation = {
				designationId : designationId
			};
			
			$http.post($scope.baseURL + '/designation/deleteDesignationById', designation)
			.success(function(result){
				$('#deleteDesigModal').modal('hide');
				toaster.pop('success', "Notification", "Designation Deleted");
				setTimeout(function () {
	                window.location.reload();
	            }, 2000);
			})
			.error(function(data, status){
				console.log(data);
			});
		};
	}
	
	// add designation
	$scope.addDesignation = function(name) {
		
		// make every first letter of name as uppercase
		name = capitalizeFilter(name)
		
		var designation = {name: name};
		
		$http.post($scope.baseURL + '/designation/addDesignation', designation)
		.success(function(result){
			$('#addDesigModal').modal('hide');
			toaster.pop('success', "Notification", "Designation Added");
			setTimeout(function () {
                window.location.reload();
            }, 2000);
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// get employee status
	$scope.disableEmpMain = function(empId)  {
		var employee = {
			empId : empId
		};
		
		$http.post($scope.baseURL + '/employeeProfile/employee/getStatus', employee)
		.success(function(result){
			$scope.getStatusEmpId = result.empId;
			$scope.getEmpStatus = result.status;
		})
		.error(function(data, status){
			console.log(data);
		});
	}
	
	// update employee status
	$scope.disableEmp = function (empId, status) {
		var employee = {
			empId : empId,
			status : status
		};
		
		console.log(employee);
		
		$http.post($scope.baseURL + '/employeeProfile/employee/disable', employee)
		.success(function(result){
			$('#empDisableModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Status Updated");
			setTimeout(function () {
                window.location.reload();
            }, 2000);
		})
		.error(function(data, status){
			console.log(data);
		});
	}
}]);