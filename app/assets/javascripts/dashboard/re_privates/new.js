$(document).ready(function(){
  $("#re_private_state_id").change(function(){
    $.ajax({
      url: "/update_cities/re_private_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#re_private_state_id :selected").val()
      }
    });
  });
});
