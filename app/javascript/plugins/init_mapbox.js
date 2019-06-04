import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
 const bounds = new mapboxgl.LngLatBounds();
 markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
 map.fitBounds(bounds, { padding: 70, maxZoom: 10 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (!mapElement) {
    return;
  }

  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });

  const markers = JSON.parse(mapElement.dataset.markers);

  markers.forEach(marker => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    new mapboxgl.Marker()
    .setLngLat([ marker.lng, marker.lat ])
    .setPopup(popup)
    .addTo(map);
  });

  fitMapToMarkers(map, markers);

  if (!mapElement.dataset.mapboxGeometry) {
    return;
  }

  const geometry = JSON.parse(mapElement.dataset.mapboxGeometry);

  map.on('load', function() {
    map.addLayer({
      "id": "route",
      "type": "line",
      "source": {
        "type": "geojson",
        "data": {
          "type": "Feature",
          "properties": {},
          "geometry": geometry
        }
      },
      "layout": {
        "line-join": "round",
        "line-cap": "round"
      },
      "paint": {
        "line-color": "#FF7E67",
        "line-width": 3
      }
    });
  });
}

export { initMapbox };
