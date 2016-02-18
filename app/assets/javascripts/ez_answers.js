$(document).ready(function() {
  $("#search").autocomplete({
    source: "/search_suggestions"
  });
});

