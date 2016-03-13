$(document).ready(function() {
  var is_touch_device = ("ontouchstart" in window) || window.DocumentTouch && document instanceof DocumentTouch;
  $('.favor').popover({
    html: true,
    trigger: is_touch_device ? "click" : "hover"
  });

  $('.fa-cog').popover({
    html: true,
    trigger: "click"
  });

  $('[data-toggle="tooltip"]').tooltip()
});
