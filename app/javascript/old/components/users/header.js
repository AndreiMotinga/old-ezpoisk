$(document).ready(function(){
  $('#about-show').on('click', function (e) {
    e.preventDefault();
    // swap texts
    var new_text = $("#text").data('text');
    var old_text = $("#text").text();

    $('#text').text(new_text);
    $('#text').data('text', old_text);

    // chnage link text
    var link_text = $(this).text();
    if(link_text === "дальше") {
      $(this).text('спрятать')
    } else {
      $(this).text('дальше')
    }
  });
});
