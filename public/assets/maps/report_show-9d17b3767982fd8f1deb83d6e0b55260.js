function initialize(){var a=$("#map_canvas");markers=a.data("markers"),bounds=new google.maps.LatLngBounds,center=new google.maps.LatLng(40.41349604970198,47.647705078125),mapOptions={zoom:7,center:center};var n=new google.maps.Map(a[0],mapOptions);markers&&($.each(markers,function(a,e){var o=new google.maps.LatLng(e.lat,e.lng),r=e.url;addMarker(o,e.tooltip,n,r),bounds.extend(o)}),n.fitBounds(bounds))}function addMarker(a,n,e,o){var r=new google.maps.Marker({position:a,map:e,icon:{url:o,anchor:new google.maps.Point(8,16)},title:n});return r}google.maps.event.addDomListener(window,"load",initialize);