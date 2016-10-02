document.addEventListener("turbolinks:before-cache", function() {
  $('.placeholder').remove();
});
