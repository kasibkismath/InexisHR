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
		
		// functions
		$scope.getAllTrainings();
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
	
	// get trainings where expected start or end is current year
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
			if(startDate > endDate) {
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
}]);