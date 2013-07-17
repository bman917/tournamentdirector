$(document).on('click','#categories a', showCategory);

function showCategory(event) {
	event.preventDefault();
	$('tr.data').hide();
	var selectVal = $(this).attr('class');
	$("." + selectVal).show();
	$('#categories a').removeClass('selected');
	$(this).addClass('selected');

}