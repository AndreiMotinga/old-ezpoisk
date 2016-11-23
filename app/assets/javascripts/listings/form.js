$(document).on("change","#listing_kind", function(e){
  // show re_fields if listing is re
  var listing_kind = $(this).val();
  if(listing_kind == "real-estate") {
    $("#re_fields").removeClass("hidden");
  } else {
    $("#re_fields").addClass("hidden");
  }

  // get categories
  var val = $('#listing_kind').val();
  getCategories(val);
});

$(document).on("change","#listing_category", function(e){
  // get subcategories for service
  var kind = $("#listing_kind").val();
  var category = $(this).val();
  if(kind === "services") {
    getSubcategories(category);
  }

  // hide duration if kind is re and category is permanent (e.g sale)
  var duration = $("#duration");
  if(kind === "real-estate" && (category === "buying" || category === "selling")) {
    duration.addClass("hidden");
  } else {
    duration.removeClass("hidden");
  }
});

$(document).on("change","#listing_subcategory", function(e){
  // hide apartment fileds if subcategory is not apartment
  var fields = $("#apartment_fields");
  if (this.value !== "apartment") {
    fields.addClass("hidden");
  } else {
    fields.removeClass("hidden");
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

function getCategories(val) {
  $.ajax({
    url: "/dashboard/listings/categories",
    type: 'GET',
    dataType: 'script',
    data: {
      attrs: {
        kind: val
      }
    }
  });
}