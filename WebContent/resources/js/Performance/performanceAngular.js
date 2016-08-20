var performance = angular.module('performance', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count', 'angular-convert-to-number']);

// Controllers
performance.controller('performanceMainController', ['$scope', '$http', '$q', 'toaster', '$filter', 
                                                     function($scope, $http, $q, toaster, $filter) {
	
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
		$scope.getLoggedInEmployee()
			.then(function(result) {
				$scope.loggedInEmpId = result;
				$scope.getTeamEmployeesByLeadId(result);
				
				// get team by current logged in user team lead id, user role is ROLE_LEAD
				if($scope.currentUserRole === '[ROLE_LEAD]')
					$scope.getTeamsByLeadId(result);
			});
		$scope.summaryChartCEO();
		$scope.summaryChartLead();
	 };
	
	// ceo summary chart configs
	$scope.summaryChartCEO = function() {
		$scope.labels = ["January", "February", "March", "April"];
		  $scope.series = ['Series A', 'Series B', 'Series C'];
		  $scope.data = [
		    [10, 4, 30, 15],
		    [25, 20, 13, 22],
		    [1, 15, 7, 12]
		  ];
		  $scope.onClick = function (points, evt) {
		    console.log(points, evt);
		  };
		  $scope.datasetOverride = [{ yAxisID: 'y-axis-1' }, { yAxisID: 'y-axis-2' }];
		  $scope.options = {
		    scales: {
		      yAxes: [
		        {
		          id: 'y-axis-1',
		          type: 'linear',
		          display: true,
		          position: 'left'
		        },
		        {
		          id: 'y-axis-2',
		          type: 'linear',
		          display: true,
		          position: 'right'
		        }
		      ]
		    }
		  };
		};
		
		// Lead summary chart configs
		$scope.summaryChartLead = function() {
			$scope.labels = ["January", "February", "March", "April"];
			  $scope.series = ['Series A', 'Series B', 'Series C'];
			  $scope.data = [
			    [10, 4, 30, 15],
			    [25, 20, 13, 22],
			    [1, 15, 7, 12]
			  ];
			  $scope.onClick = function (points, evt) {
			    console.log(points, evt);
			  };
			  $scope.datasetOverride = [{ yAxisID: 'y-axis-1' }, { yAxisID: 'y-axis-2' }];
			  $scope.options = {
			    scales: {
			      yAxes: [
			        {
			          id: 'y-axis-1',
			          type: 'linear',
			          display: true,
			          position: 'left'
			        },
			        {
			          id: 'y-axis-2',
			          type: 'linear',
			          display: true,
			          position: 'right'
			        }
			      ]
			    }
			  };
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
	  }
	  
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
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
	// check if appraisal year is more than or equal to the hired date
	 $scope.checkAppraisalYear = function (empId, year) {
		 
		 var appraisalYear =  new Date(year + "-12-31");
		 
		 var data = {
			empId : empId
		 }
		 
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
		var emp = {
			empId : emp_id
		};
		
		$http.post($scope.baseURL + '/Performance/GetUserRoleByEmpId', emp)
		 .success(function(result) {
			 $scope.userRoleByEmpId = result.authority;
		  })
		  .error(function(data, status) {
			 console.log(data);
		  });
	};
	
	/* ------------------------------------- CEO Appraisal ------------------------ */
	
	// check if HR Appraisal Exists for the given emp_id except the HR Manager
	$scope.checkHRAppraisalExists = function(emp_id, year) {
		
		// initialize date to the last day of the given year 
		var date = year + '-12-31';
		
		var data = {
			date : date,
			employee : {empId : emp_id}
		};
		
		$http.post($scope.baseURL + '/Performance/CheckHRAppraisalExists', data)
		.success(function(result) {
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
		
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
		
		// checks for performance exists if not creates a performance
		$http.post($scope.baseURL + '/Performance/CheckPerformanceExists', performance)
		.success(function(result) {
			// when exists is true
			if(result) {
				// gets the performance id
				$scope.getPerformanceId(performance)
					.then(function (result) {
						var performance_id = result;
						
						// creates CEO Appraisal
						$scope.addAppraisalCEO(emp_id, performance_id, status, score_skill, score_mentor,
								score_task, score_performance, description, total_score);
					});
			} else {
				$scope.addPeformance(emp_id, date)
					.then(function (result) {
						// performance_id of newly created object
						var performance_id = result;
						
						// creates CEO Appraisal
						$scope.addAppraisalCEO(emp_id, performance_id, status, score_skill, score_mentor,
								score_task, score_performance, description, total_score);
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
			$('#CEOAddAppraisal').modal('hide');
			toaster.pop('success', "Notification", "Added Appraisal Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			console.log(data);
			$('#CEOAddAppraisal').modal('hide');
			toaster.pop('error', "Notification", "Adding Appsaisal Failed");
		});
	};
	
	/* ------------------------------- Team Lead Appraisal ------------------------- */
	
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
	}
	
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
				} else {
					console.log('Team Appraisals NOT Completed.')
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
}]);