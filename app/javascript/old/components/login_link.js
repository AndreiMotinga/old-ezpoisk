$('.js-login').on('click touchstart', function (e) {
  verifyUserLoggedin(e)
});

function verifyUserLoggedin(e) {
  var user_logged_in = getCookieValue("signed_in=1");
  if(!user_logged_in) {
    e.preventDefault()
    $('#new_session_modal').modal('show');
  }
}

// find cookie to see wether user sidned_in
function getCookieValue(cookieName) {
  var ca = document.cookie.split('; ');
  return ca.find(cookie => cookie === cookieName)
}
