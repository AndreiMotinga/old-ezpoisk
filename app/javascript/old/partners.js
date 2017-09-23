function incrementPartners(){
  var all = $('[data-partner]:visible');
  var ids = $.map(all, function(val, i) {
    return $(val).data('id');
  });

  if(ids.length){
    $.ajax({
      type: 'POST',
      url: "/impressions",
      data: { "ids[]": ids }
    });
  }
}

incrementPartners()

export default incrementPartners
