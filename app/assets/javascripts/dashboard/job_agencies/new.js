$(document).ready(function(){
  $("#job_agency_state_id").change(function(){
    $.ajax({
      url: "/update_cities/job_agency_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#job_agency_state_id :selected").val()
      }
    });
  });
});
