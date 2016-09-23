var recruitment = angular.module('recruitment', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker']);

recruitment.controller('recruitmentMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
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
	$scope.currentDate = currDate;
	
	
	$scope.init = function(){
		// variables
		$scope.checkMinDaysResult = false;
		$scope.checkDuplicateVacancyResult = false;
		$scope.checkAppliedDateResult = false;
		
		// functions
		$scope.getVacanciesByYear();
		$scope.getAllApplicantsByCurrentYear();
		$scope.getAllPendingNonExpiredVacancies();
		$scope.applicantLeadsSummaryChart();
		$scope.expiredVacanciesCount();
		
		// set datatable configs
		 // vacancy datatable
		$scope.vacancyTableOptions = DTOptionsBuilder.newOptions()
	    .withOption('order', [2, 'desc']);
		
		 // applicant datatable
		$scope.applicantTableOptions = DTOptionsBuilder.newOptions()
	    .withOption('order', [2, 'desc']);
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
	
	// get applicant lead - summary chart
	$scope.applicantLeadsSummaryChart = function() {
		$scope.applicantLeadData = [];
		$scope.applicantLeadLabels = [];
		
		$http.get($scope.baseURL + '/Recruitment/GetApplicantLeads')
		.success(function(result) {
			angular.forEach(result, function(value, key) {
				$scope.applicantLeadLabels.push(value[0]);
				$scope.applicantLeadData.push(value[1]);
			});
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get expired vacancies count
	$scope.expiredVacanciesCount = function () {
		$http.get($scope.baseURL + '/Recruitment/GetExpiredVacanciesCount')
		.success(function(result) {
			$scope.expiredVacanciesCountResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
	// get all vacancies by current year
	$scope.getVacanciesByYear = function() {
		$http.get($scope.baseURL + '/Recruitment/GetVacanciesByYear')
		.success(function(result) {
			$scope.getVacanciesByYearResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// check no of days between added_date and expiry date in add vacancy
	$scope.checkMinDays = function(expiryDate) {
		if(expiryDate != undefined) {
			// hours*minutes*seconds*milliseconds
			var oneDay = 24*60*60*1000; 
			
			var firstDate = new Date(expiryDate);
			firstDate.setDate(firstDate.getDate()+1);
			
			var secondDate = new Date();

			var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
			
			if(diffDays < 7) {
				$scope.checkMinDaysResult = true;
			} else {
				$scope.checkMinDaysResult = false;
			}
		}
	};
	
	// checks for duplicate vacancy by vacancy title and added date = current date
	$scope.checkDuplicateVacancy = function(vacancyTitle) {
		
		var vacancy = {
			vacancy_title: vacancyTitle
		};
		
		$http.post($scope.baseURL + '/Recruitment/CheckDuplicateVacancy', vacancy)
		.success(function(result) {
			$scope.checkDuplicateVacancyResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// add vacancy
	$scope.addVacancy = function(title, jobDesc, roles, work, qualification, expiryDate) {
		
		var date = new Date();
		var status = "Pending";
		
		var vacancy = {
			vacancy_title: title,
			job_desc : jobDesc,
			roles_responsibilities : roles,
			experience : work,
			qualification : qualification,
			added_date : date,
			expiry_date : expiryDate,
			status : status
		};
		
		$http.post($scope.baseURL + '/Recruitment/AddVacancy', vacancy)
		.success(function(result) {
			$('#addVacancyModal').modal('hide');
			toaster.pop('success', "Notification", "Vacancy Added Successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status) {
			$('#addVacancyModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Vacancy Failed");
			console.log(data);
		});
	};
	
	// get vacancy by vacancy_id
	$scope.getVacancyByVacancyId = function(vacancyId) {
		
		var def = $q.defer();
		
		var vacancy = {
			vacancy_id : vacancyId
		};
		
		$http.post($scope.baseURL + '/Recruitment/GetVacancyByVacancyId', vacancy)
		.success(function(result) {
			def.resolve(result);
			$scope.updateVacancyTitle = result.vacancy_title;
			$scope.updateVacancyJob = result.job_desc;
			$scope.updateVacancyRolesAndResp = result.roles_responsibilities;
			$scope.updateVacancyWorkExp = result.experience;
			$scope.updateVacancyQualification = result.qualification;
			$scope.updateVacancyExpiry = $filter('date')(result.expiry_date, "yyyy-MM-dd");
			$scope.updateVacancyId = result.vacancy_id;
			$scope.updateVacancyStatus = result.status;
		})
		.error(function(data, status) {
			console.log(data);
		});
		return def.promise;
	};
	
	// update vacancy
	$scope.updateVacancy = function(vacancyId, title, jobDesc, roles, work, qualification, expiryDate, status) {
		var vacancy = {
			vacancy_id : vacancyId,
			vacancy_title: title,
			job_desc : jobDesc,
			roles_responsibilities : roles,
			experience : work,
			qualification : qualification,
			expiry_date : expiryDate,
			status : status
		};
			
		$http.post($scope.baseURL + '/Recruitment/UpdateVacancy', vacancy)
		.success(function(result) {
			$('#editVacancyModal').modal('hide');
			toaster.pop('success', "Notification", "Vacancy Updated Successfully");
			setTimeout(function () {
	              window.location.reload();
	        }, 1000);
		})
		.error(function(data, status) {
			$('#editVacancyModal').modal('hide');
			toaster.pop('error', "Notification", "Vacancy Updation Failed");
			console.log(data);
		});
	};
	
	// called from vacancy.jsp page
	$scope.deleteVacancyMain = function(vacancyId) {
		$scope.deleteVacancyId = vacancyId;
	};
	
	// actually delete vacancy from delete vacancy modal
	$scope.deleteVacancy = function(vacancyId) {
		
		var vacancy = {
			vacancy_id: vacancyId
		};
			
		$http.post($scope.baseURL + '/Recruitment/DeleteVacancy', vacancy)
		.success(function(result) {
			$('#deleteVacancyModal').modal('hide');
			toaster.pop('success', "Notification", "Vacancy Deleted Successfully");
			setTimeout(function () {
	              window.location.reload();
	        }, 1000);
		})
		.error(function(data, status) {
			$('#deleteVacancyModal').modal('hide');
			toaster.pop('error', "Notification", "Vacancy Deletion Failed");
			console.log(data);
		});
	};
	
	// get all applicants where vacancy_added_date year and vacancy_expiry_date year
	// is equal to current year
	$scope.getAllApplicantsByCurrentYear = function() {
		$http.get($scope.baseURL + '/Recruitment/GetApplicantsByCurrentYear')
		.success(function(result) {
			$scope.getApplicantsByCurrentYearResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all pending non expired vacancies 
	$scope.getAllPendingNonExpiredVacancies = function() {
		$http.get($scope.baseURL + '/Recruitment/GetAllPendingNonExpiredVacancies')
		.success(function(result) {
			$scope.getAllPendingNonExpiredVacanciesResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// check applicant applied date with vacancy added date
	$scope.checkAppliedDate = function(appliedDate, vacancyId) {
		if(appliedDate != undefined && vacancyId != undefined) {
			$scope.getVacancyByVacancyId(vacancyId)
			.then(function(vacancy) {
				var added_date = $filter('date')(vacancy.added_date, "yyyy-MM-dd");
				
				if(appliedDate < added_date) {
					$scope.checkAppliedDateResult = true;
				} else {
					$scope.checkAppliedDateResult = false;
				}
			});
		} else {
			$scope.checkAppliedDateResult = false;
		}
	};
	
	$scope.addApplicant = function(firstName, lastName, vacancyId, email, contactNo, 
			experience, qualification, appliedDate, referredBy) {
		
		var status = "Pending";
		
		var applicant = {
			firstName : firstName,
			lastName : lastName,
			vacancy : {vacancy_id : vacancyId},
			email : email,
			contact_no : contactNo,
			status : status,
			experience : experience,
			qualification : qualification,
			referred_by : referredBy,
			applied_date : appliedDate
		};
		
		$http.post($scope.baseURL + '/Recruitment/AddApplicant', applicant)
		.success(function(result) {
			$('#addApplicantModal').modal('hide');
			toaster.pop('success', "Notification", "Applicant Added Successfully");
			setTimeout(function () {
	              window.location.reload();
	        }, 1000);
		})
		.error(function(data, status) {
			$('#addApplicantModal').modal('hide');
			toaster.pop('error', "Notification", "Adding Applicant Failed");
			console.log(data);
		});
	};
	
	// get applicant by applicant_id
	$scope.getApplicantByApplicantId = function(applicantId) {
		
		var applicant = {applicant_id : applicantId};
		
		$http.post($scope.baseURL + '/Recruitment/GetApplicantByApplicantId', applicant)
		.success(function(result) {
			$scope.updateAppId = result.applicant_id;
			$scope.updateAppFirstName = result.firstName;
			$scope.updateAppLastName = result.lastName;
			$scope.updateAppVacancy = result.vacancy.vacancy_id;
			$scope.updateAppEmail = result.email;
			$scope.updateAppContactNo = result.contact_no;
			$scope.updateAppWorkExp = result.experience;
			$scope.updateAppQualification = result.qualification;
			$scope.updateAppApplied = $filter('date')(result.applied_date, "yyyy-MM-dd");
			$scope.updateAppReferredBy = result.referred_by;
			$scope.updateAppStatus = result.status;
			$scope.updateAppExamResult = result.exam_result;
			$scope.updateAppInterviewResult = result.interview_result;
			console.log(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// update applicant
	$scope.updateApplicant = function(applicantId, firstName, lastName, vacancyId, email, contactNo, experience,
			qualification, appliedDate, referredBy, status, examResult, interviewResult) {
		
		var applicant = {
			applicant_id : applicantId,
			firstName : firstName,
			lastName : lastName,
			vacancy : {vacancy_id : vacancyId},
			email : email,
			contact_no : contactNo,
			status : status,
			experience : experience,
			qualification : qualification,
			referred_by : referredBy,
			applied_date : appliedDate,
			exam_result : examResult,
			interview_result : interviewResult
		};
			
		$http.post($scope.baseURL + '/Recruitment/UpdateApplicant', applicant)
		.success(function(result) {
			$('#editApplicantModal').modal('hide');
			toaster.pop('success', "Notification", "Applicant Updated Successfully");
			setTimeout(function () {
		            window.location.reload();
		    }, 1000);
		})
		.error(function(data, status) {
			$('#editApplicantModal').modal('hide');
			toaster.pop('error', "Notification", "Applicant Updation Failed");
			console.log(data);
		});
	};
	
	// called from applicant.jsp deleteMain
	$scope.deleteApplicantMain = function(applicantId) {
		$scope.deleteApplicantId = applicantId;
	};
	
	// actually delete from delete applicant modal
	$scope.deleteApplicant = function(applicantId) {
		
		var applicant = {applicant_id : applicantId};
		
		$http.post($scope.baseURL + '/Recruitment/DeleteApplicant', applicant)
		.success(function(result) {
			$('#deleteApplicantModal').modal('hide');
			toaster.pop('success', "Notification", "Applicant Deleted Successfully");
			setTimeout(function () {
		            window.location.reload();
		    }, 1000);
		})
		.error(function(data, status) {
			$('#deleteApplicantModal').modal('hide');
			toaster.pop('error', "Notification", "Applicant Deletion Failed");
			console.log(data);
		});
	};
	
}]);