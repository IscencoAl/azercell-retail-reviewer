function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(40.413, 47.647),
    zoom: 6
  };
  
  var map_container = $("#map_canvas"),
      url = map_container.data("mapinfo");
      bounds = new google.maps.LatLngBounds();

  var polyOptions = {
    strokeColor: '#000000',
    strokeOpacity: 1.0,
    strokeWeight: 3
  };

  var map = new google.maps.Map(map_container[0], mapOptions);
  var poly = new google.maps.Polyline(polyOptions);
  poly.setMap(map);

  $.ajax({
    url: url,
    success: function(data){
      var markers = [];
      var polyMarkers = [];
      var geoloc = [];
      var dist = 0;

      $.each(data, function(index, point){
        var location = new google.maps.LatLng(point.latitude, point.longitude);
        var marker = addMarker(location, map, poly);

        geoloc.push([point.latitude,point.longitude])
        markers.push(marker);
        polyMarkers.push(location);
        bounds.extend(location);
      })

      if (geoloc.length > 1){
        for(var i = 0; i < geoloc.length - 1; i++){
          dist += distance(geoloc[i][0], geoloc[i][1], geoloc[i+1][0], geoloc[i+1][1])
        }
      }

      if((dist <= 1000) && (dist >= 1)){
        $("#distance").val(dist+" m"); 
      }
      else if(dist > 1000){
        $("#distance").val(dist/1000+" km");
      }
      if (markers.length > 0){
        map.fitBounds(bounds);
      }

    }
  });

  function distance(lat1, lon1, lat2, lon2) {
    var R = 6371; 
    var dLat = (lat2-lat1) * Math.PI / 180;
    var dLon = (lon2-lon1) * Math.PI / 180;
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(lat1 * Math.PI / 180 ) * Math.cos(lat2 * Math.PI / 180 ) *
      Math.sin(dLon/2) * Math.sin(dLon/2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;

    return Math.round(d * 1000);
  }

  function addMarker(location, map, poly) {
    var path = poly.getPath();
    path.push(location);

    return new google.maps.Marker({
      position: location,
      map: map
    });
  }
}

google.maps.event.addDomListener(window, 'load', initialize);