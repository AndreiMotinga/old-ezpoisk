$(document).ready(function(){
  var url = $(".pagination .next a").attr("href");
  if(url) {
    $('#load-more').removeClass("hidden")
  }
});

$(document).on("click","#load-more", function(e){
  $('#load-more').toggleClass("hidden")
  $("#p2").toggleClass("hidden");
  var url = $(".pagination .next a").attr("href");
  if(url) {
    $(".pagination").html("");
    $.getScript(url).done(function () {
      $("#p2").toggleClass("hidden");
      if($(".pagination").length) {
        $('#load-more').toggleClass("hidden")
      }
    });
  }
});
