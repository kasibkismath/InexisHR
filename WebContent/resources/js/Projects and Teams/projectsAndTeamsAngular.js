var projectsAndTeams = angular.module('projectsAndTeams', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker', 'datatables.buttons' 
                                                 ]);

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
		$scope.checkDuplicateProjectResult = false;
		$scope.checkDuplicateTeamResult = false;
		$scope.checkDuplicateTeamMemberResult = false;
		$scope.checkFromToDateResult = false;
		$scope.checkDuplicateEmpProjectHistoryResult = false;
		
		// functions
		$scope.getAllProjects();
		$scope.getAllTeams();
		$scope.getInProgressAndOnHoldProjects();
		$scope.getLeadEmployees();
		$scope.getAllTeamMembers();
		$scope.projectEmployeeSummaryChart();
		$scope.getAllEmpProjectHistories();
	};
	
	// datatable configurations
	// emp project team history datatable
	$scope.empProjectTableOption = DTOptionsBuilder.newOptions()
	   .withOption('aaSorting', [[0, 'asc'], [1, 'asc'], [2, 'asc'], [3, 'desc']])
	
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
	
	// get project employee summary data
	$scope.projectEmployeeSummaryChart = function(){
		 $scope.projectEmpLabels = [];
		 $scope.projectEmpData = [];
		 
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetProjectEmployeeSummary')
		.success(function(result) {
			angular.forEach(result, function(value, key) {
				$scope.projectEmpLabels.push(value[0]);
				$scope.projectEmpData.push(value[1]);
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
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
			console.log(teamName + " ")
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
	
	// get all team members
	$scope.getAllTeamMembers = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetAllTeamMembers')
		.success(function(result) {
			$scope.allTeamMembers = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get active teams by project
	$scope.getActiveTeamsByProject = function(projectId) {
		$scope.saveTeamMemberTeam = "";
		$scope.updateTeamMemberTeam = "";
		if(projectId != undefined) {
			
			var team = {
				project : {project_id : projectId}
			};
			
			$http.post($scope.baseURL + '/ProjectsAndTeams/GetActiveTeamsByProject', team)
			.success(function(result) {
				$scope.getActiveTeamsByProjectResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	
	// check team member duplicate
	$scope.checkTeamMemberDuplicate = function(employee, teamId) {
		 if(employee != undefined && teamId != undefined) {
			
			var teamMember = {
				employee : {empId : employee},
				team : {team_Id : teamId}
			};
				
			$http.post($scope.baseURL + '/ProjectsAndTeams/CheckDuplicateTeamMember', teamMember)
			.success(function(result) {
				$scope.checkDuplicateTeamMemberResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		} else {
			$scope.checkDuplicateTeamMemberResult = false;
		}
	};
	
	// add team member
	$scope.addTeamMember = function(employeeId, teamId, fromDate, toDate) {
		
		var teamMember = {
			employee : {empId : employeeId},
			team : {team_Id : teamId}
		};
		
		$scope.addEmployeeProjectHistory(employeeId, teamId, fromDate, toDate);
				
		$http.post($scope.baseURL + '/ProjectsAndTeams/AddTeamMember', teamMember)
		.success(function(result) {
			$('#addTeamMemberModal').modal('hide');
			toaster.pop('success', "Notification", "Team Member Added Successfully");
			setTimeout(function () {
				window.location.reload();
		    }, 1000);
		})
		.error(function(data, status) {
			$('#addTeamMemberModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Team Member Failed");
			console.log(data);
		});
	};
	
	// get team member by team_member_id
	$scope.getTeamMemberByTeamMemberId = function(teamMemberId, projectId) {
		
		$scope.getActiveTeamsByProject(projectId);
		
		var teamMember = {
			team_emp_id : teamMemberId
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/GetTeamMemberByTeamMemberId', teamMember)
		.success(function(result) {
			$scope.updateTeamMemberProject = result.team.project.project_id;
			$scope.updateTeamMemberId = result.team_emp_id;
			$scope.updateTeamMemberEmp = result.employee.empId;
			$scope.updateTeamMemberTeam = result.team.team_Id;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update team member 
	$scope.updateTeamMember = function(teamMemId, teamEmp, team) {
		var teamMember = {
			team_emp_id : teamMemId,
			employee : {empId : teamEmp},
			team : {team_Id : team}
		};
				
		$http.post($scope.baseURL + '/ProjectsAndTeams/UpdateTeamMember', teamMember)
		.success(function(result) {
			$('#editTeamMemberModal').modal('hide');
			toaster.pop('success', "Notification", "Team Member Updated Successfully");
			setTimeout(function () {
		        window.location.reload();
		    }, 1000);
			})
		.error(function(data, status) {
			$('#editTeamMemberModal').modal('hide');
			toaster.pop('error', "Notification", "Team Member Updation Failed");
			console.log(data);
		});
	};
	
	// called from teamMembers.jsp
	$scope.deleteTeamMemberMain = function(deleteTeamId) {
		$scope.deleteTeamId = deleteTeamId;
	};
	
	// actually delete team member - from delete team member
	$scope.deleteTeamMember = function(teamMemId) {
		
		var teamMember = {
			team_emp_id : teamMemId,
		};
					
		$http.post($scope.baseURL + '/ProjectsAndTeams/DeleteTeamMember', teamMember)
		.success(function(result) {
			$('#deleteTeamMemberModal').modal('hide');
			toaster.pop('success', "Notification", "Team Member Deleted Successfully");
			setTimeout(function () {
			      window.location.reload();
			 }, 1000);
		})
		.error(function(data, status) {
			$('#deleteTeamMemberModal').modal('hide');
			toaster.pop('error', "Notification", "Team Member Deletion Failed");
			console.log(data);
		});
	};
	
	// check for from date - To Date team member validation
	$scope.checkFromToDate = function(fromDate, toDate) {
		if(fromDate != undefined && toDate != undefined) {
			
			var formattedFromDate = new Date(fromDate);
			var formattedToDate = new Date(toDate);
			
			if(formattedFromDate > formattedToDate) {
				$scope.checkFromToDateResult = true;
			} else {
				$scope.checkFromToDateResult = false;
			}
		}
	};
	
	// check for duplicate employee project history
	$scope.checkDuplicateEmpProjectHistory = function(empId, teamId, fromDate, toDate) {
		if(empId != undefined && teamId != undefined && fromDate != undefined && 
				toDate != undefined && teamId != "") {
			
			var empProjectHistory = {
				employee: {empId:empId},
				team: {team_Id : teamId},
				fromDate: fromDate,
				toDate: toDate
			};
						
			$http.post($scope.baseURL + '/ProjectsAndTeams/CheckDuplicateEmpProjectHistory', 
					empProjectHistory)
			.success(function(result) {
				$scope.checkDuplicateEmpProjectHistoryResult = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		}
	};
	
	// add employee project history
	$scope.addEmployeeProjectHistory = function(empId, teamId, fromDate, toDate) {
		
		var empProjectHistory = {
				employee: {empId:empId},
				team: {team_Id : teamId},
				fromDate: fromDate,
				toDate: toDate
		};
						
		$http.post($scope.baseURL + '/ProjectsAndTeams/AddEmployeeProjectHistory', 
				empProjectHistory)
		.success(function(result) {
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all employee project histories
	$scope.getAllEmpProjectHistories = function() {
		$http.get($scope.baseURL + '/ProjectsAndTeams/GetAllEmployeeProjectHistories')
		.success(function(result) {
			$scope.allEmpProjectHistories = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get emp project by id
	$scope.getEmpProjectById = function(empProjectId) {
		
		var empProjectHistory = {
			emp_proj_history_id: empProjectId
		};
						
		$http.post($scope.baseURL + '/ProjectsAndTeams/GetEmployeeProjectById', 
				empProjectHistory)
		.success(function(result) {
			$scope.updateEmpProjectHistId = result.emp_proj_history_id;
			$scope.updateEmpProjectHistTeam = result.team.team_Id;
			$scope.updateEmpProjectHistEmp = result.employee.empId;
			$scope.updateEmpProjectHistFromDate = $filter('date')(result.fromDate, "yyyy-MM-dd");
			$scope.updateEmpProjectHistToDate = $filter('date')(result.toDate, "yyyy-MM-dd");
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	//update emp project history
	$scope.updateEmpProjectHistory = function(empProjectHistoryId, fromDate, toDate) {
		var empProjectHistory = {
			emp_proj_history_id: empProjectHistoryId,
			fromDate: fromDate,
			toDate: toDate
		};
							
		$http.post($scope.baseURL + '/ProjectsAndTeams/UpdateEmployeeProjectHistory', 
				empProjectHistory)
		.success(function(result) {
			$('#editEmpProjectHistoryModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Project Team History Updated Successfully");
			setTimeout(function () {
			      window.location.reload();
			 }, 1000);
		})
		.error(function(data, status) {
			$('#editEmpProjectHistoryModal').modal('hide');
			toaster.pop('error', "Notification", "Employee Project Team History Updation Failed");
			console.log(data);
		});
	};
	
	// mock delete emp project history 
	$scope.deleteEmpHistoryMain = function(empProjectHistoryId) {
		$scope.deleteEmpProjHistoryId = empProjectHistoryId;
	};
	
	//actually delete emp project history
	$scope.deleteEmpProjectHistory =  function(empProjectHistoryId) {
		
		var empProjectHistory = {
			emp_proj_history_id: empProjectHistoryId,
		};
		
		$http.post($scope.baseURL + '/ProjectsAndTeams/DeleteEmployeeProjectHistory', 
				empProjectHistory)
		.success(function(result) {
			$('#deleteEmpProjectHistoryModal').modal('hide');
			toaster.pop('success', "Notification", "Employee Project Team History Deleted Successfully");
			setTimeout(function () {
			      window.location.reload();
			 }, 1000);
		})
		.error(function(data, status) {
			$('#deleteEmpProjectHistoryModal').modal('hide');
			toaster.pop('error', "Notification", "Employee Project Team History Deletion Failed");
			console.log(data);
		});
	};
	
}]);  