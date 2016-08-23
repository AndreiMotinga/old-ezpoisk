$(document).ready(ready);
document.addEventListener("turbolinks:load", ready)

function ready(){
  // look for div initialized by summernote
  var initialized = $(".summernote + .note-editor").length;
  if(!initialized) {
    initSummernote();
  }
}

function initSummernote(){
  $(".summernote").summernote({
    toolbar: [
      // [groupName, [list of button]]
      ['style', ['bold', 'italic', 'underline', 'clear']],
      // ['font', ['strikethrough', 'superscript', 'subscript']],
      // ['fontsize', ['fontsize']],
      // ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert', ['picture', 'link', 'video', 'table', 'hr']],
      ['misc', ['undo', 'redo']],
      // ['height', ['height']]
    ],
    lang: 'ru',
    height: 200,
    codemirror: {
      lineNumbers: true,
      tabSize: 2,
      theme: "solarized light"
    },
    callbacks: {
      onImageUpload: function(files) {
        return sendFile(files[0]);
      }
    }
  });
}

function sendFile(file) {
  var type = $("#pictures-data").data("type"),
      id = $("#pictures-data").data("id"),
      data = new FormData();
  data.append('picture[image]', file);
  data.append('picture[imageable_id]', id);
  data.append('picture[imageable_type]', type);
  return $.ajax({
    data: data,
    type: 'POST',
    url: '/dashboard/summernote',
    cache: false,
    contentType: false,
    processData: false,
    success: function(data) {
      return $(".summernote").summernote("insertImage", data.url);
    }
  });
}
