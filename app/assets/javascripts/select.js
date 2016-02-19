$(document).ready(function() {
  $(".state-select").select2({});

  var state = $(".state-select").val();

  if (state) {
    $(".city-select").select2({
      allowClear: true,
      multiple: true
    });
  }
});
