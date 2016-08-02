document.addEventListener("turbolinks:load", function() {
  $('.my-dropdown').each(function (i, obj) {
      if (!$(obj).hasClass('select2-hidden-accessible')) {
        $(obj).select2();
      }
  });

  $('.my-dropdown-multiple').each(function (i, obj) {
    if (!$(obj).hasClass('select2-hidden-accessible')) {
      $(obj).select2({multiple: true});
    }
  });
});
