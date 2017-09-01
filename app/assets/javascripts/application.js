//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require jquery-ui/core
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/autocomplete
//= require plyr
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  // Plyp
  plyr.setup();

  // Sortable
  $("[data-js-sortable]").sortable({
    axis: 'y',
    handle: '[data-js-sortable-handle]',
    stop: function() {
      var url = $(this).data('js-sortable');
      var data = $(this).sortable('serialize');
      $.post(url, data);
    }
  });

  // Tags
  $('#video_tag_list').tagsInput({
    width: '100%',
    height: 'auto'
  });

  // Summernote
  $('[data-js-wysiwyg]').summernote({toolbar: [
    ['insert', ['link']],
    ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
    ['para', ['ul', 'ol', 'paragraph']],
    ['misc', ['fullscreen', 'undo', 'redo']]
  ]});
});
