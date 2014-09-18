function initialize() {
  var center = new google.maps.LatLng(40.41349604970198, 47.647705078125),
      mapOptions = {
        center: center
      },
      map = new google.maps.Map($("#map_canvas")[0], mapOptions),
      shops = GetShops(),
      bounds = new google.maps.LatLngBounds();
  $.each(shops, function(index, shop){
    var location = new google.maps.LatLng(shop.lat, shop.lng)
    addMarker(location, map);
    bounds.extend(location);
  })
  map.fitBounds(bounds)

  google.maps.event.addListenerOnce(map, "bounds_changed", function(event){
    if (this.getZoom() > 14){
      this.setZoom(14);
    }
  })
}

function GetShops(){
  var shops = [];

  $("tr.shop").each(function(index, tr){
    var $tr = $(tr),
      id = $tr.data("id"),
      lat = $tr.data("latitude"),
      lng = $tr.data("longitude");

      shops.push({id:id, lat:lat, lng:lng});
  })

  return shops;
}


function SetGeoloc(latlng){
  $("#shop_latitude").val(latlng.lat());
  $("#shop_longitude").val(latlng.lng());
}

// Add a marker to the map
function addMarker(location, map) {
  return new google.maps.Marker({
    position: location,
    map: map
  });
}

google.maps.event.addDomListener(window, 'load', initialize);