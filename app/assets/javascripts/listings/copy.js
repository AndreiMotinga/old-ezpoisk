$(document).on("click","#copy", function(e){
  copyToClipboard($('#text'))
});

$(document).on("click","#half-copy", function(e){
  copyToClipboard($('#half-text'))
});

function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}
