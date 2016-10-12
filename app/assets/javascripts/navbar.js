$(document).on('click',"[data-action='navbar-search']", function(e){
  e.preventDefault();
  var _this = $(this);

  $("[data-destination]").attr("action", _this.data("path"));
  $("[data-id='navbar-btn'] span:first").text(_this.text());
});
