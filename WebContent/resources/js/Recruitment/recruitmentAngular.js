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
		
		// functions
		$scope.getVacanciesByYear();
		
		// set datatable configs
		 // vacancy datatable
		$scope.vacancyTableOptions = DTOptionsBuilder.newOptions()
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
		
		var vacancy = {
			vacancy_id : vacancyId
		};
		
		$http.post($scope.baseURL + '/Recruitment/GetVacancyByVacancyId', vacancy)
		.success(function(result) {
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
	}
	
}]);