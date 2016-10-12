document.addEventListener("turbolinks:load", highlight);
$(document).ajaxComplete(highlight);

function highlight(){
  var term = $("[data-id='listings']").data("term");
  if(!!term) {
    $(".text").each(function(){
      var html = $(this).html();
      $.each(words.split(" "), function(i, word){
        var regex = new RegExp(word, "gi");
        html = html.replace(regex, "<mark>"+word+"</mark>")
      });
      $(this).html(html);
    });
  }
}
