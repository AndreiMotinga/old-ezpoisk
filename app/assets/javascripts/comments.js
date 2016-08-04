$(document).on('click','.comment-reply', function(e){
  e.preventDefault();
  var form = $(this).closest('.comment').find('.reply-form');
  form.toggle();
  form.find("input").focus();
});
