$('#mark-read-btn').on('click', function() {
    $.ajax({
      type: 'POST',
      url: '/markread',
      dataType: 'json',
      success: function(res) {
        $('#notifications-container').empty();
        $('#notification-count').text("0");
      },
      error: function(error) {
        console.error(error);
      }
    });
  });




