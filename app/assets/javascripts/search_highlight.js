document.addEventListener("turbolinks:load", highlight);
$(document).ajaxComplete(highlight);

function highlight(){
  var el = $("[data-id='listings']");
  var term = el.data("term");

  if(!!term) {
    var html = el.html();
    $.each(term.split(" "), function(i, word){
      var regex = new RegExp(word, "gi");
      html = html.replace(regex, "<mark>"+word+"</mark>");
    });
    el.html(html);
  }
}
