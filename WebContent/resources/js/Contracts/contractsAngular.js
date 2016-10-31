var contracts = angular.module('contracts', ['toaster', 'ngAnimate', 'chart.js', 'ngMessages',
                                                 'angular-character-count', 'angular-convert-to-number',
                                                 'datatables', '720kb.datepicker', 'ngFileUpload']);

contracts.controller('contractsMainController', ['$scope', '$http', '$q', 'toaster', '$filter',
                                                'DTOptionsBuilder', 'DTColumnDefBuilder', 
                                                'DTColumnBuilder', 'Upload', '$location',
                                                function($scope, $http, $q, toaster, $filter, 
                                                    		DTOptionsBuilder, DTColumnDefBuilder, 
                                                    		DTColumnBuilder, Upload, $location)  {
	
	// declared variables
	$scope.baseURL = contextPath;
	$scope.currentUser = currentUser;
	
	//current date
	var currDate = new Date();
	currDate.setDate(currDate.getDate()-1);
	$scope.currentDate = $filter('date')(currDate, "yyyy-MM-dd");
	
	
	$scope.init = function(){
		// variables
		$scope.checkFileLengthResult = false;
		$scope.checkMaxFilesResult = false;
		
		// functions
		$scope.getAllEmployees();
		$scope.getAllContracts();
		$scope.getContractsByEmpId();
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
	
	// get all employees
	$scope.getAllEmployees = function() {
		$http.get($scope.baseURL + '/employeeProfile/employee/all')
		.success(function(result) {
			$scope.employees = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get all contracts
	$scope.getAllContracts = function() {
		$http.get($scope.baseURL + '/Contracts/GetAllContracts')
		.success(function(result) {
			$scope.contracts = result;
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
	// get contracts by emp_id
	$scope.getContractsByEmpId = function() {
		$scope.getLoggedInEmployee().
		then(function(employee) {
			var contract = {
				employee: {empId: employee.empId}
			};
				
			$http.post($scope.baseURL + '/Contracts/GetContractsByEmpId', contract)
			.success(function(result) {
				$scope.myContracts = result;
			})
			.error(function(data, status) {
				console.log(data);
			});
		});
	}
	
	// check for file length
	$scope.checkFileLength = function(files) {
		if(files.length > 3) {
			$scope.checkFileLengthResult = true;
		} else {
			$scope.checkFileLengthResult = false;
		}
	};
	
	// get no of files for a given empId
	$scope.getFilesCountByEmpId = function(empId) {
		var def = $q.defer();
		
		var contract = {
			employee: {empId: empId}
		};
		
		$http.post($scope.baseURL + '/Contracts/GetFilesCountByEmpId', contract)
		.success(function(result) {
			def.resolve(result);
		})
		.error(function(data, status) {
			console.log(data);
		});
		return def.promise;
	};
	
	// return files count by empId
	$scope.returnFilesCountByEmpId = function(empId) {
		$scope.getFilesCountByEmpId(empId)
		.then(function(count) {
			$scope.filesCount = count;
		});
	};
	
	// check for max files per employee
	$scope.checkMaxFiles = function(empId, files) {
		if(empId != undefined && files != undefined) {
			$scope.getFilesCountByEmpId(empId).then(function(count) {
				var availableSpace = 3 - count;
				
				if(files.length > availableSpace) {
					$scope.checkMaxFilesResult = true;
				} else {
					$scope.checkMaxFilesResult = false;
				}
			});
		}
	}
	
	// upload contracts form data
	$scope.uploadContracts = function(empId, files) {
		angular.forEach(files, function(file) {
			
			// trim file name and get only the fileName without extension
			var trimName = file.name.trim();
			var uploadFileName = trimName.slice(0, trimName.length-4);
			
			// fileName and empId
			$scope.fileName = uploadFileName + "-" + empId + ".pdf";
			
			var contract = {
				employee: {empId: empId},
				contractURL: $scope.fileName
			};
			
			// upload the file to the server
			Upload.upload({
				url: contextPath + '/Contracts/ContractsFileUpload',
		        method: 'POST',
		        data: {file: file, fileName: $scope.fileName}
	        });
			
			$http.post($scope.baseURL + '/Contracts/AddContract', contract)
			.success(function(result) {
				$('#addContractModal').modal('hide');
				toaster.pop('success', "Notification", "Contract Added Successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 7000);
			})
			.error(function(data, status) {
				$('#addContractModal').modal('hide');
				toaster.pop('error', "Notification", "Adding Contract Failed");
				console.log(data);
			});
		});
	};
	
	$scope.downloadContract = function(contractName) {
		window.open($scope.baseURL + '/Contracts/DownloadContract?fileName=' + contractName, '_self', 'location=yes');
	};
	
	$scope.viewContract = function(contractName) {
		window.open($scope.baseURL + '/Contracts/ViewContract?fileName=' + contractName, '_blank', 'location=yes');
	};
	
	// mock contract deletion
	$scope.deleteContractMain =  function(contractId, contractName) {
		$scope.deleteContractId = contractId;
		$scope.deleteContractName = contractName;
	};
	
	// actually delete the contract
	$scope.deleteContract = function(contractId, contractName) {
		var contract = {
			contractURL: contractName
		};
		
		$http.post($scope.baseURL + '/Contracts/DeleteContract', contract)
		.success(function(result) {
			$scope.deleteContractInfoFromDB(contractId);
			$('#deleteEmpContractModal').modal('hide');
			toaster.pop('success', "Notification", "Contract Deleted Successfully");
			setTimeout(function () {
				window.location.reload();
	        }, 3000);
		})
		.error(function(data, status) {
			$('#deleteEmpContractModal').modal('hide');
			toaster.pop('success', "Notification", "Contract Deletion Failed");
			console.log(data);
		});
	};
	
	// send record deletion request to database
	$scope.deleteContractInfoFromDB = function(contractId) {
		
		var contract = {
			contract_id: contractId
		};
			
		$http.post($scope.baseURL + '/Contracts/DeleteContractInfoFromDB', contract)
		.success(function(result) {
		})
		.error(function(data, status) {
			console.log(data);
		});
	};
	
}]);