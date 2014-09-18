function initialize() {
  var latitude = $("#shop_latitude").val(),
    longitude = $("#shop_longitude").val(),
    latlng = null,
    mapOptions = {};
  
  if(latitude != "" && longitude != ""){
    latlng = new google.maps.LatLng(latitude, longitude);
    mapOptions = {
      zoom: 14,
      center: latlng
    };
  }else{
    var center = new google.maps.LatLng(40.41349604970198, 47.647705078125);
    mapOptions = {
      zoom: 7,
      center: center
    };
  }
  
  var map = new google.maps.Map($("#map_canvas")[0], mapOptions);

  if (latlng){
    addMarker(latlng, map);
  }
  else{
    google.maps.event.addListener(map, 'click', function(event) {
      addMarker(event.latLng, map);
      SetGeoloc(event.latLng)
    });
  }
}

function SetGeoloc(latlng){
  $("#shop_latitude").val(latlng.lat());
  $("#shop_longitude").val(latlng.lng());
}

// Add a marker to the map
function addMarker(location, map) {
  var marker = new google.maps.Marker({
    position: location,
    map: map,
    draggable:true

  });

  google.maps.event.addListener(
    marker,
    'drag',
    function() {
      SetGeoloc(marker.position)
    }
  );

  google.maps.event.clearListeners(map, 'click')
  
  return marker;
}

google.maps.event.addDomListener(window, 'load', initialize);