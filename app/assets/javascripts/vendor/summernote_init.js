$(document).ready(function(){
  $(".summernote").summernote({
    toolbar: [
      // [groupName, [list of button]]
      ['style', ['bold', 'italic', 'underline', 'clear']],
      // ['font', ['strikethrough', 'superscript', 'subscript']],
      // ['fontsize', ['fontsize']],
      // ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert', ['picture', 'link', 'video', 'table', 'hr']],
      ['misc', ['undo', 'redo', 'codeview']],
      // ['height', ['height']]
    ],
    disableResizeEditor: true,
    lang: 'ru',
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
  $('.note-editable').css('min-height','300px');
  $('.note-statusbar').hide();

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
      url: '/summernote',
      cache: false,
      contentType: false,
      processData: false,
      success: function(data) {
        return $(".summernote").summernote("insertImage", data.url);
      }
    });
  }
});
