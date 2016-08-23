document.addEventListener("turbolinks:load", function() {

  var scrollUp = function() {

    // Get link
    var link = $('#scrollUp');

    $(window).scroll(function() {
      // If the user scrolled a bit (150 pixels) show the link
      if ($(this).scrollTop() > 1000) {
        link.fadeIn(100);
      } else {
        link.fadeOut(100);
      }
    });

    // On click get to top
    link.click(function() {
      $('html, body').animate({scrollTop: 0}, 200);
      return false;
    });
  };

  scrollUp();
}); // end document ready wrap
