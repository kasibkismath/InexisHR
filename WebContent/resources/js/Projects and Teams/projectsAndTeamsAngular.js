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
		$scope.checkDuplicateTeamResult = false;
		$scope.checkDuplicateTeamMemberResult = false;
		
		// functions
		$scope.getAllProjects();
		$scope.getAllTeams();
		$scope.getInProgressAndOnHoldProjects();
		$scope.getLeadEmployees();
		$scope.getAllTeamMembers();
		$scope.projectEmployeeSummaryChart();
		
		
		$scope.projectsOptions = DTOptionsBuilder.newOptions()
		           .withButtons([
		               'print',
		               {
		                   extend: 'excelHtml5'
		               },
		               {
		                   extend: 'csvHtml5'
		               },
		               {
		                   extend: 'pdfHtml5',
		                   customize: function ( doc ) {
		                       doc.content.splice( 1, 0, {
		                           margin: [ 0, 0, 0, 12 ],
		                           alignment: 'center',
		                           image: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAAQABAAD/7QCcUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAIAcAmcAFE5ZZDN3TkFpblpZSV9CM0JoVDd6HAIoAGJGQk1EMDEwMDBhYzAwMzAwMDA0OTA3MDAwMDEyMGIwMDAwOTIwYjAwMDAxYzBjMDAwMDI1MTEwMDAwYjQxNTAwMDBhYjE3MDAwMDE4MTgwMDAwN2YxODAwMDBiYjFlMDAwMP/iAhxJQ0NfUFJPRklMRQABAQAAAgxsY21zAhAAAG1udHJSR0IgWFlaIAfcAAEAGQADACkAOWFjc3BBUFBMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD21gABAAAAANMtbGNtcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACmRlc2MAAAD8AAAAXmNwcnQAAAFcAAAAC3d0cHQAAAFoAAAAFGJrcHQAAAF8AAAAFHJYWVoAAAGQAAAAFGdYWVoAAAGkAAAAFGJYWVoAAAG4AAAAFHJUUkMAAAHMAAAAQGdUUkMAAAHMAAAAQGJUUkMAAAHMAAAAQGRlc2MAAAAAAAAAA2MyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHRleHQAAAAARkIAAFhZWiAAAAAAAAD21gABAAAAANMtWFlaIAAAAAAAAAMWAAADMwAAAqRYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9jdXJ2AAAAAAAAABoAAADLAckDYwWSCGsL9hA/FVEbNCHxKZAyGDuSRgVRd13ta3B6BYmxmnysab9908PpMP///9sAQwAFAwQEBAMFBAQEBQUFBgcMCAcHBwcPCwsJDBEPEhIRDxERExYcFxMUGhURERghGBodHR8fHxMXIiQiHiQcHh8e/9sAQwEFBQUHBgcOCAgOHhQRFB4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4e/8AAEQgAXgBkAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A+y6KKKACiiigAooooAKKKKACiiigAooooAKKKKACiimzSJDE8srBERSzMegA5JoAdRWB4C8Y+HPHXh2PxB4W1FdQ06SR4llEbJ8yHDDDAEflyCDW/QAUUUUAFFFFABRXPePPGnhrwNpltqXijU00+1ubuOzhkZGfdK+dq4UE9iSegA5roaACiiigAooooAKCARgjIoooA8m+HHxC0o/s+3vxBsfClro1jYQ6hcnSrJlVP9HkkDYIRQC5QnO3qe9ZWn/Ef40aj4dtvE9j8IdLuNLubZLyG3j8RqbqSFlDjaPLxuKkHb17da5H4af8mHeI/wDsF67/AOjbivb/AIN/8kg8Gf8AYBsf/RCUAP8AAPjvQvGPw9tfG9lK1tps0DyzC5wrWxjJEiydgVKtn6ZrzzT/AIsfEfxTYyeIvAnwqGpeGcsbS41DV0tLm/RSQXiiKnapx8u481x3hSxvLn9lL4padpau0w1HXUijQclRISVA91BGPetn4T+EviJrnw08Oan4e+PF5Bpc2mwfZ4IvDlk6wKEC+VkjJKEFTnnK80AeoeDPH1v42+HQ8WeGtPmlnAkjk066PlTRTxnEkL8HDAg49ePWrh8a6WfBS+JVDsrDYtuP9YZyceTj+9u4/Wsn4OeApPhxoeswX/iSTW5tU1WbVrq7mtUtgJJFXf8AKp2gZUtxgc9K5dJIIPFY8dHTXHhaS+O35zhZSNn2zy+gUnIz+NejgsPCunzLbX1/u+r6fM8TNcZVwsounLSWj0+H+/6LrfTbbU3fi74nh0HwPouo+IfClhqsl1rFjbNZXDq6W8ssmFkBZDlk6jgc9x1qX4n/ABE1Pw/4k0nwf4T8MnxH4m1SGW5jt3u1toILeMgNLJIQeMnAAGT+WcD9q90k8AeH3Rgyt4q0ogg5BHn9a6b4n/Da28ZX2m67p+ual4b8TaSJFsNWsCCyK/3o5Eb5ZIz1Kn8+TXnvVnswVopXuWvhzrfxB1O7vrbxt4KstBSFEa2ubTVVuo7gkncu3aGUrgHJ654rtK8k+G3jHxpY/E64+F3xBOl6hqK6V/athq+nIYluoBJ5bCWI/wCrk3c8cGvW6RQUUUUAFIxCgliABySaWmyxpLG0cihkYFWB6EHqKAPOfC3g3wVbfBjUfBenX1+fDE9vdxzXM7FJPKn3vI6uyAFcOSGAIx3NdN4Kn0Gy8IWun6RdSvYaNax2uZ0ZZUSOJdu9WUHJTa2cDIOR1q3p/h+ztfD8uhSzXV5YyRGDZcSbisRXb5YIAOAvGTk+5pumeHbSysb22M91cvfDFxPPJukcbAgGQABhQAMD3OSSaAML4W6f4R0Lw5fjwzqb3mn3V1Lq000sgYA3I84kHaBtwQQOw681xFx8H/hzLZz+J/D3iHxb4T0u9b7RLHomqz2VtKWIG8REcA5GNoAweOK9S8O+GdM0CO9TTFlhF4yPJ8+cMsax5X0yFBOOrEnqTUdr4T0uDwzc6Bm4e2uWkeRi4VtztuLLtAVMHkBQAD260AZFnoXhfT/hsfDsGp3yaJbSSW008l08kzN55EitI+WOZCQfyHFbevT6HpukwaZqMTLZXZWxihjtpJVO4bQmEU49s4pH8MWL+GJdBM915UztJJP5g81pGk81nzjGS5z0x2xjirlzpUV1bWcN1NNO1rNHOsjEBmdDkFsAD6gAVfPJJK+i1+Zm6NNycmtWrfLt+JyviLwN4b1rQ9J8F6jf37R2NxFqVqBKPNP2eRSuWKkFAWUY64I571meM/CHhD4jeIo54fFfiHTdXsEns3fRNWktXAjdfMRwBjhpF7ZOR1FehPp1u+rw6od/2iK3e3X5uNjsjHj1yi/rWdpnhXSNP199cto5FvZI5o5H8w4cSy+a2R0JDdD1AJFTKTk3J7sqEI04qMVZI5X4VeBPBXhLXdVuNEn1XVdckAgv9V1O4lup3CkfuvOcbeDjKrznGegr0asjTfD9rp+sXGo29xeYmMjfZ2mzCjSMHkZVx1ZlB5Jxk4xk1r0igooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD//Z'
		                       } );
		                   }
		               }
		           ])
		
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
			 
			 console.log(employee + " " + teamId);
			
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
	$scope.addTeamMember = function(employeeId, teamId) {
		
		var teamMember = {
			employee : {empId : employeeId},
			team : {team_Id : teamId}
		};
				
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
	
}]);  