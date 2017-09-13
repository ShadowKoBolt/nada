//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require jquery-ui/core
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/autocomplete
//= require plyr
//= require jquery.tagsinput.min
//= require thirdparty/summernote.min
//= require thirdparty/summernote-cleaner
//= require underscore-min
//= require gmaps/google

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
  $('[data-js-wysiwyg]').summernote({
    toolbar: [
      ['insert', ['link']],
      ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['misc', ['fullscreen', 'undo', 'redo', 'codeview']]
    ],
    cleaner: {
      action: 'both',
      keepHtml: false,
      keepClasses: false,
      badTags: ['style', 'script', 'applet', 'embed', 'noframes', 'noscript', 'html'],
      badAttributes: ['style', 'start']
    }
  });

  // JS Reveals
  var updateReveals = function(checkbox) {
    var idToReveal = checkbox.data('js-reveals');
    var elementToReveal = $(idToReveal);
    if (checkbox.is(':checked')) {
      elementToReveal.removeClass('hide');
    }
    else {
      elementToReveal.addClass('hide');
    }
  }
  $('[data-js-reveals]').each(function(index, element) {
    var checkbox = $(element);
    checkbox.change(function(event) {
      updateReveals($(event.target));
    });
    updateReveals(checkbox);
  });

  // Maps
  function createSidebarLi(json) {
    return ("<li class='classes--list-item'><a>" + json.serviceObject.title + "</a></li>");
  };

  function bindLiToMarker($li, marker) {
    $li.on('click', function(){
      handler.getMap().setZoom(14);
      marker.setMap(handler.getMap()); //because clusterer removes map property from marker
      marker.panTo();
      google.maps.event.trigger(marker.getServiceObject(), 'click');
    })
  };

  function createSidebar(json_array) {
    _.each(json_array, function(json){
      var $li = $( createSidebarLi(json) );
      $li.appendTo('#classes');
      bindLiToMarker($li, json.marker);
    });
  };

  if ($('#map').length > 0) {
    $.get('/classes/markers', function(data) {
      handler = Gmaps.build('Google');
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers(data);
        _.each(markers, function(json, index){
          json.marker = markers[index];
        });
        createSidebar(markers);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
      });
    });
  }

  $('form[action="/classes/markers"]').submit(function(event) {
    var url = '/classes/markers?' + $(event.target).serialize();
    $.get(url, function(data) {
      $('#classes').html('');
      handler = Gmaps.build('Google');
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers(data);
        _.each(markers, function(json, index){
          json.marker = markers[index];
        });
        createSidebar(markers);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
      });
    });
  });

});
