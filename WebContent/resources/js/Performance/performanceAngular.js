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
}]);