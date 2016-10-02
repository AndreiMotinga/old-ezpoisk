document.addEventListener("turbolinks:before-cache", function() {
  $('.my-dropdown').select2('destroy');
  $('.my-dropdown-multiple').select2('destroy');
});

document.addEventListener("turbolinks:load", function() {
  $('.my-dropdown').each(function (i, obj) {
    if (!$(obj).hasClass('select2-hidden-accessible')) {
      $(obj).select2({
        matcher: matcher
      });
    }
  });

  $('.my-dropdown-multiple').each(function (i, obj) {
    if (!$(obj).hasClass('select2-hidden-accessible')) {
      $(obj).select2({
        multiple: true,
        matcher: matcher
      });
    }
  });
});

function matcher(params, data) {
  // return all opts if seachbox is empty
  if(!params.term) {
    return data;
  } else if(data) {
    var term = params.term.toUpperCase();
    var option = data.text.toUpperCase();
    var j = -1; // remembers position of last found character

    // consider each search character one at a time
    for (var i = 0; i < term.length; i++) {
      var l = term[i];
      if (l == ' ') continue;     // ignore spaces

      j = option.indexOf(l, j+1);     // search for character & update position
      if (j == -1) return false;  // if it's not found, exclude this item
    }
    return data; // return option
  }
}
