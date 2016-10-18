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
		$scope.getAllTrainings();
	};
	
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
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	$scope.getEmpTrainingCount = function(trainingId) {
		var def = $q.defer();
		
		var training = {
			training_id : trainingId
		};
		
		$http.post($scope.baseURL + '/Trainings/GetEmpTrainingCountByTrainingId', training)
		.success(function(result) {
			def.resolve(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
		return def.promise;
	};
	
}]);