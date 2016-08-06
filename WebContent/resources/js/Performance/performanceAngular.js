var performance = angular.module('performance', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count', 'angular-convert-to-number']);

// Controllers
performance.controller('performanceMainController', ['$scope', '$http', function($scope, $http) {
	
	$scope.currentUser = currentUser;
	$scope.baseURL = contextPath;
	
	// chart configs
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
	  
	  // init method when page loads
	  $scope.init = function() {
		$scope.getAppraisalYears();
		$scope.getAllEmployees();
		$scope.getScoreValues();
		$scope.getAllPerformanceAppraisals();
		$scope.getLoggedInEmployee();
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
		var user = {username : $scope.currentUser};
		
		$http.post($scope.baseURL + '/administration/user/currentUser', user)
		.success(function(result) {
			$scope.loggedInEmpId = result.employee.empId;
		})
		.error(function(data, status) {
			console.log(data);
		});
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
	
	// add CEO Appraisal
	$scope.addCEOAppraisal = function(emp_id, year, status, score_skill, score_mentor, score_task,
			score_performance, description){
		console.log(emp_id + " " + year + " " + status + " " + score_skill + " " + score_mentor + " " +
				score_task + " " + score_performance + " " + description);
		
		// make month and date default to 1st of December
		var date = year + '-12-01';
		
		// performance object
		var performance = {
			employee : {empId : emp_id},
			date: date,
			status: status
		};
		
		var total_score = score_skill  + score_mentor + score_task + score_performance;
		
		// checks for performance exists if not creates a performance
		$http.post($scope.baseURL + '/Performance/CheckPerformanceExists', performance)
		.success(function(result) {
			if(result) {
				var performance_id = $scope.getPerformanceId(performance);
				$scope.addAppraisalCEO(emp_id, performance_id, status, score_skill, score_mentor,
						score_task, score_performance, description, total_score);
			}
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get performance id
	$scope.getPerformanceId = function (performanceObj) {
		$http.post($scope.baseURL + '/Performance/getPerformanceId', performanceObj)
		.success(function(result) {
			return result.performance_id;
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
			total_score : total_score
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
		});
	};
}]);