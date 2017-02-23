// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require private_pub
//= require toastr
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

var map,geocoder,request,service,infowindow;

function initMap() {
  'use strict';
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  });

  geocoder = new google.maps.Geocoder();
  geocodeAddress(geocoder, map);

  infowindow = new google.maps.InfoWindow();

}

// 이게 진짜.

function geocodeAddress(geocoder, resultsMap) {
  'use strict';
  var address = document.getElementById('address').firstChild.nodeValue;
  geocoder.geocode({address: address}, function(results, status) {

    if (status===google.maps.GeocoderStatus.OK) {
      resultsMap.setCenter(results[0].geometry.location);
      resultsMap.setZoom(15);

      var cityCircle = new google.maps.Circle({
        strokeColor: '#00a699',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#00a699',
        fillOpacity: 0.35,
        map: map,
        center: results[0].geometry.location,
        radius: 500
      });


      request = {
        location: results[0].geometry.location,
        radius: '500',
        types: ['store']
      };

      service = new google.maps.places.PlacesService(map);
      service.nearbySearch(request, function(results, status) {

        if (status == google.maps.places.PlacesServiceStatus.OK) {
          for (var i = 0; i < results.length; i++) {
            var place = results[i];
            createMarker(map, place);
          }
        }

      });


    } else {
      console.log(address);
      console.log(google.maps.GeocoderStatus);

      console.log('지도가나오지 않는군' + status);
    }
  });
}




function createMarker(map,result){
  var marker = new google.maps.Marker({
    map: map,
    position: result.geometry.location
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(result.name);
    infowindow.open(map, this);
  });
};
