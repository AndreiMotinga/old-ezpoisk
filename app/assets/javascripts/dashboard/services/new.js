$(document).ready(function(){

  $("#service_state_id").change(function(){
    $.ajax({
      url: "/update_cities/service_city_id",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#service_state_id :selected").val()
      }
    });
  });

  $("#service_category").change(function(){
    $.ajax({
      url: "/update_subcategory/service_subcategory",
      type: 'GET',
      dataType: 'script',
      data: {
        category: $("#service_category :selected").val()
      }
    });
  });

});
