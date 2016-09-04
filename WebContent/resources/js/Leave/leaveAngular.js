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
	
	 // set annual leave
	$scope.maxAnnualLeave = 3;
	
	 // set casual and sick leave
	$scope.maxCasualAndMedicalLeave = 0.5;
	
	// called when the page loads
	$scope.init = function () {
		// calls other functions
		$scope.userAndLeadSummaryChart();
		$scope.getAllLeaveTypes();
		$scope.getCasualLeaveTypeId();
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
	
	// current year for To Date Max-Date Calculation
	$scope.checkYear = function(addLeaveFromDate) {
		var year = addLeaveFromDate.substring(0,4);
		$scope.maxDateLimitForFromDate = new Date(year + '-12-31');
	};
	
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
		// get leave type id
		$scope.getLeaveTypeId(addLeaveTypeOfLeave)
			.then(function(leaveTypeName) {
				// get emp_id of logged in employee
				$scope.getLoggedInEmployeeId()
					.then(function(empId) {
						if(leaveTypeName == "Annual Leave" && addLeaveOption == "Full Day") {
							$scope.maxCasualAndMedicalLeaveError = false;
							
							$scope.getLeaveSumByLeaveTypeAndYear(addLeaveTypeOfLeave, empId)
							.then(function (sum) {
								var availableAnnualLeave = $scope.maxAnnualLeave - sum;
								if(noOfDays > availableAnnualLeave) {
									$scope.maxAnnualLeaveError = true;
								} else {
									$scope.maxAnnualLeaveError = false;
								}
							});
						} else if(leaveTypeName == "Casual Leave" || leaveTypeName == "Medical Leave") {
							$scope.maxAnnualLeaveError = false;
							
							$scope.getLeaveSumByYearForCausalAndMedicalLeaves(empId)
							.then(function (sum) {
								var availableCausalAndMedicalLeaves = 
										$scope.maxCasualAndMedicalLeave - sum;
								
								
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
										console.log("TRUE");
									} else {
										$scope.maxCasualAndMedicalLeaveError = false;
									}
								}
							});
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
}]);