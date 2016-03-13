$(document).ready(function(){
  $(".favor").click(function(e){
    e.preventDefault();

    // toggle color of the star glyphicon
    $(this).find("span").toggleClass("favorite");

    $.ajax({
      url: "/favorites",
      type: 'POST',
      data: {
        "favorite[post_id]": $(this).data("id"),
        "favorite[post_type]": $(this).data("type")
      }
    });
  });
});
