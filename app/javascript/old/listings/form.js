$(document).on("change","#listing_category", function(e){
  // get subcategories for service
  var kind = $("#listing_kind").val();
  var category = $(this).val()
  if(kind === "услуги") {
    getSubcategories(category);
  }

  // hide duration if kind is re and category is permanent (e.g sale)
  var duration = $("#duration");
  if (category === "хочу-купить" || category === "продаю") {
    duration.addClass("hidden");
  } else {
    duration.removeClass("hidden");
  }
});

function getSubcategories(category){
  $.ajax({
    url: "/listings/subcategories",
    type: "GET",
    dataType: "script",
    data: {
      attrs: {
        category: category
      }
    }
  });
}
