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
		$scope.getAllTeams();
		$scope.getInProgressAndOnHoldProjects();
		$scope.getLeadEmployees();
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
	
	// get project by project_id
	$scope.getProjectByProjectId = function(projectId) {
		
		var project = {
			project_id : projectId
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/GetProjectByProjectId', project)
		.success(function(result) {
			$scope.updateProjectId = result.project_id;
			$scope.updateProjectName = result.project_name;
			$scope.updateProjectStatus = result.status;
			$scope.updateProjectStartDate = $filter('date')(result.project_start, "yyyy-MM-dd");
			$scope.updateProjectClient = result.project_client;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update project
	$scope.updateProject = function(projectId, projectName, status, startDate, projectClient) {
		
		var project = {
				project_id : projectId,
				project_name : projectName,
				status : status,
				project_start : startDate,
				project_client : projectClient
			};
				
			$http.post($scope.baseURL + '/ProjectsAndTeams/UpdateProject', project)
			.success(function(result) {
				$('#editProjectModal').modal('hide');
				toaster.pop('success', "Notification", "Project Updated Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 1000);
			})
			.error(function(data, status) {
				$('#editProjectModal').modal('hide');
				toaster.pop('error', "Notification", "Project Updation Failed");
				console.log(data);
			});
	};
	
	// called from projects.jsp page
	$scope.deleteProjectMain = function(projectId) {
		$scope.deleteProjectId = projectId;
	};
	
	// actually delete the project - called from deleteProjectModal
	$scope.deleteProject = function(projectId) {
		
		var project = {
			project_id : projectId
		};
			
		$http.post($scope.baseURL + '/ProjectsAndTeams/DeleteProject', project)
		.success(function(result) {
			$('#deleteProjectModal').modal('hide');
			toaster.pop('success', "Notification", "Project Deleted Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#deleteProjectModal').modal('hide');
			toaster.pop('error', "Notification", "Project Deletion Failed");
			console.log(data);
		});
	};
	
	// get all teams
	$scope.getAllTeams = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetAllTeams')
		.success(function(result) {
			$scope.allTeams = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all In-Progress And On-Hold Projects
	$scope.getInProgressAndOnHoldProjects = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetInProgressAndOnHoldProjects')
		.success(function(result) {
			$scope.allInProgessAndOnHoldProjects = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all lead employees
	$scope.getLeadEmployees = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetLeadEmployees')
		.success(function(result) {
			$scope.allLeadEmployees = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	
}]); 