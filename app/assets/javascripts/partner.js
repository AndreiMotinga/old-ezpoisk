document.addEventListener("turbolinks:load", function() {
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

  $("[data-description]").on("change keyup paste", function(){
    var desc = $("[data-partner-description]");
    var new_desc = $("[data-description]").val();
    desc.html(new_desc);
    var length = 45 - new_desc.length;
    $("label[for=partner_description]").html("Описание " + length);
  });
});

document.addEventListener("turbolinks:load", incrementPartners);

function incrementPartners(){
  var all = $('[data-partner]:visible');
  $.map(all, function(val, i){
    var id = $(val).data('id');
    $.ajax({
      url: "/dashboard/partners/"+ id +"/increment",
      type: 'POST'
    });
  });
}
