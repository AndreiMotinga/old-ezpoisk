document.addEventListener("turbolinks:load", function() {
  $(".post-body iframe").wrap('<div class="embed-responsive embed-responsive-16by9"></div>');
  $(".post-body iframe").addClass("embed-responsive-item center-block");
  $(".post-body img").addClass("img-responsive");
});
