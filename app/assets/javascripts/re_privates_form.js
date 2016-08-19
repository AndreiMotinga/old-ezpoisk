$(document).on('change',"[data-id='re_private_category']", function(e){
  var fields = $("[data-id='apartment_fields']");

  if (this.value !== "apartment") {
    fields.addClass("hidden");
  } else {
    fields.removeClass("hidden");
  }
});
