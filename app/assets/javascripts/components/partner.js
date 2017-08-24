$(document).ready(function(){
  $("#partner_final_url").on("change keyup paste", function(){
    $(".js-final-url").html( $(this).val() )
  });

  $("#partner_headline").on("change keyup paste", function(){
    var desc = $(".js-headline");
    var new_desc = $(this).val();
    desc.html(new_desc);
    $("label[for=partner_headline]").html("Headline " + (50 - new_desc.length));
  });

  $("#partner_subline").on("change keyup paste", function(){
    var desc = $(".js-subline");
    var new_desc = $(this).val();
    desc.html(new_desc);
    $("label[for=partner_subline]").html("Subline " + (50 - new_desc.length));
  });

  $("#partner_text").on("change keyup paste", function(){
    var desc = $(".js-text");
    var new_desc = $(this).val();
    desc.html(new_desc);
    $("label[for=partner_text]").html("Описание " + (160 - new_desc.length));
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
