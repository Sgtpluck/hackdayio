$(document).on('click', '.self-vote', function(event) {
  $('#alerts').empty();
  $('#alerts').append("<div class='alert alert-warning'>" +
                      "Hey, stop trying to vote for yourself!" +
                      "<a class='close' data-dismiss='alert' href>&times;</a>" +
                      "</div>");
});