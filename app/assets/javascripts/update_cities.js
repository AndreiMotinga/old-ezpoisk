document.addEventListener("turbolinks:load", function() {
  $(".state-select-slug").change(function(){
    console.log($(".state-select :selected").val())
    $.ajax({
      url: "/cities",
      type: 'GET',
      dataType: 'script',
      data: {
        state_slug: $(".state-select-slug :selected").val()
      }
    });
  });

  $(".state-select-id").change(function(){
    console.log($(".state-select :selected").val())
    $.ajax({
      url: "/cities",
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $(".state-select-id :selected").val()
      }
    });
  });
});
