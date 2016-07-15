$(document).ready(function() {
  $('.pgwSlideshow').pgwSlideshow({
    transitionEffect : 'fading',
    intervalDuration: 5000,
    autoSlide: true
  });
  $('.show .ps-current a').touchTouch();

  $('[data-id="profile-image"]').touchTouch();
});
