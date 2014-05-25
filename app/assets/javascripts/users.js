$(document).ready(function() {
	$('.profile-avatar').click(function(){
		$('#user_avatar').click();
	});

	$('#user_avatar').change(function(){
		var filenName = $(this).val();
		if (filenName){
			$(this).parents('form').submit();
		}
	});

	$('.best_in_place.edit-username').bind("ajax:success", function(){
		$('#logged-username').html($(this).html());
	});
});
