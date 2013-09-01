$(document).on('change', '#tournament_bowlers_class_name', filterTable);
$(document).on('change', '#tournament_game_type_name', filterTable);

function filterTable() {
	var category_css = $('#tournament_bowlers_class_name').val();
	var category_css_text = $('#tournament_bowlers_class_name option:selected').text();
	var game_type = $('#tournament_game_type_name').val();
	$('tr.data').hide();
	$('tr.' + category_css + '.' + game_type).show();

	$('#bowler_category_header').text('Bowlers - ' + game_type + ' ' + category_css_text + ' Division');
	
}

function showAddingRow() {
  $('.field_with_errors').toggleClass('field_with_errors');
  $('#adding').show();
  $(':text').val("");
}

function squadsJS_removeNewRow() {
	$('#error_explanation, .error_explanation').remove();
	$('#new_row').remove();
}