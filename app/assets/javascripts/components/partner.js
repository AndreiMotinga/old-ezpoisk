$(document).ready(function(){
  $("#partner_final_url").on("change keyup paste", function(){
    $(".js-final-url").html( $(this).val() )
  });

  $("#partner_title").on("change keyup paste", function(){
    var title = $(".js-title");
    var new_title = $(this).val();
    title.html(new_title);
    $("label[for=partner_title]").html("Заголовок " + (45 - new_title.length));
  });

  $("#partner_headline").on("change keyup paste", function(){
    var desc = $(".js-headline");
    var new_desc = $(this).val();
    desc.html(new_desc);
    $("label[for=partner_headline]").html("Легенда " + (45 - new_desc.length));
  });

  $("#partner_description").on("change keyup paste", function(){
    var desc = $(".js-description");
    var new_desc = $(this).val();
    desc.html(new_desc);
    $("label[for=partner_description]").html("Описание " + (45 - new_desc.length));
  });

  $("#partner_image").on("change keyup paste", function(){
    var desc = $("#uploadFile").val( this.files[0].name );
    if (this.files && this.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('.js-image').attr('src', e.target.result);
      }
      reader.readAsDataURL(this.files[0]);
    }
  });
});
