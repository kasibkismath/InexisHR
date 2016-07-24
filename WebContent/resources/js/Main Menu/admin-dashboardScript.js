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
	$('#employee-tile').click(function() {
		$(location).attr('href', contextPath + '/employeeProfile');
	});
	$('#employee-tile').css({
		"cursor" : "pointer"
	});

	// leave tile
	$('#leave-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#leave-tile').css({
		"cursor" : "pointer"
	});

	// performance appraisal tile
	$('#performanceAppraisal-tile').click(function() {
		$(location).attr('href', contextPath + '/Performance');
	});
	$('#performanceAppraisal-tile').css({
		"cursor" : "pointer"
	});

	// projects and team member tile
	$('#projectTeamMember-tile').click(
			function() {
				$(location).attr('href', contextPath + '/admin-main-menu');
			});
	$('#projectTeamMember-tile').css({
		"cursor" : "pointer"
	});

	// recruitment tile
	$('#recruitment-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#recruitment-tile').css({
		"cursor" : "pointer"
	});

	// contracts tile
	$('#contracts-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#contracts-tile').css({
		"cursor" : "pointer"
	});

	// reports tile
	$('#reports-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#reports-tile').css({
		"cursor" : "pointer"
	});

	// administration tile
	$('#administration-tile').click(function() {
		$(location).attr('href', contextPath + '/administration');
	});
	$('#administration-tile').css({
		"cursor" : "pointer"
	});

	// attendance tile
	$('#attendance-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#attendance-tile').css({
		"cursor" : "pointer"
	});

	// training tile
	$('#training-tile').click(function() {
		$(location).attr('href', contextPath + '/admin-main-menu');
	});
	$('#training-tile').css({
		"cursor" : "pointer"
	});
});