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

	$scope.availableLeaves = 12;
	$scope.fromLeaveDate = new Date();
	
	// called when the page loads
	$scope.init = function () {
		// calls other functions
		$scope.userAndLeadSummaryChart();
		$scope.getAllLeaveTypes();
	};
	
	// user and lead chart
	$scope.userAndLeadSummaryChart = function() {
		$scope.userAndLeadLabel = ["Annual Leave", "Casual Leave", "Remote Work", 
		                           "Sick Leave", "Special Holiday Leave", "Lieu Leave"];
		 $scope.userAndLeadData = [6, 3, 4, 1, 2, 3];
	};	
	
	// current year for To Date Max-Date Calculation
	$scope.checkYear = function(addLeaveFromDate) {
		var year = addLeaveFromDate.substring(0,4);
		$scope.maxDateLimitForFromDate = new Date(year + '-12-31');
	};
	
	$scope.getAllLeaveTypes = function() {
		$http.get($scope.baseURL + '/Leave/GetLeaveTypes')
		.success(function(result){
			$scope.leaveTypes = result;
			console.log(result);
		})
		.error(function(data, status){
			console.log(data);
		});
	}
		
}]);