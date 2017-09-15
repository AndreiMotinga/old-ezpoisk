$(document).on("change","#service_category", function(e){
  var category = $(this).val();
  getSubcategories(category);
});
