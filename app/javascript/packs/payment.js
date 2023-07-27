let x = $("#payment_student_id");
$(document).ready(getData);
x.on('keyup', getData);
x.on('change', getData);

function getData() {
  if (x.val()) {
    $.ajax({
      url: `/students/${x.val()}`,
      type: 'GET',
      dataType: 'json',
      success: function (response) {
        $("#payment_email").val(response.email);
        $("#payment_name").val(response.name);
        $("#date-of-birth").val(response.date_of_birth);
        $("#payment_academic_year").val(response.academic_year);
        $("#payment_address").val(response.address);
        $("#payment_contact_number").val(response.contact_number);
        $("#payment_date_of_birth").val(response.date_of_birth);
      },
      error: function (error) {
        alert("Student Not Found!!");
      }
    });
  }
}

