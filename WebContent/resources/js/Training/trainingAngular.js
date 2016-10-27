var training = angular.module('training', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

training.controller('trainingMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;
	
	//current date
	var currDate = new Date();
	currDate.setDate(currDate.getDate()-1);
	$scope.currentDate = $filter('date')(currDate, "yyyy-MM-dd");
	
	
	$scope.init = function(){
		// variables
		$scope.checkStartEndDateResult = false;
		$scope.checkForDateRangeResult = false;
		$scope.checkDurationErrorResult = false;
		$scope.checkForMaxCandidatesResult = false;
		$scope.checkForCostResult = false;
		$scope.checkTrainingDuplicateResult = false;
		$scope.checkMaxCandidatesEmpTrainingResult = false;
		$scope.checkEmpTrainingDuplicateResult = false;
		
		// functions
		$scope.getAllTrainings();
		$scope.getAllEmpTrainings();
		$scope.getEmpTrainingEmployees();
		$scope.getEmpTrainingsByEmpId();
	};
	
	// datatable configurations
	// training datatable
	$scope.trainingTableOptions = DTOptionsBuilder.newOptions()
    .withOption('order', [8, 'desc']);
	
	// get logged in emp
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
	
	// get all trainings where expected start or end is current year
	$scope.getAllTrainings = function() {
		// http request for /GetAllTrainings
		$http.get($scope.baseURL + '/Trainings/GetAllTrainingsByYear')
		.success(function(result) {
			$scope.allTrainings = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	/* Add Training Validations Start */
	// check if expected end date is more than expected start date
	$scope.checkStartEndDate = function(startDate, endDate) {
		if(startDate != undefined && endDate != undefined) {
			
			var formattedStartDate = new Date(startDate);
			var formattedEndDate = new Date(endDate);
			
			
			if(formattedStartDate > formattedEndDate) {
				$scope.checkStartEndDateResult = true;
			} else {
				$scope.checkStartEndDateResult = false;
			}
		}
	};
	
	// check for date range
	$scope.checkForDateRange = function(startDate, endDate, duration) {
		
		var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
		
		var firstDate = new Date(startDate);
		var secondDate = new Date(endDate);
		
		// if same day is selected the result is zero
		var diffDays = Math.round(Math.abs((secondDate.getTime() - firstDate.getTime())/(oneDay)));
		
		// therefore add 1
		var actualDiffDays = diffDays + 1;
		
		if(duration > actualDiffDays) {
			$scope.checkForDateRangeResult = true;
		} else {
			$scope.checkForDateRangeResult = false;
		}
	};
	
	// check for duration errors
	$scope.checkDurationError = function(duration) {
		if(duration <= 0) {
			$scope.checkDurationErrorResult = true;
		} else {
			$scope.checkDurationErrorResult = false;
		}
	};
	
	// check for max candidates errors
	$scope.checkForMaxCandidates = function(maxCandidates) {
		if(maxCandidates <= 0 ) {
			$scope.checkForMaxCandidatesResult = true;
		} else {
			$scope.checkForMaxCandidatesResult = false;
		}
	}; 
	
	// check for cost errors
	$scope.checkForCost = function(cost) {
		if(cost < 0) {
			$scope.checkForCostResult = true;
		} else {
			$scope.checkForCostResult = false;
		}
	};
	
	// check for training duplicate
	$scope.checkTrainingDuplicate = function(trainingName, difficultyLevel, type, expStartDate, expEndDate) {
		if(trainingName != undefined && difficultyLevel != undefined && type != undefined && 
				expStartDate != undefined && expEndDate != undefined) {
			
			var training = {
				name: trainingName,
				level_of_difficulty: difficultyLevel,
				type_of_training: type,
				expected_start_date: expStartDate,
				expected_end_date: expEndDate
			};
			
			$http.post($scope.baseURL + '/Trainings/CheckTrainingDuplicate', training)
			.success(function(result) {
				$scope.checkTrainingDuplicateResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	/* Add Training Validations End */
	
	// add new training
	$scope.addTraining = function(name, difficultyLevel, trainingType, expStartDate, 
			expEndDate, duration, trainedBy, maxCandidates, cost, objectives) {
		
		var training = {
			name: name,
			level_of_difficulty: difficultyLevel,
			type_of_training: trainingType,
			duration: duration,
			trained_by: trainedBy,
			max_candidates: maxCandidates,
			cost: cost,
			objective: objectives,
			expected_start_date: expStartDate,
			expected_end_date: expEndDate
		};
			
		$http.post($scope.baseURL + '/Trainings/AddTraining', training)
		.success(function(result) {
			$('#addNewTrainingModal').modal('hide');
			toaster.pop('success', "Notification", "Training Added Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#addNewTrainingModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Training Failed");
			console.log(data);
		});
	};
	
	// get training by training_id
	$scope.getTrainingByTrainingId = function(trainingId) {
		
		var training = {
			training_id: trainingId
		};
		
		$http.post($scope.baseURL + '/Trainings/GetTrainingByTrainingId', training)
		.success(function(result) {
			$scope.updateTrainingName = result.name;
			$scope.updateDifficultyLevel = result.level_of_difficulty;
			$scope.updateTrainingType = result.type_of_training;
			$scope.updateExpStartDate = $filter('date')(result.expected_start_date, "yyyy-MM-dd");
			$scope.updateExpEndDate = $filter('date')(result.expected_end_date, "yyyy-MM-dd");
			$scope.updateDuration = result.duration;
			$scope.updateTrainedBy = result.trained_by;
			$scope.updateMaxCandidates = result.max_candidates;
			$scope.updateCost = result.cost;
			$scope.updateObjectives = result.objective;
			$scope.updateTrainingId = result.training_id;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get max candidates by training_id
	$scope.getMaxCandidatesByTrainingId = function(trainingId) {
		var def = $q.defer();
		
		var training = {training_id: trainingId};
		
		$http.post($scope.baseURL + '/Trainings/GetTrainingByTrainingId', training)
		.success(function(result) {
			def.resolve(result.max_candidates);
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
	};
	
	/* Update Training Validations */
	$scope.checkMaxCandidatesEmpTraining = function(trainingId, maxCandidates) {
		if(trainingId != undefined && maxCandidates != undefined) {
			$scope.getMaxCandidatesByTrainingId(trainingId)
			.then(function(result) {
				var actualMaxCandidates = result;
				
				if(maxCandidates < actualMaxCandidates) {
					$scope.checkMaxCandidatesEmpTrainingResult = true;
				} else {
					$scope.checkMaxCandidatesEmpTrainingResult = false;
				}
			})
		}
	};
	
	// update training information
	$scope.updateTraining = function(trainingId, name, difficultyLevel, trainingType, expStartDate, 
			expEndDate, duration, trainedBy, maxCandidates, cost, objectives) {
		
		var training = {
				training_id: trainingId,
				name: name,
				level_of_difficulty: difficultyLevel,
				type_of_training: trainingType,
				duration: duration,
				trained_by: trainedBy,
				max_candidates: maxCandidates,
				cost: cost,
				objective: objectives,
				expected_start_date: expStartDate,
				expected_end_date: expEndDate
			};
				
			$http.post($scope.baseURL + '/Trainings/UpdateTraining', training)
			.success(function(result) {
				$('#updateTrainingModal').modal('hide');
				toaster.pop('success', "Notification", "Training Updated Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 1000);
			})
			.error(function(data, status) {
				$('#updateTrainingModal').modal('hide');
				toaster.pop('error', "Notification", "Training Updation Failed");
				console.log(data);
			});
	};
	
	// delete training
	$scope.deleteTrainingMain = function(trainingId) {
		$scope.deleteTrainingId = trainingId;
	};
	
	// actually sends the request to delete training
	$scope.deleteTraining = function(trainingId) {
		var training = {
			training_id: trainingId,
		};
				
		$http.post($scope.baseURL + '/Trainings/DeleteTraining', training)
		.success(function(result) {
			$('#deleteTrainingModal').modal('hide');
			toaster.pop('success', "Notification", "Training Deleted Successfully");
			setTimeout(function () {
	               window.location.reload();
	        }, 1000);
		 })
		.error(function(data, status) {
			$('#deleteTrainingModal').modal('hide');
			toaster.pop('error', "Notification", "Training Deletion Failed");
			console.log(data);
		});
	};
	
	/* Employee Trainings */
	
	// get all emp trainings where expected start or end is current year
	$scope.getAllEmpTrainings = function() {
		// http request for /GetAllEmpTrainings
		$http.get($scope.baseURL + '/Trainings/GetAllEmpTrainingsByYear')
		.success(function(result) {
			$scope.allEmpTrainings = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all emp training employees
	$scope.getEmpTrainingEmployees = function() {
		$http.get($scope.baseURL + '/Training/GetEmpTrainingEmployees')
		.success(function(result) {
			$scope.allEmpTrainingEmployees = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// check for duplicate emp training
	$scope.checkEmpTrainingDuplicate = function(empId, trainingId) {
		if(empId != undefined && trainingId != undefined) {
			var empTraining = {
				training: {training_id: trainingId},
				employee: {empId: empId}
			};
			
			$http.post($scope.baseURL + '/Training/CheckEmpTrainingDuplicate', empTraining)
			.success(function(result) {
				$scope.checkEmpTrainingDuplicateResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	
	// check for emp training availability
	$scope.checkEmpTrainingAvailability = function(trainingId) {
		if(trainingId != undefined) {
			var empTraining = {
				training: {training_id: trainingId}
			};
			
			$http.post($scope.baseURL + '/Training/CheckEmpTrainingAvailability', empTraining)
			.success(function(result) {
				$scope.checkEmpTrainingAvailabilityResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	
	// add emp training
	$scope.addEmpTraining = function(empId, trainingId) {
		var empTraining = {
			training: {training_id: trainingId},
			employee: {empId: empId},
			status: "Pending"
		};
		
		$http.post($scope.baseURL + '/Training/AddEmpTraining', empTraining)
		.success(function(result) {
			$('#addNewEmpTrainingModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Training Added Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#addNewEmpTrainingModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Employee Training Failed");
			console.log(data);
		});
	};
	
	// get emp training info by emp_training_id
	$scope.getEmpTrainingByEmpTrainingId = function(empTrainingId) {
		
		var empTraining = {
			emp_training_id: empTrainingId
		};
		
		$http.post($scope.baseURL + '/Training/GetEmpTrainingByEmpTrainingId', empTraining)
		.success(function(result) {
			$scope.updateEmpTraining_Id = result.training.training_id;
			$scope.updateEmpTrainingEmp = result.employee.empId;
			$scope.updateEmpTrainingId = result.emp_training_id;
			$scope.updateEmpTrainingStatus = result.status;
			$scope.updateEmpTrainingActStartDate = $filter('date')(result.actual_start_date, "yyyy-MM-dd");
			$scope.updateEmpTrainingActEndDate = $filter('date')(result.actual_end_date, "yyyy-MM-dd");
			
			if(result.remarks == null)
				$scope.updateEmpTrainingRemarks = "";
			else 
				$scope.updateEmpTrainingRemarks = result.remarks;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update emp training info
	$scope.updateEmpTraining = function(empTrainingId, remarks) {
		var empTraining = {
			emp_training_id: empTrainingId,
			remarks: remarks
		};
		
		$http.post($scope.baseURL + '/Training/UpdateEmpTraining', empTraining)
		.success(function(result) {
			$('#updateEmpTrainingModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Training Updated Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#updateEmpTrainingModal').modal('hide');
			toaster.pop('error', "Notification", "Employee Training Updation Failed");
			console.log(data);
		});
	};
	
	// called from empTrainings.jsp
	$scope.deleteEmpTrainingMain = function(empTrainingId) {
		$scope.deleteEmpTrainingId = empTrainingId;
	};
	
	// actually deletes the emp training
	$scope.deleteEmpTraining = function(empTrainingId) {
		
		var empTraining = {
			emp_training_id: empTrainingId,
		};
		
		$http.post($scope.baseURL + '/Training/DeleteEmpTraining', empTraining)
		.success(function(result) {
			$('#deleteEmpTrainingModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Training Deleted Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#deleteEmpTrainingModal').modal('hide');
			toaster.pop('error', "Notification", "Employee Training Deletion Failed");
			console.log(data);
		});
	};
	
	/* User and Lead View */
	
	// get emp trainings by empId
	$scope.getEmpTrainingsByEmpId = function(){
		$scope.getLoggedInEmployee().then(function(employee) {
			var empTraining = {
				employee: {empId: employee.empId}
			};
			
			$http.post($scope.baseURL + '/Training/GetEmpTrainingByEmpId', empTraining)
			.success(function(result) {
				$scope.myEmpTrainings = result;
				console.log(result);
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	};
	
	// update user emp training
	$scope.updateUserEmpTraining = function(empTrainingId, status, actStartDate, actEndDate) {
		
		console.log(actStartDate + " " + actEndDate);
		
		var empTraining = {
			emp_training_id: empTrainingId,
			status: status,
			actual_start_date: actStartDate,
			actual_end_date: actEndDate
		};
		
		$http.post($scope.baseURL + '/Training/UpdateUserEmpTraining', empTraining)
		.success(function(result) {
			$('#updateEmpTrainingModalUser').modal('hide');
			toaster.pop('success', "Notification", "Training Updated Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#updateEmpTrainingModalUser').modal('hide');
			toaster.pop('error', "Notification", "Training Updation Failed");
			console.log(data);
		});
	};
}]);