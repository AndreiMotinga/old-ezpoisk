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
    $("#login_link").trigger("click");
  }
});

document.addEventListener("turbolinks:load", function(){
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

  var fields = $("[data-id='new-comment']");
  $.each(fields, function(i, el){
    function resize () {
      el.style.height = 'auto';
      el.style.height = el.scrollHeight+2+'px';
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
