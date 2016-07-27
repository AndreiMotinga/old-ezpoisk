$(document).ready(function() {
  $(".description img").addClass("img-responsive");
  $(".post img").addClass("img-responsive");
  $(".answer img").addClass("img-responsive");
  $(".answer iframe").wrap('<div class="embed-responsive embed-responsive-16by9"></div>');
  $(".answer iframe").addClass("embed-responsive-item");
});
