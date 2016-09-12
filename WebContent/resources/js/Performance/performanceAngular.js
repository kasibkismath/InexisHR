var performance = angular.module('performance', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables']);

// Controllers
performance.controller('performanceMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                     'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                     'DTColumnBuilder',
                                                     function($scope, $http, $q, toaster, $filter, DTOptionsBuilder, DTColumnDefBuilder, DTColumnBuilder) {
	
	// initializations
	$scope.currentUser = currentUser;
	$scope.baseURL = contextPath;
	$scope.currentUserRole = currentUserRole;
	
	// performance id from Performance
	$scope.peformance_id = 0;
	
	// init method when page loads
	$scope.init = function() {
		$scope.getAppraisalYears();
		$scope.getAllEmployees();
		$scope.getScoreValues();
		$scope.getAllPerformanceAppraisals();
		$scope.getLeadAppraisals();
		$scope.getLoggedInEmployee()
			.then(function(result) {
				$scope.loggedInEmpId = result;
				$scope.getTeamEmployeesByLeadId(result);
				//$scope.getLeadAppraisalsByLeadId(result);
				// get team by current logged in user team lead id, user role is ROLE_LEAD
				if($scope.currentUserRole === '[ROLE_LEAD]')
					$scope.getTeamsByLeadId(result);
				$scope.leadAppraisalsDataTable(result);
				$scope.summaryChartLead(result);
			});
		$scope.summaryChartCEO();
		$scope.summaryChartHR();
		$scope.getHRAppraisals();
		$scope.getCEOAppraisals();
	 };
	
	// ceo summary chart configs
	$scope.summaryChartCEO = function() {
		$scope.ceoLabels = [];
		$scope.ceoSeries = [];
		$scope.ceoData = [[], []];
		
		var currentYear = new Date().getFullYear();
		var perviousYear = currentYear - 1;
		
		$scope.ceoSeries.push(currentYear);
		$scope.ceoSeries.push(perviousYear);
		
		var currentYearDate = currentYear + '-12-31';
		
		var performance = {
			date : currentYearDate	
		};
		
		$http.post($scope.baseURL + '/Performance/GetFinalScoreEmployeeByCEO', performance)
		.success(function(result) {
			angular.forEach(result, function(value, key) {
				$scope.ceoLabels.push(value[0]);
				$scope.ceoData[0].push(value[2])
				$scope.ceoData[1].push(value[1])
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
		
		// Lead summary chart configs
		$scope.summaryChartLead = function(emp_lead_id) {
			$scope.leadLabels = [];
			$scope.leadSeries = [];
			$scope.leadData = [[], []];
			
			var currentYear = new Date().getFullYear();
			var perviousYear = currentYear - 1;
			
			$scope.leadSeries.push(currentYear);
			$scope.leadSeries.push(perviousYear);
			
			var currentYearDate = currentYear + '-12-31';
			
			var team = {
				employee : {empId : emp_lead_id}
			};
			
			var performance = {
				date : currentYearDate	
			};
			
			var data = {
			   team : team,
			   performance : performance
			};
			
			$http.post($scope.baseURL + '/Performance/GetTotalScoresByLeadId', data)
			.success(function(result) {
				angular.forEach(result, function(value, key) {
					$scope.leadLabels.push(value[0]);
					$scope.leadData[0].push(value[2])
					$scope.leadData[1].push(value[1])
				});
			})
			.error(function(data, status) {
				console.log(data);
			});
			
		};
		
		// Lead Appraisals By Lead Id Data Table
		 $scope.leadAppraisalsDataTable = function(emp_lead_id){
			 
			 $scope.getLeadAppraisalsByLeadId(emp_lead_id);
		 };
		
		// summary HR Total Scores 
		$scope.summaryChartHR = function() {
			$scope.hrLabels = [];
			$scope.hrSeries = [];
			$scope.hrData = [[], []];
			
			var currentYear = new Date().getFullYear();
			var perviousYear = currentYear - 1;
			
			$scope.hrSeries.push(currentYear);
			$scope.hrSeries.push(perviousYear);
			
			var currentYearDate = currentYear + '-12-31';
			
			var performance = {
				date : currentYearDate	
			};
			
			$http.post($scope.baseURL + '/Performance/GetTotalScoresByHR', performance)
			.success(function(result) {
				angular.forEach(result, function(value, key) {
					$scope.hrLabels.push(value[0]);
					$scope.hrData[0].push(value[2])
					$scope.hrData[1].push(value[1])
				});
			})
			.error(function(data, status) {
				console.log(data);
			});
		};
	
	  // list appraisal year
	  $scope.getAppraisalYears = function() {
		  var startYear = '2011';
		  var endYear = new Date().getFullYear();
		  $scope.years = [];
		  
		  for(var i=startYear; i<=endYear; i++) {
			  $scope.years.push(i);
		  }; 
		  
		  // reverse array to list from the current year
		  $scope.years.reverse();
	  }
	  
	  // list score values
	  $scope.getScoreValues = function() {
		  var minScore = 1;
		  var maxScore = 10;
		  $scope.scoreValues = [];
		  
		  for(var i=minScore; i<=maxScore; i++) {
			  $scope.scoreValues.push(i);
		  }; 
	  };
	  
	// get all employees
	$scope.getAllEmployees = function() {
		$http.get($scope.baseURL + '/employeeProfile/employee/all')
		.success(function(result) {
			$scope.employees = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get the emp id of the currently logged in employee
	$scope.getLoggedInEmployee = function() {
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
	
	// get all performance_appraisals
	$scope.getAllPerformanceAppraisals = function (){
		$http.get($scope.baseURL + '/Performance/AllPerformanceAppraisals')
		.success(function(result) {
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
	// check if appraisal year is more than or equal to the hired date
	 $scope.checkAppraisalYear = function (empId, year) {
		 
		 console.log(empId, year);
		 
		 var appraisalYear =  new Date(year + "-12-31");
		 
		 var data = {
			empId : empId
		 };
		 
		 $http.post($scope.baseURL + '/Performance/CheckAppraisalYear', data)
		 .success(function(result) {
			 
				var hiredDate = new Date($filter('date')(result.hireDate, "yyyy-MM-dd"));
				
				$scope.appraisalYearResult = false;
				
				if(appraisalYear >= hiredDate) {
					$scope.appraisalYearResult = true;
				} else {
					$scope.appraisalYearResult = false;
				}
			})
			.error(function(data, status) {
				console.log(data);
			})
	 };
	 
	// get performance id, $q and defer is used to return the http request result
		$scope.getPerformanceId = function (performanceObj) {
			var def = $q.defer();
			
			 $http.post($scope.baseURL + '/Performance/getPerformanceId', performanceObj)
			.success(function(result) {
				def.resolve(result.performance_id);
			})
			.error(function(data, status) {
				console.log(data);
			});
			return def.promise;
	};
	
	// add performance
	$scope.addPeformance = function(empId, date) {
		
		var def = $q.defer();
		
		var status = "In-Progress";
		
		var performance = {
			employee : {empId : empId },
			date : date,
			status : status
		};
		
		$http.post($scope.baseURL + '/Performance/AddPerformance', performance)
		.success(function(result) {
			def.resolve(result)
			toaster.pop('success', "Notification", "Added Performance");
		})
		.error(function(data, status) {
			console.log(data);
			toaster.pop('error', "Notification", "Adding Performance Failed");
		});
		return def.promise;
	};
	
	// get user role for a given emp id
	$scope.getUserRoleByEmpId = function (emp_id) {
		var def = $q.defer();
		
		var emp = {
			empId : emp_id
		};
		
		$http.post($scope.baseURL + '/Performance/GetUserRoleByEmpId', emp)
		 .success(function(result) {
			 def.resolve(result.authority);
			 $scope.userRoleByEmpId = result.authority;
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
		return def.promise;
	};
	
	//update performance details with final_score and status
	$scope.updatePerformance = function(performance_id, final_score, status) {
		
		// construct json object with performance parameters
		var performance = {
			performance_id : performance_id,
			final_score : final_score,
			status : status
		};
		
		$http.post($scope.baseURL + '/Performance/UpdatePerformanceFinalScoreAndStatus', performance)
		 .success(function(result) {
			console.log("Performance Updated With Final Score And Status Info");
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
	};
	
	//get sum of total score from Team Lead Appraisal, HR Appraisal And CEO Appraisal
	$scope.finalScoreCalculation = function(emp_id, year, performance_id) {
		
		var def = $q.defer();
		
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		// appraisal object
		var appraisal = {
			performance_id : performance_id,
			employee : {empId : emp_id},
			date : date
		};
		
		// send get total score request with required parameters
		$http.post($scope.baseURL + '/Performance/FinalScoreCalculation', appraisal)
		.success(function(result) {
			var roundedValue = Math.round(result);
			def.resolve(roundedValue);
			console.log(roundedValue);
		})
		.error(function(data, status) {
			console.log(data);
		});
		return def.promise;
	};
	
	// get all appraisals by lead id
	$scope.getLeadAppraisalsByLeadId = function(lead_id) {
		var data = {
			employee : {empId : lead_id}
		};
		
		$http.post($scope.baseURL + '/Performance/GetLeadAppraisalsByLeadId', data)
		.success(function(result) {
			// initialize array
			$scope.leadAppraisalsByLeadId = [];
			
			// for each element in the array, insert the first object in the element.
			angular.forEach(result, function(value, key) {
				$scope.leadAppraisalsByLeadId.push(value[0]);
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all HR Appraisals
	$scope.getHRAppraisals = function() {
		$http.get($scope.baseURL + '/Performance/GetHRAppraisals')
		.success(function(result) {
			$scope.hrAppraisals = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all CEO Appraisals with final score
	$scope.getCEOAppraisals = function() {
		$http.get($scope.baseURL + '/Performance/GetCEOAppraisals')
		.success(function(result) {
			$scope.ceoAppraisals = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
	/* ------------------------------------- CEO Appraisal ------------------------ */
	
	// check if HR Appraisal Exists for the given emp_id except the HR Manager
	$scope.checkHRAppraisalExists = function(emp_id, year) {
		
		var def = $q.defer();
		
		// initialize date to the last day of the given year 
		var date = year + '-12-31';
		
		var hrAppraisal = {
			employee : {empId : emp_id},
			performance : {date : date}
		};
		
		var emp = {
		    empId : emp_id
		}
		
		var checkHRAppraisalExistsData = {
			hr_appraisal : hrAppraisal,
			emp : emp
		}
		
		$http.post($scope.baseURL + '/Performance/CheckHRAppraisalExists', checkHRAppraisalExistsData)
		.success(function(result) {
			def.resolve(result);
			$scope.checkHRAppraisalExistsResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
		
		return def.promise;
		
	};
	
	$scope.checkCEOAppraisalExists = function(emp_id, year) {
		
		var def = $q.defer();
		
		// initialize date to the last day of the given year 
		var date = year + '-12-31';
		
		var data = {
			employee : {empId : emp_id},
			performance : {date : date}
		}
		
		$http.post($scope.baseURL + '/Performance/CheckDuplicateCEOAppraisal', data)
		.success(function(result) {
			$scope.checkCEOAppraisalExistsResult = result;
			def.resolve(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
		return def.promise;
	};
	
	
	// add CEO Appraisal
	$scope.addCEOAppraisal = function(emp_id, year, status, score_skill, score_mentor, score_task,
			score_performance, description){
		
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		// performance object
		var performance = {
			employee : {empId : emp_id},
			date: date,
			status: status
		};
		
		// covert string scores to integer
		var int_score_skill = parseInt(score_skill);
		var int_score_mentor = parseInt(score_mentor);
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		var total_score = int_score_skill + int_score_mentor + int_score_task + int_score_performance;
		
		
		// check if performance exists for this employee
		$http.post($scope.baseURL + '/Performance/CheckPerformanceExists', performance)
		.success(function(result) {
		// if exists get the performance id
			if(result) {
				$scope.getPerformanceId(performance)
				.then(function (result) {
					var performance_id = result;
					
					$scope.addAppraisalCEO(emp_id, performance_id, status, score_skill, score_mentor, 
							score_task, score_performance, description, total_score)
							.then(function (result) {
								$scope.finalScoreCalculation(emp_id, year, performance_id)
								.then(function (result) {
									
									var final_score = result;
									
									// update performance details with final_score and status
									$scope.updatePerformance(performance_id, final_score, status);
									
								});
							});
				});
			// if performance does not exists create performance 
			} else {
				$scope.addPeformance(emp_id, date)
				.then(function (result) {
					// performance_id of newly created object
					var performance_id = result;
					
					$scope.addAppraisalCEO(emp_id, performance_id, status, score_skill, score_mentor, 
							score_task, score_performance, description, total_score)
							.then(function (result) {
								$scope.finalScoreCalculation(emp_id, year, performance_id)
								.then(function (result) {
									
									var final_score = result;
									
									// update performance details with final_score and status
									$scope.updatePerformance(performance_id, final_score, status);
									
								});
							});
				});
			}
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// add appraisal CEO Sub
	$scope.addAppraisalCEO = function (emp_id, performance_id, status, score_skill, score_mentor,
			score_task, score_performance, description, total_score) {
		
		var def = $q.defer();
		
		var ceo_appraisal = {
			employee : {empId : emp_id},
			performance : {performance_id : performance_id},
			status : status,
			score_skill : score_skill,
			score_mentorship : score_mentor,
			score_task_completion : score_task,
			score_current_performance : score_performance,
			total_score : total_score,
			description: description
		};
		
		$http.post($scope.baseURL + '/Performance/AddCEOAppraisal', ceo_appraisal)
		.success(function(result) {
			def.resolve(result);
			$('#CEOAddAppraisal').modal('hide');
			toaster.pop('success', "Notification", "Added Appraisal Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 3000);
		})
		.error(function(data, status) {
			console.log(data);
			$('#CEOAddAppraisal').modal('hide');
			toaster.pop('error', "Notification", "Adding Appsaisal Failed");
		});
		
		return def.promise;
	};
	
	/* --------------- CEO Appraisal Edit ----------------------- */
	$scope.editCEOAppraisalMain = function(ceo_appraisal_id) {
		
		var ceoAppraisal = {
			ceo_appraisal_id : ceo_appraisal_id
		};
		
		$http.post($scope.baseURL + '/Performance/GetCEOAppraisalByAppraisalId', ceoAppraisal)
		.success(function(result) {
			$scope.saveEditCEOAppraisalId = result.ceo_appraisal_id;
			$scope.saveEditCEOPerformanceId = result.performance.performance_id;
			$scope.saveEditCEOEmployee = result.employee.empId;
			$scope.saveEditCEOYear = $filter('date')(result.performance.date, "yyyy");
			$scope.saveEditCEOStatus = result.status;
			$scope.saveEditCEOSkillScore = result.score_skill;
			$scope.saveEditCEOMentorshipScore = result.score_mentorship;
			$scope.saveEditCEOTaskCompScore = result.score_task_completion;
			$scope.saveEditCEOCurrPerformanceScore = result.score_current_performance;
			$scope.saveEditCEODesc = result.description;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	$scope.saveEditCEOAppraisalMain = function(ceo_appraisal_id, empId, performance_id, year, status, 
			score_skill, score_mentor, score_task, score_performance, description) {
		
		// covert string scores to integer
		var int_score_skill = parseInt(score_skill);
		var int_score_mentor = parseInt(score_mentor);
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		var total_score = int_score_skill + int_score_mentor + int_score_task + int_score_performance;
		
		console.log(ceo_appraisal_id + " " +  empId + " " +  performance_id + " " +  year + " " +  status, 
			+ " " +  score_skill + " " +  score_mentor + " " +  score_task + " " +  score_performance + " " + 
			description);
		
		var ceoAppraisal = {
			ceo_appraisal_id : ceo_appraisal_id,
			score_skill : score_skill,
			score_mentorship : score_mentor,
			score_task_completion : score_task,
			score_current_performance : score_performance,
			status : status,
			description : description,
			total_score : total_score
		};
		
		$http.post($scope.baseURL + '/Performance/UpdateCEOAppraisalByAppraisalId', ceoAppraisal)
		.success(function(result) {
			$scope.finalScoreCalculation(empId, year, performance_id)
			.then(function (result) {
				
				var final_score = result;
				
				// update performance details with final_score and status
				$scope.updatePerformance(performance_id, final_score, status);
			});
			
			$('#editCEOAppraisalModal').modal('hide');
			toaster.pop('success', "Notification", "Updated Appraisal Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
			
		})
		.error(function(data, status) {
			console.log(data);
			$('#editCEOAppraisalModal').modal('hide');
			toaster.pop('error', "Notification", "Appraisal Updation Failed");
		});
	};
	
	/* ------------------ CEO Delete Appraisal -------------------- */
	
	// calls function is called from the appraisals view
	$scope.deleteCEOAppraisalMain = function(ceo_appraisal_id) {
		
		//sets this variable to the delete CEO Appraisal modal
		$scope.deleteCEOAppraisalId = ceo_appraisal_id;
	};
	
	// actually deletes the CEO Appraisal
	$scope.deleteCEOAppraisal = function(ceo_appraisal_id) {
		
		var ceoAppraisal = {
			ceo_appraisal_id : ceo_appraisal_id
		};
			
		$http.post($scope.baseURL + '/Performance/DeleteCEOAppraisal', ceoAppraisal)
			.success(function(result) {
				$('#deleteCEOAppraisalModal').modal('hide');
				toaster.pop('success', "Notification", "Deleted Appraisal Successfully");
				setTimeout(function () {
					window.location.reload();
			    }, 1000);
			})
			.error(function(data, status) {
				$('#deleteCEOAppraisalModal').modal('hide');
				toaster.pop('error', "Notification", "Appraisal Deletion Failed");
				console.log(data);
			});
	}
	
	/* ------------------------------- Team Lead Appraisal ------------------------- */
	
	// get all Lead Appraisals
	$scope.getLeadAppraisals = function() {
		$http.get($scope.baseURL + '/Performance/GetLeadAppraisals')
		.success(function(result) {
			$scope.leadAppraisals = result;
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	//getTeamEmployeesByLeadId
	$scope.getTeamEmployeesByLeadId = function (empId) {
		
		var team = {
			employee:{empId:empId}
		};
		
		$http.post($scope.baseURL + '/Performance/GetTeamEmployeeByLeadId', team)
		.success(function(result) {
			$scope.teamMembersByLead = result;
		})
		.error(function(data, status) {
			console.log(data);
			
		});
	};
	
	// get teams belonging to team lead ID
	$scope.getTeamsByLeadId = function (empId) {
		
		// set team lead id as the current user id
		var team = {
			employee : {empId : empId}
		};
		
		$http.post($scope.baseURL + '/Performance/GetTeamsByLeadId', team)
		.success(function(result) {
			$scope.teamsByLeadId = result;
		})
		.error(function(data, status) {
			console.log(data);
			
		});
	};
	
	// add team lead appraisal
	$scope.addLeadAppraisal = function(emp_id, year, status, team_Id, score_skill, score_mentor, score_task,
			score_performance) {
		
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		// performance object
		var performance = {
			employee : {empId : emp_id},
			date: date,
			status: status
		};
		
		// covert string scores to integer
		var int_score_skill = parseInt(score_skill);
		var int_score_mentor = parseInt(score_mentor);
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		var total_score = int_score_skill + int_score_mentor + int_score_task + int_score_performance;
		
		
		// checks for performance exists if not creates a performance
		$http.post($scope.baseURL + '/Performance/CheckPerformanceExists', performance)
		.success(function(result) {
			// when exists is true
			if(result) {
				// gets the performance id
				$scope.getPerformanceId(performance)
					.then(function (result) {
						var performance_id = result;
						
						// creates Lead Appraisal
						$scope.addAppraisalLead(emp_id, performance_id, status, team_Id, score_skill, score_mentor,
								score_task, score_performance, total_score);
					});
			} else {
				$scope.addPeformance(emp_id, date)
					.then(function (result) {
						// performance_id of newly created object
						var performance_id = result;
						
						// creates Lead Appraisal
						$scope.addAppraisalLead(emp_id, performance_id, status, team_Id, score_skill, score_mentor,
								score_task, score_performance, total_score);
					});
			}
		})
		.error(function(data, status) {
			console.log(data);
		});
		
	};
	
	// add appraisal Lead Sub
	$scope.addAppraisalLead = function (emp_id, performance_id, status, team_Id, score_skill, score_mentor,
			score_task, score_performance, total_score) {
		
		var lead_appraisal = {
			employee : {empId : emp_id},
			performance : {performance_id : performance_id},
			status : status,
			score_skill : score_skill,
			score_mentorship : score_mentor,
			score_task_completion : score_task,
			score_current_performance : score_performance,
			total_score : total_score,
			team : {team_Id : team_Id}
		};
		
		$http.post($scope.baseURL + '/Performance/AddLeadAppraisal', lead_appraisal)
		.success(function(result) {
			$('#LeadAddAppraisal').modal('hide');
			toaster.pop('success', "Notification", "Added Appraisal Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			console.log(data);
			$('#LeadAddAppraisal').modal('hide');
			toaster.pop('error', "Notification", "Adding Appsaisal Failed");
		});
	};
	
	$scope.checkDuplicateLeadAppraisal = function(empId, year, team_Id) {
		
		console.log(empId, year, team_Id);
		
		// make the year default to year and 31st of December
		var appraisalYear = year + "-12-31";
		
		// send the data via angular http post
		var data = {
			employee : {empId : empId},
			performance : {date : appraisalYear},
			team : {team_Id : team_Id}
		};
		
		// angular AJAX call
		$http.post($scope.baseURL + '/Performance/CheckDuplicateLeadAppraisal', data)
		 .success(function(result) {
			 	$scope.duplicateLeadAppraisalExists = result;
			})
			.error(function(data, status) {
				console.log(data);
			})
	};
	
	/* -------------- Team Lead Appraisal Edit ------------------*/
	
	$scope.editAppraisalMain = function(leadAppraisalId, empId, date) {
		
		// filtered date
		var filteredDate = $filter('date')(date, "yyyy");
		
		// check if hr appraisal exists
		// if exists and completed, then disable
		$scope.checkHRAppraisalExists(empId, filteredDate)
		.then(function(result) {
			$scope.TeamLeadEditResult = result;
		});
		
		// construct Lead Appraisal object
		var leadAppraisal = {
			lead_appraisal_id : leadAppraisalId
		};
		
		// send request with data
		$http.post($scope.baseURL + '/Performance/GetLeadAppraisalByLeadAppraisalId', leadAppraisal)
		 .success(function(result) {
			 	$scope.saveEditLeadAppraisalId = result.lead_appraisal_id;
			 	$scope.saveEditLeadEmployee = result.employee.empId;
			 	$scope.saveEditLeadYear = $filter('date')(result.performance.date, "yyyy");
			 	$scope.saveEditLeadStatus = result.status;
			 	$scope.saveEditTeam = result.team.team_Id;
			 	$scope.saveEditLeadSkillScore = result.score_skill;
			 	$scope.saveEditLeadMentorshipScore = result.score_mentorship;
			 	$scope.saveEditLeadTaskCompScore = result.score_task_completion;
			 	$scope.saveEditLeadCurrPerformanceScore = result.score_current_performance;
			})
			.error(function(data, status) {
				console.log(data);
			})
	};
	
	// calls from edit lead appraisal modal
	$scope.saveEditLeadAppraisalMain = function(lead_appraisal_id, status, score_skill, score_mentor,
			score_task, score_performance) {
		
		// covert string scores to integer
		var int_score_skill = parseInt(score_skill);
		var int_score_mentor = parseInt(score_mentor);
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		// sum scores to calculate total_score
		var total_score = int_score_skill + int_score_mentor + int_score_task + int_score_performance;
		
		// call the actual save edit lead appraisal function to persist data
		$scope.saveEditLeadAppraisal(lead_appraisal_id, status, score_skill, score_mentor,
			score_task, score_performance, total_score);
		
	};
	
	$scope.saveEditLeadAppraisal = function(lead_appraisal_id, status, score_skill, score_mentor,
			score_task, score_performance, total_score) {
		
		var leadAppraisal = {
			lead_appraisal_id : lead_appraisal_id,
			status : status,
			score_skill : score_skill,
			score_mentorship : score_mentor,
			score_task_completion : score_task,
			score_current_performance : score_performance,
			total_score : total_score
		};
		
		$http.post($scope.baseURL + '/Performance/SaveEditLeadAppraisal', leadAppraisal)
		 .success(function(result) {
			$('#editLeadAppraisalModal').modal('hide');
			toaster.pop('success', "Notification", "Updated Appraisal Successfully");
			setTimeout(function () {
				window.location.reload();
	        }, 1000);
		  })
		  .error(function(data, status) {
			 $('#editLeadAppraisalModal').modal('hide');
			 toaster.pop('error', "Notification", "Appraisal Updation Failed");
			 console.log(data);
		  });
		
	};
	
		/* ---------------- Team Lead Appraisl Delete ---------------- */
	
	$scope.deleteAppraisalMain = function(lead_appraisal_id, empId, date) {
		
		// filtered date
		var filteredDate = $filter('date')(date, "yyyy");
		
		// send data to delete lead appraisal modal
		$scope.deleteLeadAppraisalId = lead_appraisal_id;
		$scope.deleteLeadEmpId = empId;
		$scope.deleteLeadYear = filteredDate;
		
		
		// check if hr appraisal exists
		// if exists and completed, then disable
		$scope.checkHRAppraisalExists(empId, filteredDate)
		.then(function(result) {
			$scope.TeamLeadDeleteResult = result;
		});
		
	};
	
	$scope.deleteLeadAppraisal = function(lead_appraisal_id) {
		
		var leadAppraisal = {
			lead_appraisal_id : lead_appraisal_id
		};
		
		$http.post($scope.baseURL + '/Performance/DeleteLeadAppraisal', leadAppraisal)
		 .success(function(result) {
			$('#deleteLeadAppraisalModal').modal('hide');
			toaster.pop('success', "Notification", "Deleted Appraisal Successfully");
			setTimeout(function () {
				window.location.reload();
	        }, 1000);
		  })
		  .error(function(data, status) {
			 $('#deleteLeadAppraisalModal').modal('hide');
			 toaster.pop('error', "Notification", "Appraisal Deletion Failed");
			 console.log(data);
		  });
	};
	
	/* -------------------------------- HR Appraisal ------------------------------ */
	
	$scope.GetTeamEmployeeCountByEmpId = function (teamEmp) {
		$http.post($scope.baseURL + '/Performance/GetTeamEmployeeCountByEmpId', teamEmp)
		 .success(function(result) {
			 console.log(result);
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
	};
	
	$scope.GetCompleteLeadAppraisalCountByEmpId = function(leadApp) {
		$http.post($scope.baseURL + '/Performance/GetCompleteLeadAppraisalCountByEmpId', leadApp)
		 .success(function(result) {
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
	};
	
	// check whether lead appraisal exists for the given employee and year
	// by getting team employee count to be equal to lead appraisal count
	// for that particular employee and year
	$scope.checkLeadAppraisalComplete = function(emp_id, year) {
		
		var def = $q.defer();
		
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		var teamEmp = {
			employee : {empId : emp_id}	
		}
		
		var team = {
			employee : {empId : emp_id}	
		}
		
		var teamEmpAndTeam = {
			team_employee : teamEmp,
			team : team
		}
		
		var leadApp  = {
			employee : {empId : emp_id},
			performance : {date : date}
		}
		
		var bothObjects = {
			teamEmployeeAndTeam : teamEmpAndTeam,
			lead_Appraisal : leadApp
		};
		
		$scope.GetTeamEmployeeCountByEmpId(teamEmpAndTeam);
		$scope.GetCompleteLeadAppraisalCountByEmpId(leadApp);
		  
		$http.post($scope.baseURL + '/Performance/CheckLeadAppraisalComplete', bothObjects)
		 .success(function(result) {
			 def.resolve(result);
			 $scope.teamLeadAppraisalCompleted = result;
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
		
		return def.promise;
	};
	
	//check duplicate HR Appraisal
	$scope.checkDuplicateHRAppraisal = function(emp_id, year) {
		
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		var data = {
			employee : {empId : emp_id},
			performance : {date : date}
		};
		
		$http.post($scope.baseURL + '/Performance/CheckDuplicateHRAppraisal', data)
		 .success(function(result) {
			 $scope.checkDuplicateHRAppraisalResult = result;
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
	};
	
	// add HR Appraisal Main
	$scope.addHRAppraisal = function (emp_id, year, status, score_task, score_performance) {
		// make month and date default to 1st of December
		var date = year + '-12-31';
		
		// performance object
		var performance = {
			employee : {empId : emp_id},
			date: date,
			status: status
		};
		
		// covert string scores to integer
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		var total_score = int_score_task + int_score_performance;
		
		// checks for performance exists if not creates a performance
		$http.post($scope.baseURL + '/Performance/CheckPerformanceExists', performance)
		.success(function(result) {
			if(result) {
				$scope.checkLeadAppraisalComplete(emp_id, year)
				.then(function (result) {
					if(result) {
						// gets the performance id
						$scope.getPerformanceId(performance)
						.then(function (result) {
							var performance_id = result;
							
							// call Add HR Appraisal Sub
							$scope.addHRAppraisalSub(emp_id, performance_id, score_task, score_performance, total_score, status)
								
						});
					}
				});
			} else {
				$scope.checkLeadAppraisalComplete(emp_id, year)
				.then(function (result) {
					if(result) {
						$scope.addPeformance(emp_id, date)
						.then(function (result) {
							// performance_id of newly created object
							var performance_id = result;
							
							// call Add HR Appraisal Sub
							$scope.addHRAppraisalSub(emp_id, performance_id, score_task, score_performance, total_score, status)
						});
					}
				});
			}			
		});
	};
	
	// add HR Appraisal Sub
	$scope.addHRAppraisalSub = function(emp_id, performance_id, score_task, score_performance,
			total_score, status) {
		
		// HR Appraisal Object
		var hrAppraisal = {
			employee : {empId : emp_id},
			performance : {performance_id : performance_id},
			score_task_completion : score_task,
			score_current_performance : score_performance,
			total_score : total_score,
			status : status
		};
		
		// sends request to Add HR Appraisal
		$http.post($scope.baseURL + '/Performance/AddHRAppraisal', hrAppraisal)
		.success(function(result) {
			$('#HRAddAppraisal').modal('hide');
			toaster.pop('success', "Notification", "Added Appraisal Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			console.log(data);
			$('#HRAddAppraisal').modal('hide');
			toaster.pop('error', "Notification", "Adding Appsaisal Failed");
		});
	};
	
	/* ------------ HR Appraisal Edit --------------- */
	
	$scope.editHRAppraisalMain = function(hr_appraisal_id, empId, date) {
		
		// filtered date
		var filteredDate = $filter('date')(date, "yyyy");
		
		$scope.checkCEOAppraisalExists(empId, filteredDate)
			.then(function(result) {
				$scope.HREditResult = result;
			});
		
		var hrAppraisal = {
			hr_appraisal_id : hr_appraisal_id
		};
		
		$http.post($scope.baseURL + '/Performance/GetHRAppraisalByAppraisalId', hrAppraisal)
		.success(function(result) {
			$scope.saveEditHREmployee = result.employee.empId;
			$scope.saveEditHRAppraisalId = result.hr_appraisal_id;
			$scope.saveEditHRYear = $filter('date')(result.performance.date, "yyyy");
			$scope.saveEditHRStatus = result.status;
			$scope.saveEditHRTaskCompScore = result.score_task_completion;
			$scope.saveEditHRCurrPerformanceScore = result.score_current_performance;
		})
		.error(function(data, status) {
			console.log(data);
			$('#HRAddAppraisal').modal('hide');
			toaster.pop('error', "Notification", "Adding Appsaisal Failed");
		});
	};
	
	// call when submit button is clicked in the editHRAppraisal.jsp
	$scope.saveEditHRAppraisalMain = function(hr_appraisal_id, status, score_task,
			score_performance) {
		
		// convert string scores to int
		var int_score_task = parseInt(score_task);
		var int_score_performance = parseInt(score_performance);
		
		// sum scores
		var total_score = int_score_task + int_score_performance;
		
		// call the actual saveEditHRAppraisal function to save the changes made
		$scope.saveEditHRAppraisal(hr_appraisal_id, status, score_task,
			score_performance, total_score);
	};
	
	$scope.saveEditHRAppraisal = function(hr_appraisal_id, status, score_task,
			score_performance, total_score) {
		
		var hrAppraisal = {
			hr_appraisal_id : hr_appraisal_id,
			status : status,
			score_task_completion : score_task,
			score_current_performance : score_performance,
			total_score : total_score
		};
		
		$http.post($scope.baseURL + '/Performance/SaveEditHRAppraisal', hrAppraisal)
		 .success(function(result) {
			$('#editHRAppraisalModal').modal('hide');
			toaster.pop('success', "Notification", "Updated Appraisal Successfully");
			setTimeout(function () {
				window.location.reload();
	        }, 1000);
		  })
		  .error(function(data, status) {
			 $('#editHRAppraisalModal').modal('hide');
			 toaster.pop('error', "Notification", "Appraisal Updation Failed");
			 console.log(data);
		  });
	};
	
	/* --------------- HR Appraisal Delete ---------------------- */
	
	$scope.deleteHRAppraisalMain = function(hr_appraisal_id, empId, date) {
		// filtered date
		var filteredDate = $filter('date')(date, "yyyy");
		
		// send data to deleteEditHRAppraisalModal
		$scope.deleteHRAppraisalId = hr_appraisal_id;
		
		$scope.checkCEOAppraisalExists(empId, filteredDate)
			.then(function(result) {
				$scope.HRDeleteResult = result;
			});
	};
	
	// actually deletes the HR Appraisal
	$scope.deleteHRAppraisal = function(hr_appraisal_id) {
		
		var hrAppraisal = {
			hr_appraisal_id : hr_appraisal_id
		};
		
		$http.post($scope.baseURL + '/Performance/DeleteHRAppraisal', hrAppraisal)
		 .success(function(result) {
			$('#deleteHRAppraisalModal').modal('hide');
			toaster.pop('success', "Notification", "Deleted Appraisal Successfully");
			setTimeout(function () {
				window.location.reload();
	        }, 1000);
		  })
		  .error(function(data, status) {
			 $('#deleteHRAppraisalModal').modal('hide');
			 toaster.pop('error', "Notification", "Appraisal Deletion Failed");
			 console.log(data);
		  });
	}
}]);