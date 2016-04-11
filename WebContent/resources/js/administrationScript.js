$(function() {

	$('#deleteUserOK').click(function() {
		$('#deleteUserModal').modal('hide');
	});

});


// function edit user
function editUserModal(username) {

	$(function() {
		var user = {
			username : username
		};

		// get contents of edit user
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : contextPath + "/administration/user/getEditUser",
			data : JSON.stringify(user),
			dataType : 'json',
			success : function(data) {
				var editUserData = data;
			},
			error : function(e) {
				console.log("ERROR: ", e);
			},
			done : function(e) {
				console.log("DONE");
			}
		});
	});

};
