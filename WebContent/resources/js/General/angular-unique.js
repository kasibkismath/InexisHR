angular.module('angular-unique', []).directive('ngUnique', ['$http', function (async) {
return {
    require: 'ngModel',
    link: function (input, scope, elem, attrs, ctrl) {
        elem.on('input', function (evt) {
            scope.$apply(function () {                   
                var val = elem.val();
                var req = { "nicNo": val }
                var ajaxConfiguration = { method: 'POST', url: contextPath + '/employeeProfile/employee/checkEmpExists', data: req };
                async(ajaxConfiguration)
                    .success(function(data, status, headers, config) {   
                    		ctrl.$setValidity('unique', data);
                    });
            });
        });
    }
}
}]);