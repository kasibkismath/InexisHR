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
		$('#employee-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/employeeProfile');
		}, 630);
	});
	$('#employee-tile').css({
		"cursor" : "pointer"
	});

	// leave tile
	$('#leave-tile').click(function() {
		$('#leave-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/admin-main-menu');
		}, 630);
	});
	$('#leave-tile').css({
		"cursor" : "pointer"
	});

	// performance appraisal tile
	$('#performanceAppraisal-tile').click(
			function() {
				$('#performanceAppraisal-tile').slideUp(700).delay(500).fadeTo(
						"slow", 0.6);

				setTimeout(function() {
					$(location)
							.attr('href', myContextPath + '/admin-main-menu');
				}, 630);
			});
	$('#performanceAppraisal-tile').css({
		"cursor" : "pointer"
	});

	// projects and team member tile
	$('#projectTeamMember-tile').click(
			function() {
				$('#projectTeamMember-tile').slideUp(700).delay(500).fadeTo(
						"slow", 0.6);

				setTimeout(function() {
					$(location)
							.attr('href', myContextPath + '/admin-main-menu');
				}, 630);
			});
	$('#projectTeamMember-tile').css({
		"cursor" : "pointer"
	});

	// recruitment tile
	$('#recruitment-tile').click(function() {
		$('#recruitment-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/admin-main-menu');
		}, 630);
	});
	$('#recruitment-tile').css({
		"cursor" : "pointer"
	});

	// contracts tile
	$('#contracts-tile').click(function() {
		$('#contracts-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/admin-main-menu');
		}, 630);
	});
	$('#contracts-tile').css({
		"cursor" : "pointer"
	});

	// reports tile
	$('#reports-tile').click(function() {
		$('#reports-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/admin-main-menu');
		}, 630);
	});
	$('#reports-tile').css({
		"cursor" : "pointer"
	});

	// administration tile
	$('#administration-tile').click(function() {
		$('#administration-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/administration');
		}, 630);

	});
	$('#administration-tile').css({
		"cursor" : "pointer"
	});

	// attendance tile
	$('#attendance-tile').click(function() {
		$('#attendance-tile').slideUp(700).delay(500).fadeTo("slow", 0.6);

		setTimeout(function() {
			$(location).attr('href', myContextPath + '/admin-main-menu');
		}, 630);

	});
	$('#attendance-tile').css({
		"cursor" : "pointer"
	});
});