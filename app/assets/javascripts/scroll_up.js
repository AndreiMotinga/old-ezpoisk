$(window).scroll(function() {
  var link = $('#scrollUp');

  if ($(this).scrollTop() > 1000) {
    link.fadeIn(100);
  } else {
    link.fadeOut(100);
  }
});

$(document).on("click","#scrollUp", function(e){
  $('html, body').animate({scrollTop: 0}, 200);
  return false;
});
