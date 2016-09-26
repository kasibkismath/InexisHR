$(function() {

	// employee tile
	$('#myProfile-tile').click(function() {
		$(location).attr('href', contextPath + '/employeeProfile/MyProfile');
	});
	$('#myProfile-tile').css({
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
});