$(document).ready(function() {
  if($(".pagination").length) {
    $(window).scroll(function(){
      var url = $(".pagination .next_page a").attr("href");
      var scrollTop = $(window).scrollTop();
      var bottom = $(document).height() - $(window).height() - 400;
      if(url && scrollTop > bottom) {
        $(".pagination").text("Fetching more listings...");
        $.getScript(url);
      }
    });
    $(window).scroll();
  }
});
