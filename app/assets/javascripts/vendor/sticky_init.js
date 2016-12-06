document.addEventListener("turbolinks:load", function() {
  $('.sticky').each(function (i, obj) {
    $(obj).sticky({topSpacing:70});
  });
});
