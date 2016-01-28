$(document).ready(function() {
  $(function() {
    var type = $("#pictures-data").data("type");
    var id = $("#pictures-data").data("id");

    return $(".summernote").summernote({
      lang: 'ru',
      height: 360,
      codemirror: {
        lineNumbers: true,
        tabSize: 2,
        theme: "solarized light"
      },
      callbacks: {
        onImageUpload: function(files) {
          return sendFile(files[0], type, id);
        }
      }
    });

    function sendFile(file, type, id) {
      var data = new FormData();
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

  });
});
