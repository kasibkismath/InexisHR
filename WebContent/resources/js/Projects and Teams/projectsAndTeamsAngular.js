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
		$scope.checkDuplicateTeamResult = false;
		
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
	
	// check duplicate team by Project and Team Name
	$scope.checkDuplicateTeam = function(teamName, project) {
		if(teamName != undefined && project != undefined) {
			
			var team = {
				team_name : teamName,
				project : {project_id : project}
			};
			
			$http.post($scope.baseURL + '/ProjectsAndTeams/CheckDuplicateTeam', team)
			.success(function(result) {
				$scope.checkDuplicateTeamResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		} else {
			$scope.checkDuplicateTeamResult = false;
		}
	};
	
	// add new team
	$scope.addTeam = function(teamName, project, lead, status) {
		
		var team = {
			team_name : teamName,
			project : {project_id : project},
			employee : {empId : lead},
			status : status
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/AddTeam', team)
		.success(function(result) {
			$('#addNewTeamModal').modal('hide');
			toaster.pop('success', "Notification", "Team Added Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#addNewTeamModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Team Failed");
			console.log(data);
		});
	};
	
	// get team by team_id
	$scope.getTeamByTeamId = function(teamId) {
		
		var team = {
			team_Id : teamId
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/GetTeamByTeamId', team)
		.success(function(result) {
			$scope.updateTeamId = result.team_Id;
			$scope.updateTeamName = result.team_name;
			$scope.updateTeamProject = result.project.project_id;
			$scope.updateTeamLead = result.employee.empId;
			$scope.updateTeamStatus = result.status;
			
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update team
	$scope.updateTeam = function(teamId, teamName, project, lead, status) {
		var team = {
			team_Id : teamId,
			team_name : teamName,
			project : {project_id : project},
			employee : {empId : lead},
			status : status
		};
			
		$http.post($scope.baseURL + '/ProjectsAndTeams/UpdateTeam', team)
		.success(function(result) {
			$('#editTeamModal').modal('hide');
			toaster.pop('success', "Notification", "Team Updated Successfully");
			setTimeout(function () {
	            window.location.reload();
	        }, 1000);
		})
		.error(function(data, status) {
			$('#editTeamModal').modal('hide');
			toaster.pop('error', "Notification", "Team Updation Failed");
			console.log(data);
		});
	};
	
	// called from teams.jsp delete button
	$scope.deleteTeamMain = function(teamId) {
		$scope.deleteTeamId = teamId;
	};
	
	// actually delete team - called from Delete Team Modal
	$scope.deleteTeam = function(teamId) {
		
		var team = {
		   team_Id : teamId,
		};
				
		$http.post($scope.baseURL + '/ProjectsAndTeams/DeleteTeam', team)
		.success(function(result) {
			$('#deleteTeamModal').modal('hide');
			toaster.pop('success', "Notification", "Team Deleted Successfully");
			setTimeout(function () {
				window.location.reload();
		    }, 1000);
		})
		.error(function(data, status) {
			$('#deleteTeamModal').modal('hide');
			toaster.pop('error', "Notification", "Team Deletion Failed");
			console.log(data);
		});
	};
	
}]);  