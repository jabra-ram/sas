$('#mark-read-btn').on('click', function () {
  $.ajax({
    type: 'POST',
    url: '/markread',
    dataType: 'json',
    success: function (res) {
      $('#notifications-container p').removeClass('bold');
      $('#notification-count').text("");
    },
    error: function (error) {
      console.error(error);
    }
  });
});




