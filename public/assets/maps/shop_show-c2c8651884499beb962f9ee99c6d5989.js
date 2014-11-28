function initialize() {
  var $canvas = $("#map_canvas")
    latitude = $canvas.data('lat'),
    longitude = $canvas.data('lng'),
    latlng = null,
    mapOptions = {};
  
  if(latitude && longitude){
    latlng = new google.maps.LatLng(latitude, longitude);
    mapOptions = {
      zoom: 9,
      center: latlng
    };
  }else{
    var center = new google.maps.LatLng(40.41349604970198, 47.647705078125);
    mapOptions = {
      zoom: 7,
      center: center
    };
  }
  
  var map = new google.maps.Map($canvas[0], mapOptions);

  if (latlng){
    addMarker(latlng, map);
  }
}

// Add a marker to the map
function addMarker(location, map) {
  var marker = new google.maps.Marker({
    position: location,
    map: map,
  });
  
  return marker;
}

google.maps.event.addDomListener(window, 'load', initialize);
