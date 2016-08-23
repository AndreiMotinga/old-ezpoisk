Dropzone.autoDiscover = false;

document.addEventListener("turbolinks:load", function() {
  if ($(".dropzone").length) {
    var type = $("#pictures-data").data("type");
    var id = $("#pictures-data").data("id");

    // disable auto discover
    Dropzone.autoDiscover = false;

    var dropzone = new Dropzone (".dropzone", {
      dictDefaultMessage: "Перетяните сюда фотографии или кликните",
      maxFilesize: 5, // MB
      paramName: "picture[image]",
      addRemoveLinks: false
    });

    dropzone.on("success", function(file) {
      this.removeFile(file);
      $.getScript("/dashboard/pictures?type=" + type + "&id=" + id);
    });
  }
});
