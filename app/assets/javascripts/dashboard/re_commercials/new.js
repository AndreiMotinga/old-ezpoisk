$(document).ready(function(){
  $("#re_commercial_state_id").change(function(){
    $.ajax({
      url: "/update_cities/re_commercial_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#re_commercial_state_id :selected").val()
      }
    });
  });
});
