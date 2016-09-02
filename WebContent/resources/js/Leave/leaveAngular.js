var leave = angular.module('leave', ['toaster', 'ngAnimate', 'chart.js', 
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

leave.controller('leaveMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	// declared variables
	$scope.availableLeaves = 12;
	$scope.fromLeaveDate = new Date();
	
	console.log(typeof $scope.fromLeaveDate);
	
	// called when the page loads
	$scope.init = function () {
		// calls other functions
		$scope.userAndLeadSummaryChart();
	};
	
	$scope.userAndLeadSummaryChart = function() {
		$scope.userAndLeadLabel = ["Annual Leave", "Casual Leave", "Remote Work", 
		                           "Sick Leave", "Special Holiday Leave", "Lieu Leave"];
		 $scope.userAndLeadData = [6, 3, 4, 1, 2, 3];
	};	
}]);