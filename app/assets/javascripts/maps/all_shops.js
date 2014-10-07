function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(40.413, 47.647),
    zoom: 6
  };
  var map_container = $("#map_canvas"),
      map = new google.maps.Map(map_container[0], mapOptions),
      url = map_container.data("mapinfo");

  $.ajax({
    url: url,
    success: function(data){
      var markers = [];
      $.each(data, function(index, shop){
        var location = new google.maps.LatLng(shop.latitude, shop.longitude),
            marker = addMarker(location, map);
        markers.push(marker);
        google.maps.event.addListener(marker, 'click', function() {
          ShowTooltip(shop.info, map, marker);
        });
      })
      new MarkerClusterer(map, markers);
    }
  });

}

function ShowTooltip(info, map, marker){
  $.ajax({
    url: info,
    success: function(data){
      var infowindow = new google.maps.InfoWindow({
        content: data
      });
      infowindow.open(map,marker);
    }
  });
}

function addMarker(location, map) {
  return new google.maps.Marker({
    position: location,
    map: map
  });
}

google.maps.event.addDomListener(window, 'load', initialize);