$(document).ready(function() {
  $("#question_tag_list").select2({
    placeholder: "Выберите тэги (минимум 1, максимум 5)"
  });
  $(".state-select").select2({});

  var state = $(".state-select").val();

  if (state) {
    $(".city-select").select2({
      allowClear: true,
      multiple: true
    });
  }

  $("#page_list").select2({
    placeholder: "Выберите cтраницы"
  });
});
