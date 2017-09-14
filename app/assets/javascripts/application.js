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
    return ("<div class='classes--list-item'><a class='classes--list-item-heading'>" +
      json.serviceObject.title +
      "</a><div class='hide classes--list-item-details'>Style: " +
      json.data.style +
      "<br />" +
      "Teacher: " +
      json.data.teacher_name +
      "<br />" +
      "<a class='classes--list-item-cta' href='/class/" +
      json.data.id +
      "'>More info</a>" +
      "<div class='clearfix'></div>" +
      "</div></div>");
  };

  function bindLiToMarker($li, marker) {
    $li.on('click', function(event){
      handler.getMap().setZoom(14);
      marker.setMap(handler.getMap()); //because clusterer removes map property from marker
      marker.panTo();
      google.maps.event.trigger(marker.getServiceObject(), 'click');
      $(event.target).siblings('.classes--list-item-details').toggleClass('hide');
    })
  };

  function handleMapData(data, meta) {
    $('#classes').html('');
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      markers = handler.addMarkers(data);
      _.each(markers, function(json, index){
        json.data = data[index];
        json.marker = markers[index];
      });
      createSidebar(markers, meta);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    });
  }

  function createSidebar(json_array, meta) {
    $('.next').addClass('hide');
    $('.prev').addClass('hide');
    _.each(json_array, function(json){
      var $li = $( createSidebarLi(json) );
      $li.appendTo('#classes');
      bindLiToMarker($li, json.marker);
    });
    if (meta.next !== null) {
      var nextLink = $('.next');
      nextLink.removeClass('hide');
      nextLink.attr('href', '/classes/markers?page=' + meta.next);
    }
    if (meta.prev !== null) {
      var prevLink = $('.prev');
      prevLink.removeClass('hide');
      prevLink.attr('href', '/classes/markers?page=' + meta.prev);
    }
  };

  if ($('#map').length > 0) {
    $.get('/classes/markers', function(data) {
      handleMapData(data.markers, data.meta);
    });
  }

  $('form[action="/classes/markers"]').submit(function(event) {
    var url = '/classes/markers?' + $(event.target).serialize();
    $.get(url, function(data) {
      handleMapData(data.markers, data.meta);
    });
  });

  $('.next').click(function(event) {
    event.preventDefault();
    var url = $(event.target).attr('href');
    $.get(url, function(data) {
      handleMapData(data.markers, data.meta);
    });
  });

  $('.prev').click(function(event) {
    event.preventDefault();
    var url = $(event.target).attr('href');
    $.get(url, function(data) {
      handleMapData(data.markers, data.meta);
    });
  });
});
