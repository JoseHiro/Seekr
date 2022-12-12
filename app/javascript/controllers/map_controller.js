import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };
  static targets = ["geojson"];

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
    });
    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()
    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    //   mapboxgl: mapboxgl }))
    this.#validateData();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      newMarker = new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  async #validateData() {
    const delay = (ms) => new Promise((res) => setTimeout(res, ms));

    console.log("times");
    if (this.geojsonTarget.dataset["trigger"] === "true") {
      this.buildRoute();
      this.geojsonTarget.dataset["trigger"] = false;
    }
    await delay(5000);
    this.#validateData();
  }

  buildRoute() {
    const geojson = JSON.parse(this.geojsonTarget.dataset["geojson"]);
    this.setRoute(geojson);
  }

  setRoute(geojson) {
    console.log(this.map.getStyle().layers)
    if (this.map.getSource("route")) {
      console.log("esto es if")
      this.map.getSource("route").setData(geojson);
    } else {
      console.log(geojson)
      this.map.addSource('route', {
        'type': 'geojson',
        'data': geojson
        });
        this.map.addLayer({
          'id': 'route',
          'type': 'line',
          'source': 'route',
          'layout': {
          'line-join': 'round',
          'line-cap': 'round'
          },
          'paint': {
          'line-color': '#0C8CE9',
          'line-width': 3
          }
          });
    }
  }
}
