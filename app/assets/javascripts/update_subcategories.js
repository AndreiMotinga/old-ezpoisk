$(document).ready(function(){
  $(".category-select").change(function(){
    $.ajax({
      url: "/update_subcategory",
      type: 'GET',
      dataType: 'script',
      data: {
        category: $(".category-select :selected").val()
      }
    });
  });
});


