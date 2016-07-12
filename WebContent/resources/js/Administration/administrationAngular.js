var administration = 
	angular.module('administration', ['ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 'validation.match',
	                                  	'datatables', 'angular-convert-to-number']);
/* Directives */
	// unique username
administration.directive('ngUnique', ['$http', function (async) {
    return {
        require: 'ngModel',
        link: function (scope, elem, attrs, ctrl) {
            elem.on('input', function (evt) {
                scope.$apply(function () {                   
                    var val = elem.val();
                    var req = { "username": val }
                    var ajaxConfiguration = { method: 'POST', url: contextPath + '/administration/user/checkUserExists', data: req };
                    async(ajaxConfiguration)
                        .success(function(data, status, headers, config) {   
                        		ctrl.$setValidity('unique', data);
                        });
                });
            });
        }
    }
}]);

// controller
administration.controller('mainController', 
			['$scope', '$http', '$compile', 'toaster', 'DTOptionsBuilder', 'DTColumnBuilder',
            function ($scope, $http, $compile, toaster, DTOptionsBuilder, DTColumnBuilder) {
				
	// Angular Data Table configuration
				
	$scope.dtColumns = [
	                    //here We will add .withOption('name','column_name') for send column name to the server 
	                    DTColumnBuilder.newColumn("username", "Username").withOption('name', 'username'),
	                    DTColumnBuilder.newColumn("email", "Email").withOption('name', 'email'),
	                    DTColumnBuilder.newColumn("enabled", "Enabled").withOption('name', 'enabled'),
	                    DTColumnBuilder.newColumn("authority", "Role").withOption('name', 'authority'),
	                    DTColumnBuilder.newColumn(null).withTitle('Actions')
	                    	.renderWith(function(data, type, full, meta) {
	                        return '<button class="btn btn-primary" id="editUser" data-toggle="modal" data-target="#editUserModal" ng-click="editUserMain('+ data.id +')"><i class="fa fa-pencil fa-lg"></i> Edit</button>&nbsp;' +
	                            '<button class="btn btn-danger" id="deleteUser1" data-toggle="modal" data-target="#deleteUserModal" ng-click="deleteUserMain(' + data.id + ')"><i class="fa fa-trash fa-lg"></i> Delete</button>';
	                    })
	                ];
	
	 $scope.dtOptions = DTOptionsBuilder.newOptions()
	 .withOption('ajax', {
         url: contextPath + '/administration/user/all',
         type:"GET"
     })
     .withOption('createdRow', function(row, data, dataIndex) {
              $compile(angular.element(row).contents())($scope);
      })
     .withPaginationType('full_numbers')
     .withDisplayLength(10);
	 
	 /**
	  * Custom Angular Codes
	  */	 
	 
	// gets all users
	$scope.getAllUsers = function () {
		// get all users
		$http.get(contextPath + '/administration/user/all')
		.success(function(result){
			$scope.users = result;
			console.log($scope.users);
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// gets all employee
	$http.get(contextPath + '/employeeProfile/employee/all')
	.success(function(result) {
		$scope.employees = result;
		console.log($scope.employees);
	})
	.error(function(data, status) {
		console.log(data);
	})
	
	// deleteUserMain function from the administration.jsp #deleteuser1 button
	$scope.deleteUserMain = function (id) {
		// deleteUser function from deleteUserModal.jsp
		$scope.deleteUser = function () {
			
			var user = {id : id};
			
			$http.post(contextPath + '/administration/user/delete', user)
			.success(function(result){
				$('#deleteUserModal').modal('hide');
				toaster.pop('success', "Notification", "User was deleted sucessfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 2000);
			})
			.error(function(data, status){
				console.log(data);
			});
		};
	};
	
	// get's the clicked edit username to render the data of that user
	$scope.editUserMain= function (id) {
		var user = {id: id};
		
		$http.post(contextPath + '/administration/user/getEditUser', user)
		.success(function(result){
			$scope.getEditUsername = result.username;
			$scope.getEditEmail = result.email;
			$scope.getEditAuthority = result.authority;
			$scope.getEditEnabled = result.enabled;
			$scope.getEditEmpId = result.employee.empId;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// update user detail edits
	$scope.updateEditUser = function (username, email, authority, enabled, empId){
		var user = {
			username : username,
			email : email,
			authority : authority,
			enabled : enabled,
			employee : {empId : empId}
		};
		$http.post(contextPath + '/administration/user/updateEditUser', user)
		.success(function(result){
			$('#editUserModal').modal('hide');
			toaster.pop('success', "Notification", "User details were updated successfully");
			setTimeout(function () {
                window.location.reload();
            }, 1000);
		})
		.error(function(data, status){
			console.log(data);
			$('#editUserModal').modal('hide');
			toaster.pop('error', "Notification", "User details were not updated");
		});
	};
	
	// sets the enabled field value in addNewUserModal.jsp
	$scope.saveNewEnabled = true;
	
	// add new user
	$scope.addNewUser = function (username, password, email, authority, empId, enabled) {
		var user = {
				username : username,
				password: password,
				email : email,
				authority : authority,
				enabled : enabled,
				employee : {empId: empId}
			};
			$http.post(contextPath + '/administration/user/addNewUser', user)
			.success(function(result){
				$('#addNewUserModal').modal('hide');
				toaster.pop('success', "Notification", "A new user was created successfully");
				setTimeout(function () {
	                window.location.reload();
	            }, 2000);
			})
			.error(function(data, status){
				console.log(data);
				$('#addNewUserModal').modal('hide');
				toaster.pop('error', "Notification", "Creating new user failed");
			});
	};
	
	// Backup Database - backup.jsp page
	$scope.backupDatabase = function () {
		$http.get(contextPath + '/backupDatabase')
		.success(function(status) {
			toaster.pop('success', "Notification", "Database Backup was taken successfully. The backup was created in the DOWNLOADS folder.");
			console.log(status);
		})
		.error(function(data, status){
			console.log(data);
			toaster.pop('error', "Notification", "Database Backup FAILED");
		});
	};
	
	// Restore Database
	$scope.restoreDatabase = function () {
		var fileName = $('input[type=file]')[0].files[0].name;
		$http.post(contextPath + '/restoreDatabase', {fileName : fileName})
		.success(function(status) {
			toaster.pop('success', "Notification", "Database was restored successfully.");
			console.log(status);
		})
		.error(function(data, status){
			console.log(data);
			toaster.pop('error', "Notification", "Database restore FAILED");
		});
	};
	
	$scope.getAllUsers();
}]);