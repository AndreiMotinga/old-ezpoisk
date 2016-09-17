$(document).on("click", "[data-id='show-search']", function() {
  var visible = $( "#search-form:visible" ).length;
  if(visible) {
    $("#search-form").slideUp("slow");
  } else {
    $("#search-form").slideDown("slow");
  }
});
