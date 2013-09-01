$(document).on('change', '#tournament_bowlers_class_name', filterTable);
$(document).on('change', '#tournament_game_type_name', filterTable);

function filterTable() {
	var category_css = $('#tournament_bowlers_class_name').val();
	var game_type = $('#tournament_game_type_name').val();
	$('tr.data').hide();
	$('tr.' + category_css + '.' + game_type).show();
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