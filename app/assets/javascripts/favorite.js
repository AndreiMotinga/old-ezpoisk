$(document).on('click','.favor', function(e){
  e.preventDefault();
  var user_logged_in = getCookieValue("signed_in=1");
  if(user_logged_in) {
    createFavorite(this);
  } else {
    $("#login_link").trigger("click");
  }
});

$(document).on('click','.mute', function(e){
  e.preventDefault();
  var user_logged_in = getCookieValue("signed_in=1");
  if(user_logged_in) {
    createHidden(this);
  } else {
    $("#login_link").trigger("click");
  }
});

$(document).on('click','[data-action="touch"]', function(e){
  e.preventDefault();
  var id = $(this).data("id");
      type = $(this).data("type");
  touchRecord(id, type);
});

function touchRecord(id, type){
  $.ajax({
    url: "/favorites/touch",
    type: 'POST',
    data: {
      record: { id: id, type: type }
    }
  });
}

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
      favorite: {
        "favorable_id": $(el).data("id"),
        "favorable_type": $(el).data("type"),
        "saved": true,
        "hidden": false
      }
    }
  });
}

function createHidden(el, id) {
  // toggle color of the star glyphicon
  var id = $(el).data("id");
  var selector = $("[data-hidden=" + id + "]");
  selector.toggleClass("user-hidden");

  $.ajax({
    url: "/favorites",
    type: 'POST',
    data: {
      favorite : {
        "favorable_id": $(el).data("id"),
        "favorable_type": $(el).data("type"),
        "saved": false,
        "hidden": true
      }
    }
  });
}
