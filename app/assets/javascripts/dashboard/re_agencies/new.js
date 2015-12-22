$(document).ready(function(){
  $("#re_agency_state_id").change(function(){
    $.ajax({
      url: "/update_cities/re_agency_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#re_agency_state_id :selected").val()
      }
    });
  });
});
