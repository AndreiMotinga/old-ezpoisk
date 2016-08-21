document.addEventListener("turbolinks:before-cache", function() {
  $('.my-dropdown').select2('destroy');
  $('.my-dropdown-multiple').select2('destroy');
})
