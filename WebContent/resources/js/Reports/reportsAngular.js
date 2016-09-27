var reports = angular.module('reports', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker', 'datatables.buttons' 
                                                 ]);

reports.controller('reportsMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
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
		$scope.checkFromToDateResult = false;

		// functions
		$scope.getAllAttendanceReportOptions = DTOptionsBuilder.newOptions()
        .withButtons([
		               {
		            	   extend: 'print',
		            	   title: 'All Attendance Report'
		               },
		               {
		                   extend: 'excelHtml5',
		                   title: 'All Attendance Report'
		               },
		               {
		                   extend: 'csvHtml5',
		                   title: 'All Attendance Report'
		               },
		               {
		                   extend: 'pdfHtml5',
		                   title: 'All Attendance Report',
		                   customize: function ( doc ) {
		                       doc.content.splice( 1, 0, {
		                           margin: [ 0, 0, 0, 12 ],
		                           alignment: 'center',
		                           image: 'data:image/jpeg;base64,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'
		                       } );
		                   }
		               }
		           ]);
		
		$scope.employeeHoursWorkedReportOptions = DTOptionsBuilder.newOptions()
        .withButtons([
		               {
		            	   extend: 'print',
		            	   title: 'Hours Worked by Employees Report'
		               },
		               {
		                   extend: 'excelHtml5',
		                   title: 'Hours Worked by Employees Report'
		               },
		               {
		                   extend: 'csvHtml5',
		                   title: 'Hours Worked by Employees Report'
		               },
		               {
		                   extend: 'pdfHtml5',
		                   title: 'Hours Worked by Employees Report',
		                   customize: function ( doc ) {
		                       doc.content.splice( 1, 0, {
		                           margin: [ 0, 0, 0, 12 ],
		                           alignment: 'center',
		                           image: 'data:image/jpeg;base64,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'
		                       } );
		                   }
		               }
		           ]);
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
	
	// check all attendance From - To Dates 
	$scope.checkFromToDate = function(fromDate, toDate) {
		if(toDate < fromDate) {
			$scope.checkFromToDateResult = true;
		} else {
			$scope.checkFromToDateResult = false;
		}
	};
	
	// get all attendances for report
	$scope.getAllAttendacesForReport = function(fromDate, toDate) {
		
		var attendance = {
			fromDate : fromDate,
			toDate : toDate
		};
		
		$http.post($scope.baseURL + '/Reports/GetAllAttendacesForReport', attendance)
		.success(function(result) {
			$scope.showAllAttendanceTable = true;
			$scope.allAttendancesReportResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get employee hours worked report
	$scope.getEmployeeHoursWorkedReport = function(fromDate, toDate) {
		
		var attendance = {
			fromDate : fromDate,
			toDate : toDate
		};
			
		$http.post($scope.baseURL + '/Reports/GetEmployeeHoursWorkedReport', attendance)
		.success(function(result) {
			$scope.employeeHoursWorkedReportResult = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	}
	
}]);  