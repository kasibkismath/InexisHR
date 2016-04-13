var administration = 
	angular.module('administration', ['ngMessages', 'toaster', 'ngAnimate', 'ngCapsLock', 'validation.match',
	                                  	'datatables']);
/* Directives */
	// unique username
administration.directive('ngUnique', ['$http', function (async) {
    return {
        require: 'ngModel',
        link: function (scope, elem, attrs, ctrl) {
            elem.on('keyup', function (evt) {
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
	                    DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
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
	 	 
	 
	// gets all users
	$scope.getAllUsers = function () {
		// get all users
		$http.get(contextPath + '/administration/user/all')
		.success(function(result){
			$scope.users = result;
			// for enabled checkbox
			//$scope.viewUserEnabled = result.enabled;
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
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
		})
		.error(function(data, status){
			console.log(data);
		});
	};
	
	// update user detail edits
	$scope.updateEditUser = function (username, email, authority, enabled){
		//console.log(username, email, authority, enabled);
		var user = {
			username : username,
			email : email,
			authority : authority,
			enabled : enabled
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
	$scope.addNewUser = function (username, password, email, authority, enabled) {
		//console.log(username + " " + email + " " + authority + " " + enabled);
		var user = {
				username : username,
				password: password,
				email : email,
				authority : authority,
				enabled : enabled
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
		var data = 
			{
				"dumpExePath" : "mysqldump",
				"host" : "localhost",
				"port" : "3306",
				"user" : "root",
				"password" : "RootAdmin@123",
				"database" : "inexis-hr",
				"backupPath" : "F:\\"
			}
		$http.post(contextPath + '/backupDatabase', data)
		.success(function(status) {
			toaster.pop('success', "Notification", "Database Backup was taken successfully");
			console.log(status);
		})
		.error(function(data, status){
			console.log(data);
			toaster.pop('error', "Notification", "Database Backup FAILED");
		});
	};
	
	$scope.getAllUsers();
}]);