$(document).on("click","#toggle-comments", function(e){
  e.preventDefault();
  var id = $(this).data('id')
  $("#comments-container[data-id='" + id + "']").toggleClass("hidden")
});

$(document).on('keypress','[data-action="enter"]', function(e){
  if (e.which == 13){
    $(this).closest("form").submit();
    e.preventDefault();
    $(this).val("");
    return false;
  }
});

$(document).on('focus','[data-action="enter"]', function(e){
  var user_logged_in = getCookieValue("signed_in=1");
  if(!user_logged_in) {
    $('#new_session_modal').modal('show');
  }
});

$(document).on('click','[data-action="respond"]', function(e){
  e.preventDefault();
  var name = $(this).data('name');
  var id = $(this).data('id');
  var form = $(this).parents("#comments-container").find("form");
  form.find("[data-parent]").val(id);
  form.find("textarea").val(name + ", ").focus();
});

$(document).ready(function(){
  var observe;
  if (window.attachEvent) {
    observe = function (element, event, handler) {
      element.attachEvent('on'+event, handler);
    };
  }
  else {
    observe = function (element, event, handler) {
      element.addEventListener(event, handler, false);
    };
  }

  var fields = $("[data-id='new-comment'], .note-editable");
  $.each(fields, function(i, el){
    function resize () {
      el.style.height = 'auto';
      var h = el.scrollHeight > 10 ? 2 : 32;
      el.style.height = el.scrollHeight + h +'px';
    }
    /* 0-timeout to get the already changed text */
    function delayedResize () {
      window.setTimeout(resize, 0);
    }
    observe(el, 'change',  resize);
    observe(el, 'cut',     delayedResize);
    observe(el, 'paste',   delayedResize);
    observe(el, 'drop',    delayedResize);
    observe(el, 'keydown', delayedResize);

    // el.focus();
    // el.select();
    resize();
  });
});

// find cookie to see wether user sidned_in
function getCookieValue(cookieName) {
  var ca = document.cookie.split('; ');
  return _.find(ca, function (cookie) {
    return cookie.indexOf(cookieName) === 0;
  });
}
