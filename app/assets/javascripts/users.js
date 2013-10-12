$(function() {
  $("#generate-token").on('click', function() {
    $.getJSON('get_new_token.json', function(data) {
      $('#user-token').text(data.token);    
    });
  });
});