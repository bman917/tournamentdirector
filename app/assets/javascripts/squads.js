$(document).ready(showSelected);
$(document).on('page:load', showSelected);

$(document).change('#division_1', showSelected);

function showSelected() {
	$('tr.data').hide();
	var selectVal = $('#division_1 :selected').val();
	$("." + selectVal).show();
}