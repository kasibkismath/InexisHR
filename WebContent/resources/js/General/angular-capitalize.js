angular.module('angular-capitalize', []).filter('capitalize', function() {
	  return function(input, scope) {
		  if (input !== null) {
              return input.replace(/\w\S*/g, function(txt) {
                  return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
              });
          }
	  }
});