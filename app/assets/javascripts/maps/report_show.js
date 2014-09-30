function initialize() {
  var $canvas = $("#map_canvas")
    markers = $canvas.data('markers'),
    bounds = new google.maps.LatLngBounds(),
    center = new google.maps.LatLng(40.41349604970198, 47.647705078125),
    mapOptions = {zoom: 7, center: center};

  var map = new google.maps.Map($canvas[0], mapOptions);
  
  if(markers){
    $.each(markers, function(index, marker){
      var latlng = new google.maps.LatLng(marker.lat, marker.lng);

      addMarker(latlng, marker.tooltip, map);

      bounds.extend(latlng);
    });

    map.fitBounds(bounds)
  }
}

// Add a marker to the map
function addMarker(location, tooltip, map) {
  var marker = new google.maps.Marker({
    position: location,
    map: map,
    title: tooltip
  });
  
  return marker;
}

google.maps.event.addDomListener(window, 'load', initialize);