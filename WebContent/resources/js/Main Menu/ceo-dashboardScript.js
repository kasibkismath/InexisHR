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
	
	// projects and team member tile
	$('#projectTeamMember-tile').click(function() {
		$(location).attr('href', contextPath + '/ProjectsAndTeams');
	});
	$('#projectTeamMember-tile').css({
		"cursor" : "pointer"
	});
	
	// reports tile
	$('#reports-tile').click(function() {
		$(location).attr('href', contextPath + '/Reports');
	});
	$('#reports-tile').css({
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