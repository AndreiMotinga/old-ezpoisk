$(document).on("click","#copy", function(e){
  copyToClipboard($('#text'))
});

$(document).on("click","#half-copy", function(e){
  copyToClipboard($('#half-text'))
});

$(document).on("click","#copy-comment", function(e){
  copyToClipboard($('#comment'))
});

$(document).on("click","#copy-share", function(e){
  copyToClipboard($('#share'))
});

function copyToClipboard(element) {
  var $temp = $("<textarea>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}
