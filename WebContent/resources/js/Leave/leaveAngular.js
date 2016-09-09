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

	$scope.fromLeaveDate = new Date();
	
	// initialize errors
	$scope.remoteLeaveOptionError = false;
	$scope.specialLeaveOptionError = false;
	$scope.lieuLeaveOptionError = false;
	$scope.annualLeaveOptionError = false;
	$scope.maxCasualAndMedicalLeaveError = false;
	$scope.maxAnnualLeaveError = false;
	$scope.duplicateLeaveResult = false  
	$scope.noOfDaysError =false
	$scope.noOfDaysErrorZeroOrNegative = false
	
	// disble edit leave modal items for CEO
	$scope.disabledCEOEditLeave = true;
	
	// called when the page loads
	$scope.init = function () {
		// calls other functions
		$scope.userAndLeadSummaryChart();
		$scope.getAllLeaveTypes();
		$scope.getCasualLeaveTypeId();
		$scope.getMedicalLeaveTypeId();
		$scope.getLeavesForLoggedInEmployeeByYear();
		$scope.getPendingLeaveCountByYear();
		$scope.getAvailableLeavesByYear();
		$scope.getAllLeavesByYear();
		$scope.ceoLeaveSummary();
		$scope.getPendingLeaveCountByYearForCEO();
		
		// set datatable configs
		 // user datatable
		$scope.dtOptionsUser = DTOptionsBuilder.newOptions()
	    .withOption('order', [1, 'desc']);
		
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
				$scope.maxAnnualLeave = 14;
				
				 // set casual and sick leave
				$scope.maxCasualAndMedicalLeave = 7;
			}
			
		});
	};
	
	// user and lead chart
	$scope.userAndLeadSummaryChart = function() {
		
		$scope.userAndLeadLabel = [];
		$scope.userAndLeadData = [];
		 
		 $scope.getLoggedInEmployeeId()
			.then(function(empId) {
				
				var leave = {
					employee : {empId : empId}
				};
				
				$http.post($scope.baseURL + '/Leave/GetLeaveTypeSumByYear', leave)
				.success(function(result){
					angular.forEach(result, function(value, key) {
						$scope.userAndLeadLabel.push(value[0]);
						$scope.userAndLeadData.push(value[1]);
					});
				})
				.error(function(data, status){
					console.log(data);
				});
			});
	};
	
	$scope.ceoLeaveSummary = function() {
		$scope.ceoLabels = [];
		$scope.ceoSeries = ['Annual Leave', 'Casual Leave', 'Medical Leave'];
		$scope.ceoData = [[], [], []];
		
		$http.get($scope.baseURL + '/Leave/GetLeaveSummaryForCEO')
		.success(function(result) {
			angular.forEach(result, function(value, key) {
				$scope.ceoLabels.push(value[0]);
				$scope.ceoData[0].push(value[1]);
				$scope.ceoData[1].push(value[2]);
				$scope.ceoData[2].push(value[3]);
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get loggedin emp
	$scope.getLoggedInEmployee = function() {
		var def = $q.defer();
		
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/administration/user/currentUser', user)
		.success(function(result) {
			def.resolve(result.employee);
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
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
						} else {
							$scope.remoteLeaveOptionError = false;
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
	
	// checks for duplicate leaves for an employee within the given date range
	$scope.checkDuplicateLeave = function(fromDate, toDate) {
		
		if(fromDate != undefined && toDate != undefined) {
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
					})
					.error(function(data, status){
						console.log(data);
					});
			});
		} else {
			$scope.duplicateLeaveResult = false;
		}
	};
	
	// get leaves for logged in employee by current year
	$scope.getLeavesForLoggedInEmployeeByYear = function() {
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			var leave = {
				employee : {empId : empId}
			};
			
			$http.post($scope.baseURL + '/Leave/GetLeavesForLoggedInEmployee', leave)
			.success(function(result){
				$scope.leavesForLoggedInEmployee = result;
			})
			.error(function(data, status){
				console.log(data);
			});
		});
	};
	
	// add new leave
	$scope.addLeave = function(typeOfLeave, fromDate, toDate, noOfDays, leaveOption, leaveReason) {
		
		var actualNoOfDays;
		var defaultStatus = "Pending";
		
		if(leaveOption == "Full Day") {
			actualNoOfDays = noOfDays.toFixed(1);
			
		} else if (leaveOption == "Half Day") {
			var calculatedNoOfDays = 0.5 * noOfDays;
			actualNoOfDays = calculatedNoOfDays.toFixed(1);
		}
		
		// get the currently logged in EmpId
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			$scope.getLeaveTypeId(typeOfLeave)
			.then(function(leaveName) {
				$scope.getLoggedInEmployee()
				.then(function(employee) {
					var newLeave = {
							employee : {empId : empId, firstName : employee.firstName, lastName : employee.lastName},
							leaveType : {leave_type_id : typeOfLeave, name : leaveName},
							leave_from : fromDate,
							leave_to : toDate,
							leave_option : leaveOption,
							no_days : actualNoOfDays,
							status : defaultStatus,
							reason : leaveReason
						};
						
						// send add leave request
						$http.post($scope.baseURL + '/Leave/AddLeave', newLeave)
						.success(function(result){
							$('#addLeaveModal').modal('hide');
							
							// send mail request
							$scope.sendLeaveRequestMail(newLeave);
							toaster.pop('success', "Notification", "Leave Applied Successfully");
							setTimeout(function () {
				                window.location.reload();
				            }, 3000);
						})
						.error(function(data, status){
							$('#addLeaveModal').modal('hide');
							toaster.pop('error', "Notification", "Leave Applied Failed");
							console.log(data);
						});
				});
			});
		});
	};
	
	// send leave request notification
	$scope.sendLeaveRequestMail = function(leave) {
		$http.post($scope.baseURL + '/Leave/SendLeaveRequestMail', leave)
		.success(function(result){
		})
		.error(function(data, status){
			toaster.pop('error', "Notification", "Leave Request Email Failed");
			console.log(data);
		});
	};
	
	// get leave details by leave_id
	$scope.getLeaveByLeaveId = function(leaveId) {
		
		var def = $q.defer();
		
		var leave = {
			leave_id : leaveId
		};
		
		$http.post($scope.baseURL + '/Leave/GetLeaveByLeaveId', leave)
		.success(function(result){
			def.resolve(result);
			$scope.editLeaveTypeOfLeave = result.leaveType.leave_type_id;
			$scope.editLeaveFromDate = $filter('date')(result.leave_from, "yyyy-MM-dd");
			$scope.editLeaveToDate = $filter('date')(result.leave_to, "yyyy-MM-dd");
			$scope.editNoOfDays = result.no_days;
			$scope.editLeaveOption = result.leave_option;
			$scope.editLeaveReason = result.reason;
			$scope.editLeaveId = result.leave_id;
			$scope.editLeaveStatus = result.status;
			
			if($scope.editNoOfDays == 0.5) {
				$scope.editNoOfDays = 1;
			} else {
				$scope.editNoOfDays = result.no_days;
			}
			
			var status = result.status;
			
			if(status == 'Rejected' || status == 'Approved')
				$scope.disableLeaveForm = true;
			else 
				$scope.disableLeaveForm = false;
		})
		.error(function(data, status){
			console.log(data);
		});
		return def.promise;
	};
	
	$scope.updateLeave = function(typeOfLeave, fromDate, toDate, noOfDays, leaveOption, leaveReason, leaveId) {
		
		var actualNoOfDays;
		var defaultStatus = "Pending";
		
		if(leaveOption == "Full Day") {
			actualNoOfDays = noOfDays.toFixed(1);
			
		} else if (leaveOption == "Half Day") {
			var calculatedNoOfDays = 0.5 * noOfDays;
			actualNoOfDays = calculatedNoOfDays.toFixed(1);
		}
		
		// get the currently logged in EmpId
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			$scope.getLeaveTypeId(typeOfLeave)
			.then(function(leaveName) {
				$scope.getLoggedInEmployee()
				.then(function(employee) {
					
					var updatedLeave = {
							employee : {empId : empId, firstName : employee.firstName, lastName : employee.lastName},
							leaveType : {leave_type_id : typeOfLeave, name : leaveName},
							leave_id : leaveId,
							leave_from : fromDate,
							leave_to : toDate,
							leave_option : leaveOption,
							no_days : actualNoOfDays,
							status : defaultStatus,
							reason : leaveReason
						};
						
						// send add leave request
						$http.post($scope.baseURL + '/Leave/UpdateLeave', updatedLeave)
						.success(function(result){
							$('#editLeaveModal').modal('hide');
							
							// send mail update leave request
							$scope.sendUpdatedLeaveRequestMail(updatedLeave);
							toaster.pop('success', "Notification", "Leave Updated Successfully");
							setTimeout(function () {
				                window.location.reload();
				            }, 3000);
						})
						.error(function(data, status){
							$('#editLeaveModal').modal('hide');
							toaster.pop('error', "Notification", "Leave Updation Failed");
							console.log(data);
						});
				});
			});
		});
	};
	
	// send leave update request notification
	$scope.sendUpdatedLeaveRequestMail = function(leave) {
		$http.post($scope.baseURL + '/Leave/SendUpdatedLeaveRequestMail', leave)
		.success(function(result){
		})
		.error(function(data, status){
			toaster.pop('error', "Notification", "Updated Leave Request Email Failed");
			console.log(data);
		});
	};
	
	$scope.deleteLeaveMain = function(leave_id, typeOfLeave, leaveFrom, leaveTo, leaveOption, leaveReason) {
		
		// get leave status
		$scope.getLeaveByLeaveId(leave_id);
		
		// set leave_id and other params in delete leave modal
		$scope.deleteLeaveId = leave_id;
		$scope.deleteLeaveType = typeOfLeave;
		$scope.deleteLeaveFrom = $filter('date')(leaveFrom, "yyyy-MM-dd");
		$scope.deleteLeaveTo = $filter('date')(leaveTo, "yyyy-MM-dd");;
		$scope.deleteLeaveOption = leaveOption;
		$scope.deleteLeaveReason = leaveReason;
	};
	
	$scope.deleteLeave = function(leave_id, typeOfLeave, leaveFrom, leaveTo, leaveOption, leaveReason) {
		
		$scope.getLoggedInEmployee()
		.then(function(employee) {
			
			var leave = {
					leave_id : leave_id,
					employee : {firstName : employee.firstName, lastName : employee.lastName},
					leaveType : {name : typeOfLeave},
					leave_from : leaveFrom,
					leave_to : leaveTo,
					leave_option : leaveOption,
					reason : leaveReason
				};
				
				// send delete leave request
				$http.post($scope.baseURL + '/Leave/DeleteLeave', leave)
				.success(function(result){
					$('#deleteLeaveModal').modal('hide');
					
					// send delete leave mail
					$scope.sendDeleteLeaveRequestMail(leave);
					
					toaster.pop('success', "Notification", "Leave Deleted Successfully");
					setTimeout(function () {
		                window.location.reload();
		            }, 3000);
				})
				.error(function(data, status){
					$('#deleteLeaveModal').modal('hide');
					toaster.pop('error', "Notification", "Leave Deletion Failed");
					console.log(data);
				});
		});
	};
	
	// send leave delete request notification
	$scope.sendDeleteLeaveRequestMail = function(leave) {
		$http.post($scope.baseURL + '/Leave/SendDeleteLeaveRequestMail', leave)
		.success(function(result){
		})
		.error(function(data, status){
			toaster.pop('error', "Notification", "Delete Leave Request Email Failed");
			console.log(data);
		});
	};
	
	/* ---------------- Summary Page Codes ---------------------- */
	
	// leaves Pending sum
	$scope.getPendingLeaveCountByYear = function(){
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			
			var leave = {
				employee : {empId : empId}
			};
			
			$http.post($scope.baseURL + '/Leave/GetPendingLeaveCountByYear', leave)
			.success(function(result){
				$scope.sumOfPendingLeaves = result;
			})
			.error(function(data, status){
				console.log(data);
			});
		});
	};
	
	// leaves Pending sum For CEO
	$scope.getPendingLeaveCountByYearForCEO = function(){
		$http.get($scope.baseURL + '/Leave/GetPendingLeaveCountByYearForCEO')
		.success(function(result){
			$scope.sumOfPendingLeavesForCEO = result;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// available leaves
	$scope.getAvailableLeavesByYear = function() {
		$scope.getLoggedInEmployeeId()
		.then(function(empId) {
			
			var leave = {
				employee : {empId : empId}
			};
			
			$http.post($scope.baseURL + '/Leave/GetApprovedLeaveCountByYear', leave)
			.success(function(result){
				var noOfLeavesTaken = result;
				$scope.availableLeaves = ($scope.maxAnnualLeave + $scope.maxCasualAndMedicalLeave) - noOfLeavesTaken;
			})
			.error(function(data, status){
				console.log(data);
			});
		});
	};
	
	/* ----------------- CEO Leave ----------------------- */
	$scope.getAllLeavesByYear = function() {
		$http.get($scope.baseURL + '/Leave/GetAllLeavesByYear')
		.success(function(result){
			$scope.allLeavesByYear = result;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	$scope.updateLeaveStatus = function(leave_id, leaveStatus) {
		
		var leave = {
			leave_id : leave_id,
			status : leaveStatus
		};
		
		$scope.getLeaveByLeaveId(leave_id)
		.then(function(returnedLeave) {
			
			var modifiedReturnedLeave = {
					leave_id : returnedLeave.leave_id,
					employee : {firstName : returnedLeave.employee.firstName, lastName : returnedLeave.employee.lastName},
					leaveType : {name : returnedLeave.leaveType.name},
					leave_from : returnedLeave.leave_from,
					leave_to : returnedLeave.leave_to,
					leave_option : returnedLeave.leave_option,
					reason : returnedLeave.reason,
					status : leaveStatus
			};
			
			$http.post($scope.baseURL + '/Leave/UpdateLeaveStatus', leave)
			.success(function(result){
				
				$('#ceoEditLeaveModal').modal('hide');
				
				// send leave status update mail
				$scope.sendLeaveStatusUpdateMail(modifiedReturnedLeave);
				
				toaster.pop('success', "Notification", "Leave Status Updated Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 3000);
			})
			.error(function(data, status){
				$('#ceoEditLeaveModal').modal('hide');
				toaster.pop('error', "Notification", "Leave Status Updation Failed");
				console.log(data);
			});
		})
	};
	
	// send leave status update mail
	$scope.sendLeaveStatusUpdateMail = function(leave) {
		$http.post($scope.baseURL + '/Leave/SendLeaveStatusUpdateMail', leave)
		.success(function(result){
		})
		.error(function(data, status){
			toaster.pop('error', "Notification", "Leave Status Update Email Failed");
			console.log(data);
		});
	};
	
	
	$scope.deleteLeaveByCEO = function(leave_id) {
		
		var leave = {
			leave_id : leave_id
		};
		
		$scope.getLeaveByLeaveId(leave_id)
		.then(function(returnedLeave) {
	
			var modifiedReturnedLeave = {
				leave_id : returnedLeave.leave_id,
				employee : {firstName : returnedLeave.employee.firstName, lastName : returnedLeave.employee.lastName},
				leaveType : {name : returnedLeave.leaveType.name},
				leave_from : returnedLeave.leave_from,
				leave_to : returnedLeave.leave_to,
				leave_option : returnedLeave.leave_option,
				reason : returnedLeave.reason,
			};
				
			// send delete leave request
			$http.post($scope.baseURL + '/Leave/DeleteLeave', leave)
			.success(function(result){
				$('#ceoDeleteLeaveModal').modal('hide');
					
				// send delete leave mail
				$scope.sendDeleteLeaveRequestMail(modifiedReturnedLeave);
					
				toaster.pop('success', "Notification", "Leave Deleted Successfully");
				setTimeout(function () {
		          window.location.reload();
		        }, 3000);
			})
			.error(function(data, status){
				$('#ceoDeleteLeaveModal').modal('hide');
				toaster.pop('error', "Notification", "Leave Deletion Failed");
				console.log(data);
			});
		});
	};
	
}]);