function initialize(){var n={center:new google.maps.LatLng(40.413,47.647),zoom:6},o=$("#map_canvas"),e=new google.maps.Map(o[0],n),a=o.data("mapinfo");bounds=new google.maps.LatLngBounds,$.ajax({url:a,success:function(n){var a=[];$.each(n,function(n,o){var t=new google.maps.LatLng(o.latitude,o.longitude),i=addMarker(t,e);a.push(i),google.maps.event.addListener(i,"click",function(){ShowTooltip(o.info,e,i)}),bounds.extend(t)}),a.length>0&&e.fitBounds(bounds),0!=o.data("clusterize")&&new MarkerClusterer(e,a)}})}function ShowTooltip(n,o,e){$.ajax({url:n,success:function(n){var a=new google.maps.InfoWindow({content:n});a.open(o,e)}})}function addMarker(n,o){return new google.maps.Marker({position:n,map:o})}google.maps.event.addDomListener(window,"load",initialize);