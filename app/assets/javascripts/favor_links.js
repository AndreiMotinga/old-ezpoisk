$(document).ready(function(){
  $(".favor").click(function(e){
    e.preventDefault();

    var user_logged_in = getCookieValue("signed_in=1")
      if(user_logged_in) {
        createFavorite(this);
      } else {
        $("#login_link").trigger("click");
      }
  });

  // find cookie to see wether user sidned_in
  function getCookieValue(cookieName) {
    var ca = document.cookie.split('; ');
    return _.find(ca, function (cookie) {
      return cookie.indexOf(cookieName) === 0;
    });
  }

  function createFavorite(el) {
    // toggle color of the star glyphicon
    $(el).find("span").toggleClass("favorite");

    $.ajax({
      url: "/favorites",
      type: 'POST',
      data: {
        "favorite[post_id]": $(el).data("id"),
        "favorite[post_type]": $(el).data("type")
      }
    });
  }
});
