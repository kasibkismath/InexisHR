var projectsAndTeams = angular.module('projectsAndTeams', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

projectsAndTeams.controller('projectsAndTeamsMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder) {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;
	
	
	$scope.init = function(){
		// variables
		$scope.saveProjectStatus = "In-Progress";
		
		// functions
		$scope.getAllProjects();
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
	
	// get all projects
	$scope.getAllProjects = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetAllProjects')
		.success(function(result) {
			$scope.allProjects = result;
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// check duplicate project by project name
	$scope.checkDuplicateProject = function(projectName) {
		
		var project = {
			project_name : projectName
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/CheckDuplicateProject', project)
		.success(function(result) {
			$scope.checkDuplicateProjectResult = result;
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// add new project
	$scope.addProject = function(projectName, status, startDate, projectClient) {
		
		var project = {
			project_name : projectName,
			status : status,
			project_start : startDate,
			project_client : projectClient
		};
			
		$http.post($scope.baseURL + '/ProjectsAndTeams/AddProject', project)
		.success(function(result) {
			$('#addNewProjectModal').modal('hide');
			toaster.pop('success', "Notification", "Project Added Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#addNewProjectModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Project Failed");
			console.log(data);
		});
	};
}]);