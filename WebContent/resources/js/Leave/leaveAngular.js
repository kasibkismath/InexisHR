var leave = angular.module('leave', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

leave.controller('leaveMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;

	$scope.availableLeaves = 12;
	$scope.fromLeaveDate = new Date();
	
	// called when the page loads
	$scope.init = function () {
		// calls other functions
		$scope.userAndLeadSummaryChart();
		$scope.getAllLeaveTypes();
		$scope.getCasualLeaveTypeId();
		$scope.getMedicalLeaveTypeId();
		
		// set maxAnnualLeave and maxCasualAndMedicalLeave
		$scope.getLoggedInEmpHiredDate()
		.then(function(hiredDate) {
			// years
			var currentYear = new Date().getFullYear();
			var hiredYear = new Date(hiredDate).getFullYear();
			
			// month
			var hiredMonth = new Date(hiredDate).getMonth();
			
			
			if(hiredYear === currentYear) {
				if(hiredMonth == 0 || hiredMonth == 1 || hiredMonth == 2) {
					 // set annual leave
					$scope.maxAnnualLeave = 14;
					
					// set casual and sick leave
					$scope.maxCasualAndMedicalLeave = 7;
					
				}  else if (hiredMonth == 3 || hiredMonth == 4 || hiredMonth == 5) {
					// set annual leave
					$scope.maxAnnualLeave = 10;
					
					// set casual and sick leave
					$scope.maxCasualAndMedicalLeave = 5;
					
				} else if (hiredMonth == 6 || hiredMonth == 7 || hiredMonth == 8) {
					// set annual leave
					$scope.maxAnnualLeave = 7;
					
					// set casual and sick leave
					$scope.maxCasualAndMedicalLeave = 3.5;
					
				} else if(hiredMonth == 9 || hiredMonth == 10 || hiredMonth == 11) {
					// set annual leave
					$scope.maxAnnualLeave = 3;
					
					// set casual and sick leave
					$scope.maxCasualAndMedicalLeave = 2;
				}
			} else {
				 // set annual leave
				$scope.maxAnnualLeave = 3;
				
				 // set casual and sick leave
				$scope.maxCasualAndMedicalLeave = 0.5;
			}
			
		});
	};
	
	// user and lead chart
	$scope.userAndLeadSummaryChart = function() {
		$scope.userAndLeadLabel = ["Annual Leave", "Casual Leave", "Remote Work", 
		                           "Medical Leave", "Special Holiday Leave", "Lieu Leave"];
		 $scope.userAndLeadData = [6, 3, 4, 1, 2, 3];
	};	
	
	// get loggedin emp id
	$scope.getLoggedInEmployeeId = function() {
		var def = $q.defer();
		
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/administration/user/currentUser', user)
		.success(function(result) {
			def.resolve(result.employee.empId);
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
	};
	
	// get logged in Emp Hired Date
	$scope.getLoggedInEmpHiredDate = function() {
		var def = $q.defer();
		
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/administration/user/currentUser', user)
		.success(function(result) {
			def.resolve($filter('date')(result.employee.hireDate, "yyyy-MM-dd"));
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
	};
	
	// current year for To Date Max-Date Calculation
	$scope.checkYear = function(addLeaveFromDate) {
		var year = addLeaveFromDate.substring(0,4);
		$scope.maxDateLimitForFromDate = new Date(year + '-12-31');
	};
	
	// check if no of days from the add leave form is not zero or negative
	$scope.checkNoOfDays = function(noOfDays) {
		if(noOfDays > 0) {
			$scope.noOfDaysErrorZeroOrNegative = false;
		}else {
			$scope.noOfDaysErrorZeroOrNegative = true;
		}
	};
	
	// get all available Leave Types
	$scope.getAllLeaveTypes = function() {
		$http.get($scope.baseURL + '/Leave/GetLeaveTypes')
		.success(function(result){
			$scope.leaveTypes = result;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// get Casual Leave Id from Leave Types Table
	$scope.getCasualLeaveTypeId = function() {
		$http.get($scope.baseURL + '/Leave/GetCasualLeaveTypeId')
		.success(function(result){
			$scope.causalLeaveTypeId = result;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// get Medical Leave Id from Leave Types Table
	$scope.getMedicalLeaveTypeId = function() {
		$http.get($scope.baseURL + '/Leave/GetMedicalLeaveTypeId')
		.success(function(result){
			$scope.medicalLeaveTypeId = result;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// get leave type by leave_type_id
	$scope.getLeaveTypeId = function(leave_id) {
		var def = $q.defer();
		
		var leave = {
			leave_type_id : leave_id
		};
		
		$http.post($scope.baseURL + '/Leave/GetLeaveTypeId', leave)
		.success(function(result){
			def.resolve(result.name);
		})
		.error(function(data, status){
			console.log(data);
		});
		
		return def.promise;
	}
	
	// check if No of Days is greater than selected FromDate and To Date
	$scope.checkFromToDateWithNoOfdDays = function(fromDate, toDate, noOfDays) {
		
		var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
		
		var firstDate = new Date(fromDate);
		var secondDate = new Date(toDate);
		
		
		var diffDays = Math.round(Math.abs((secondDate.getTime() - firstDate.getTime())/(oneDay)));
		
		if(noOfDays > diffDays) {
			$scope.noOfDaysError = true;
		} else {
			$scope.noOfDaysError = false;
		}
	};
	
	// check leave count
	$scope.checkLeaveCount = function(addLeaveTypeOfLeave, noOfDays, addLeaveOption) {
		console.log(addLeaveOption);
		// get leave type id
		$scope.getLeaveTypeId(addLeaveTypeOfLeave)
			.then(function(leaveTypeName) {
				// get emp_id of logged in employee
				$scope.getLoggedInEmployeeId()
					.then(function(empId) {
						if(leaveTypeName == "Annual Leave" && addLeaveOption == "Full Day") {
							$scope.maxCasualAndMedicalLeaveError = false;
							$scope.annualLeaveOptionError = false;
							$scope.lieuLeaveOptionError = false;
							$scope.specialLeaveOptionError = false;
							$scope.remoteLeaveOptionError = false;
							
							$scope.getLeaveSumByLeaveTypeAndYear(addLeaveTypeOfLeave, empId)
							.then(function (sum) {
								var availableAnnualLeave = $scope.maxAnnualLeave - sum;
								console.log($scope.maxAnnualLeave);
								
								if(noOfDays > availableAnnualLeave) {
									$scope.maxAnnualLeaveError = true;
								} else {
									$scope.maxAnnualLeaveError = false;
								}
							});
						} else if(leaveTypeName == "Casual Leave" || leaveTypeName == "Medical Leave") {
							$scope.maxAnnualLeaveError = false;
							$scope.annualLeaveOptionError = false;
							$scope.lieuLeaveOptionError = false;
							$scope.specialLeaveOptionError = false;
							$scope.remoteLeaveOptionError = false;
							
							$scope.getLeaveSumByYearForCausalAndMedicalLeaves(empId)
							.then(function (sum) {
								var availableCausalAndMedicalLeaves = 
										$scope.maxCasualAndMedicalLeave - sum;
								
								console.log($scope.maxCasualAndMedicalLeave);
								
								
								if(addLeaveOption == "Full Day") {
									if(noOfDays > availableCausalAndMedicalLeaves) {
										$scope.maxCasualAndMedicalLeaveError = true;
									} else {
										$scope.maxCasualAndMedicalLeaveError = false;
									}
								}
								
								if(addLeaveOption == "Half Day") {
									var calculatedNoOfDays = noOfDays * 0.5;
									if(calculatedNoOfDays > availableCausalAndMedicalLeaves) {
										$scope.maxCasualAndMedicalLeaveError = true;
									} else {
										$scope.maxCasualAndMedicalLeaveError = false;
									}
								}
							});
						} else if(leaveTypeName == "Annual Leave" && addLeaveOption == "Half Day") {
							$scope.annualLeaveOptionError = true;
							$scope.maxCasualAndMedicalLeaveError = false;
							$scope.maxAnnualLeaveError = false;
							$scope.remoteLeaveOptionError = false;
							$scope.specialLeaveOptionError = false;
							$scope.lieuLeaveOptionError = false;
						}  else if(leaveTypeName == "Lieu Leave" && addLeaveOption == "Half Day") {
							$scope.lieuLeaveOptionError = true;
							$scope.annualLeaveOptionError = false;
							$scope.maxCasualAndMedicalLeaveError = false;
							$scope.maxAnnualLeaveError = false;
							$scope.remoteLeaveOptionError = false;
							$scope.specialLeaveOptionError = false;
						} else if (leaveTypeName == "Special Holiday Leave" && addLeaveOption == "Half Day") {
							$scope.specialLeaveOptionError = true;
							$scope.lieuLeaveOptionError = false;
							$scope.annualLeaveOptionError = false;
							$scope.maxCasualAndMedicalLeaveError = false;
							$scope.remoteLeaveOptionError = false;
							$scope.maxAnnualLeaveError = false;
						} else if(leaveTypeName == "Remote Working" && addLeaveOption == "Half Day") {
							$scope.remoteLeaveOptionError = true;
							$scope.specialLeaveOptionError = false;
							$scope.lieuLeaveOptionError = false;
							$scope.annualLeaveOptionError = false;
							$scope.maxCasualAndMedicalLeaveError = false;
							$scope.maxAnnualLeaveError = false;
						}
					});
			});
	};
	
	$scope.getLeaveSumByLeaveTypeAndYear = function(leave_type_id, emp_id) {
		
		var def = $q.defer();
		
		var leave = {
			leaveType : {leave_type_id : leave_type_id},
			employee : {empId : emp_id}
		}
		
		$http.post($scope.baseURL + '/Leave/GetLeaveSumByLeaveTypeAndYear', leave)
		.success(function(result){
			def.resolve(result);
		})
		.error(function(data, status){
			console.log(data);
		});
		
		return def.promise;
	};
	
	// for casual and sick leaves
	$scope.getLeaveSumByYearForCausalAndMedicalLeaves = function(emp_id) {
		
		var def = $q.defer();
		
		var leave = {
			employee : {empId : emp_id}
		}
		
		$http.post($scope.baseURL + '/Leave/GetLeaveSumByYearForCausalAndMedicalLeaves', leave)
		.success(function(result){
			def.resolve(result);
		})
		.error(function(data, status){
			console.log(data);
		});
		
		return def.promise;
	};
	
	$scope.checkDuplicateLeave = function(fromDate, toDate) {
		
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			var leave = {
					employee : {empId : empId},
					leave_from : fromDate,
					leave_to : toDate
				};
				
				$http.post($scope.baseURL + '/Leave/CheckDuplicateLeave', leave)
				.success(function(result){
					$scope.duplicateLeaveResult = result;
					console.log(result);
				})
				.error(function(data, status){
					console.log(data);
				});
		});
		
	};
}]);