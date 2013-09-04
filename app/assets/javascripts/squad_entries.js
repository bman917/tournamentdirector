$(document).on('click', '#submit_game', function(){
	
	$('.error_explanation').hide();

	$('.game_field').each(function(index){
		var val = $(this).val();
		if (val == null || val == "" || val < 0 || val > 300)
		{
			$(this).addClass('field_with_errors');
			$('.error_explanation').show();
			event.preventDefault();
		}
		else
		{
			$(this).removeClass('field_with_errors');
		}
	});

	$('.field_with_errors:first').focus();
});