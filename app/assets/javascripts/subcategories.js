document.addEventListener("turbolinks:load", function() {
  $(".category-select").change(function(){
    $.ajax({
      url: "/subcategories",
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
