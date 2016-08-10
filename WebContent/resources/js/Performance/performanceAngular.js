var performance = angular.module('performance', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count', 'angular-convert-to-number']);

// Controllers
performance.controller('performanceMainController', ['$scope', '$http', '$q', 'toaster', 
                                                     function($scope, $http, $q, toaster) {
	
	$scope.currentUser = currentUser;
	$scope.baseURL = contextPath;
	
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
				$scope.getTeamEmployeeById(result);
			});
		$scope.summaryChartCEO();
		$scope.summaryChartLead();
		/*$scope.getTeamEmployeeById($scope.loggedInEmpId);*/
		console.log($scope.loggedInEmpId);
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
	}
	
	// add CEO Appraisal
	$scope.addCEOAppraisal = function(emp_id, year, status, score_skill, score_mentor, score_task,
			score_performance, description){
		
		// make month and date default to 1st of December
		var date = year + '-12-01';
		
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
	
	//getTeamEmployeeByLeadEmpId
	$scope.getTeamEmployeeById = function (empId) {
		
		var team = {
			employee:{empId:empId}
		};
		
		$http.post($scope.baseURL + '/Performance/GetTeamEmployeeById', team)
		.success(function(result) {
			
		})
		.error(function(data, status) {
			console.log(data);
			
		});
	}
	
	// add team lead appraisal
	$scope.addLeadAppraisal = function() {
		
	}
}]);