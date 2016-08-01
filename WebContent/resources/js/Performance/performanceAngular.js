var performance = angular.module('performance', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count']);

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
	  
	  // ceo add appraisal
	  var startYear = '2011';
	  var endYear = new Date().getFullYear();
	  $scope.years = [];
	  
	  for(var i=startYear; i<=endYear; i++) {
		  $scope.years.push(i);
	  }
	  
	
}]);