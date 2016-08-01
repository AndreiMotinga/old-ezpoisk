document.addEventListener("turbolinks:load", function() {
  $(".state-select").change(function(){
    $.ajax({
      url: "/update_cities",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $(".state-select :selected").val()
      }
    });
  });
});
