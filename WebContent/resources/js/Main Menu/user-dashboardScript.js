$(function() {
	// loader
	// Show full page Loading Overlay
	$.LoadingOverlay("show", {
		image : "",
		fontawesome : "fa fa-spinner fa-spin"
	});

	// set on the browser cursor loading
	$("body").css("cursor", "progress");

	// Hide it after 2 seconds
	setTimeout(function() {
		$.LoadingOverlay("hide");
		$("body").css("cursor", "default");
	}, 2000);

	// employee tile
	$('#myProfile-tile').click(function() {
		$(location).attr('href', contextPath + '/employeeProfile/MyProfile');
	});
	$('#myProfile-tile').css({
		"cursor" : "pointer"
	});

	
});