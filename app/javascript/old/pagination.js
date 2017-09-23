import incrementPartners from './partners'

$(document).ready(function(){
  var url = $(".pagination .next a").attr("href");
  if(url) {
    $('#load-more').removeClass("hidden")
  }
});

$(document).on("click","#load-more", function(e){
  $('#load-more').addClass("hidden")
  $("#p2").removeClass("hidden");
  var url = $(".pagination .next a").attr("href");
  if(url) {
    $(".pagination").html("");
    $.getScript(url).done(function () {
      $("#p2").addClass("hidden");
      if($(".pagination").length) {
        $('#load-more').removeClass("hidden")
      }

    // increment impressions
    incrementPartners()

    }).fail(function(jqxhr, settings, exception){
      console.error(exception)
    });
  }
});
