document.addEventListener("turbolinks:load", init);
$(document).ajaxComplete(init);

function init(){
  var is_touch_device = ("ontouchstart" in window) || window.DocumentTouch && document instanceof DocumentTouch;
  $('.favor').popover({
    html: true,
    trigger: is_touch_device ? "click" : "hover"
  });

  $('.mute').popover({
    html: true,
    trigger: is_touch_device ? "click" : "hover"
  });

  $('.fa-cog').popover({
    html: true,
    trigger: "click"
  });

  $('[data-toggle="tooltip"]').tooltip();
}
