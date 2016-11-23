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

// find cookie to see wether user sidned_in
function getCookieValue(cookieName) {
  var ca = document.cookie.split('; ');
  return _.find(ca, function (cookie) {
    return cookie.indexOf(cookieName) === 0;
  });
}

function createFavorite(el) {
  var id = $(el).data("id");
  $("[data-listing-id=" + id + "]").remove();

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
  $("[data-listing-id=" + id + "]").remove();

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

$(document).on('click','[data-action="deactivate"]', function(e){
  e.preventDefault();
  var user_logged_in = getCookieValue("signed_in=1");
  if(user_logged_in) {
    var id = $(this).data("id");
        type = $(this).data("type");
    deactivate(id, type);
  } else {
    $("#login_link").trigger("click");
  }
});

function deactivate(id, type){
  $.ajax({
    url: "/deactivations",
    type: 'POST',
    data: {
      deactivation: { deactivatable_id: id, deactivatable_type: type }
    }
  });
}
