$(document).ready(function(){
  $("[data-title]").on("change keyup paste", function(){
    var title = $("[data-partner-title]");
    var new_title = $("[data-title]").val();
    title.html(new_title);
    $("label[for=partner_title]").html("Название " + (45 - new_title.length));
  });

  // $("[data-url]").on("change keyup paste", function(){
  //   var url = $("[data-partner='url']");
  //   var new_url = $("[data-url]").val();
  //   url.html(new_url);
  // });

  $("[data-text]").on("change keyup paste", function(){
    var desc = $("[data-partner-text]");
    var new_desc = $("[data-text]").val();
    desc.html(new_desc);
    var length = 45 - new_desc.length;
    $("label[for=partner_text]").html("Описание " + length);
  });

  function incrementPartners(){
    var all = $('[data-partner]:visible');
    var ids = $.map(all, function(val, i) {
      return $(val).data('id');
    });

    if(ids.length){
      $.ajax({
        type: 'POST',
        url: "/dashboard/partners/increment",
        data: { "ids[]": ids }
      });
    }
  }
});
