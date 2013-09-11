function bind() {
  unbind();
  $(document).unbind('keyup', escListener);
  $(document).keyup(newBowlerKeyLister);
  $(document).keyup(searchListener);
  
}

function unbind() {
 $(document).unbind('keyup', newBowlerKeyLister);
 $(document).unbind('keyup', searchListener);
 $(document).keyup(escListener);
}


/*
 * Add Bolwer
 */

function newBowlerKeyLister(event) {
  var n = 78;

  if (event.keyCode == n) {
  	$('#new_bowler_link').click();
  }
}

function escListener(event) {
  var esc = 27;
  if (event.keyCode == esc) {
    $('#new_bowler_row').hide();
    $('#search_form').hide();
    $('#new_bowler_link').show();
    bind();
  }
}

function searchListener(event) {
    var s = 83;
    if (event.keyCode == s) {
      $('#search_bowler_link').click();
    }
}

/*
 * Add Bolwer
 */
$(document).on('click', '#new_bowler_link', function(event) {
  event.preventDefault();
  $("#new_bowler_row").show();
  $("#bowler_last_name").focus();
  unbind();
});

/*
 * Search Form
 */

$(document).on('click', '#search_bowler_link', function(event) {
  event.preventDefault();
  $('#search_form').show();
  $('#search').focus();
  unbind();
});

$(document).on('click','#hide_new_bowler_row_link', function() {
	event.preventDefault;
	$('#new_bowler_row').hide();
	bind();
});

/*
 * For lag time while adding new bowlers.....
 */

$(document).on('submit', '#new_bowler', function() {
  $('.field_with_errors').toggleClass('field_with_errors');
  var bowler_name = $('#bowler_name').val().replace(/\s/g, "");
  $('#new_bowler_row').after("<tr id=\"adding_" + bowler_name +"\"><td colspan=\"8\">Adding " + $('#bowler_name').val() + "...</td></tr>");
  $(':text').val("");
})

function removeAdding(bowler_name) {
  var bowler_name = bowler_name.replace(/\s/g, "");
  $('#adding_'+bowler_name).remove();
}