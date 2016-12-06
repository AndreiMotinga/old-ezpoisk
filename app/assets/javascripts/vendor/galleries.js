document.addEventListener("turbolinks:load", function() {
  initSlideShow();

  $('.show .ps-current a').touchTouch();

  $('[data-action="touchTouch"]').touchTouch();
});

function initSlideShow(){
  if (!$('.pgwSlideshow').length) { return; }
  var initialized = $(".pgwSlideshow .ps-current").length;
  if (!initialized){
    $('.pgwSlideshow').pgwSlideshow({
      transitionEffect : 'fading',
      intervalDuration: 5000,
      autoSlide: true
    });
  }
}
