$(document).ready(function(){
  $("#job_state_id").change(function(){
    $.ajax({
      url: "/update_cities/job_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#job_state_id :selected").val()
      }
    });
  });
});
