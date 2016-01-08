$(document).ready(function(){
  $("#sale_state_id").change(function(){
    $.ajax({
      url: "/update_cities/sale_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#sale_state_id :selected").val()
      }
    });
  });
});
