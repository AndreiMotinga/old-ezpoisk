document.addEventListener("turbolinks:load", init);
$(document).ajaxComplete(init);

function init(){
  var is_touch_device = ("ontouchstart" in window) || window.DocumentTouch && document instanceof DocumentTouch;

  $("[data-toggle='popover']").popover({
    html: true,
    trigger: is_touch_device ? "click" : "hover"
  });

  $('[data-toggle="tooltip"]').tooltip();
}
