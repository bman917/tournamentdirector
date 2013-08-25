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
    $('#new_bowler').remove();
    $('#new_bowler_link').show();
    $('#search_form').hide();
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

$(document).ready(function() {
  bind();
});
