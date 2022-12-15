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
    this.#validateData();
    const stops = this.geojsonTarget.dataset["setpoints"]
    this.#fitMapToMarkers(this.#toArray(stops))
  }

  #addMarkersToMap(markers) {
    markers.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const newMarker = document.createElement("div")
      newMarker.className = "marker"
      newMarker.style.backgroundSize = "contain"
      newMarker.style.backgroundRepeat = "no-repeat"
      newMarker.style.width = "35px"
      newMarker.style.height = "35px"
      if (markers[0] === marker){
        newMarker.style.backgroundImage = `url('https://www.freepnglogos.com/uploads/pin-png/flat-design-map-pin-transparent-png-stickpng-18.png')`
      } else{
        newMarker.style.backgroundImage = `url('https://icones.pro/wp-content/uploads/2021/02/icone-de-broche-de-localisation-verte.png')`
      }
        new mapboxgl.Marker(newMarker)
        .setLngLat([ marker[0], marker[1] ])
        .addTo(this.map)

    });
  }

  #fitMapToMarkers(stops) {
    const bounds = new mapboxgl.LngLatBounds();
      stops.forEach((marker) =>{
      bounds.extend([marker[0], marker[1]])
  });
    this.map.fitBounds(bounds, { padding: 70, duration: 5000 });
  }

  async #validateData() {
    const delay = (ms) => new Promise((res) => setTimeout(res, ms));
    if (this.geojsonTarget.dataset["trigger"] === "true") {
      this.buildRoute();
      this.geojsonTarget.dataset["trigger"] = false;
    }
    await delay(5000);
    this.#validateData();
  }

  buildRoute() {
    const geojson = JSON.parse(this.geojsonTarget.dataset["geojson"])
    const stops = this.geojsonTarget.dataset["setpoints"]
    if (this.map._markers.length > 0){
      this.map._markers.forEach((marker) => {
        marker.remove()
      })
    }
    this.setRoute(geojson)
    this.#addMarkersToMap(this.#toArray(stops))
    this.#fitMapToMarkers(this.#toArray(stops))
  }

  setRoute(geojson) {
    if (this.map.getSource("route")) {
      this.map.getSource("route").setData(geojson);
    } else {
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
        'line-width': 4
        }
        });
    }
  }
  // NOTE guys:
  // This method ONLY works to create the markers array for above methods logic using the coordinates of these retrieved from the HTML.
  // It doesn´t convert strings separated with commas to an array.
  #toArray(inputArray){
    let array = []
    const splitArray = inputArray.split(",")
    for(let i=0; i < splitArray.length; i+=2){
      array.push([splitArray[i], splitArray[i + 1]])
    }
    return array
  }
}
