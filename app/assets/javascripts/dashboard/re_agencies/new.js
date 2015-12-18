$(document).ready(function(){
  $("#re_agency_state_id").change(function(){
    $.ajax({
      url: "/update_cities",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#re_agency_state_id :selected").val()
      }
    });
  });
});
