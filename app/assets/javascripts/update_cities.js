$(document).ready(function(){
  $(".state-select-slug").change(function(){
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
