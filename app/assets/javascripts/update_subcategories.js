$(document).ready(function(){
  $(".category-select").change(function(){
    $.ajax({
      url: "/update_subcategory",
      type: 'GET',
      dataType: 'script',
      data: {
        attrs: {
          type: $(".category-select").data().type,
          category: $(".category-select :selected").last().val()
        }
      }
    });
  });
});
