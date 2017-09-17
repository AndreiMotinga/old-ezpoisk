$(window).scroll(function() {
    var nav = $("#navbar-main"),
        scrollTop = $(window).scrollTop();

    if ( scrollTop >= 5) {
        nav.addClass("mdl-shadow--2dp");
    } else {
        nav.removeClass("mdl-shadow--2dp");
    }
});
