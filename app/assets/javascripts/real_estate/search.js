$(document).ready(function(){
  $("#state_id").change(function(){
    $.ajax({
      url: "/update_cities/city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#state_id :selected").val()
      }
    });
  });
});
