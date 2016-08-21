document.addEventListener("turbolinks:load", function() {
  $(".description img").addClass("img-responsive");
  $(".post img").addClass("img-responsive center-block");
  $(".post iframe").addClass("center-block");
  $(".answer img").addClass("img-responsive center-block");
  $(".answer iframe").wrap('<div class="embed-responsive embed-responsive-16by9"></div>');
  $(".answer iframe").addClass("embed-responsive-item");
});
