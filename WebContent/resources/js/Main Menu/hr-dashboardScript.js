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
	
	// performance tile
	$('#performanceAppraisal-tile').click(function() {
		$(location).attr('href', contextPath + '/Performance');
	});
	$('#performanceAppraisal-tile').css({
		"cursor" : "pointer"
	});
	
	// leave tile
	$('#leave-tile').click(function() {
		$(location).attr('href', contextPath + '/Leave');
	});
	$('#leave-tile').css({
		"cursor" : "pointer"
	});
	
	// attendance tile
	$('#attendance-tile').click(function() {
		$(location).attr('href', contextPath + '/Attendance');
	});
	$('#attendance-tile').css({
		"cursor" : "pointer"
	});
});