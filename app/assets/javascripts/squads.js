$(document).on('change', '#tournament_bowlers_class_name', filterTable);
$(document).on('change', '#tournament_game_type_name', filterTable);

function filterTable() {
	var category_css = $('#tournament_bowlers_class_name').val();
	var game_type = $('#tournament_game_type_name').val();
	$('tr.data').hide();
	$('tr.' + category_css + '.' + game_type).show();
}