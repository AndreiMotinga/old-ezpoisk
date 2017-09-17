import Dropzone from "dropzone"

// disable auto discover
Dropzone.autoDiscover = false;

const dropzone = new Dropzone (".dropzone", {
  dictDefaultMessage: "Перетяните сюда фотографии или кликните",
  maxFilesize: 5, // MB
  paramName: "picture[image]",
  addRemoveLinks: false
});

const data = document.getElementById('pictures-data').dataset
dropzone.on("success", function(file) {
  this.removeFile(file);
  $.getScript("/pictures?type=" + data.type + "&id=" + data.id);
});
