$(document).ready(function() {
  $(".q-search").autocomplete({
    source: "/search_suggestions",

    // open link in new tab
    select: function( event, ui ) {
      event.preventDefault();
      openNewTab(ui.item.value);
    },

    // replace input with user selected li
    focus: function(event, ui) {
      event.preventDefault();
      $(".q-search").val(ui.item.label);
    },

    // show menu users clicks on already populated search field
  }).focus(function(){
    $(this).autocomplete('search', $(this).val())
  });

  function openNewTab(uri){
    $('#linkToOpen').remove();
    var link = document.createElement('a');
    link.target = '_blank';
    link.href = uri;
    link.id = 'linkToOpen';

    document.body.appendChild(link);
    $('#linkToOpen')[0].click();
    $('#linkToOpen')[0].remove();
  }

  // monkey patch el to highlight search term
  $.ui.autocomplete.prototype._renderItem = function (ul, item) {
    var t = String(item.label).replace(
        new RegExp(this.term, "gi"),
        "<span class='ui-state-highlight'>$&</span>");
    return $("<li></li>")
      .data("item.autocomplete", item)
      .append( t )
      .appendTo(ul);
  };
});
