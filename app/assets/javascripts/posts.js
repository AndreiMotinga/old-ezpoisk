document.addEventListener("turbolinks:load", function() {
  if ($('.post .post-body iframe').length) {
    $("[data-id='post-logo']").addClass('hidden');
  }
});
