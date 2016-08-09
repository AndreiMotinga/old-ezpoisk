$(document).on('click','.comment-reply', function(e){
  e.preventDefault();
  var form = $(this).closest('.comment').find('.reply-form');
  form.toggle();
  form.find("input").focus();
});

$(document).on('keypress','[data-action="enter"]', function(e){
  if(e.which == 13 && e.shiftKey){
    var count = $(this).attr('rows');
    count = parseInt(count) + 1;
    $(this).attr('rows', count);
  }
  else if (e.which == 13 && !e.shiftKey){
    $(this).closest("form").submit();
    e.preventDefault();
    $(this).val("");
    return false;
   }
});

