$(function() {

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
	
	// tasks tile
	$('#tasks-tile').click(function() {
		$(location).attr('href', contextPath + '/Tasks');
	});
	$('#tasks-tile').css({
		"cursor" : "pointer"
	});
	
	// recruitment tile
	$('#recruitment-tile').click(function() {
		$(location).attr('href', contextPath + '/Recruitment');
	});
	$('#recruitment-tile').css({
		"cursor" : "pointer"
	});
	
	// training tile
	$('#training-tile').click(function() {
		$(location).attr('href', contextPath + '/Training');
	});
	$('#training-tile').css({
		"cursor" : "pointer"
	});
	
	// contracts tile
	$('#contracts-tile').click(function() {
		$(location).attr('href', contextPath + '/Contracts');
	});
	$('#contracts-tile').css({
		"cursor" : "pointer"
	});
});