$(function() {
	// on load focus
	$("#loginUsername").focus();
	
	// on login failed
	if (error) {
		$("#username").addClass("has-error");
		$("#password").addClass("has-error");
	}
	
	// cancel
	$("#loginCancel").click(function() {
		$("#loginUsername").val("");
		$("#loginPassword").val("");
	});
});
