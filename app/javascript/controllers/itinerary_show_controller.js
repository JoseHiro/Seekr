import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="itinerary-show"
export default class extends Controller {
  connect() {
    this.sortable()
  }
  static targets = ["newNameForm", "nameContainer", "name", "itineraryId", "date", "dateForm", "datePencil", "savedItineraryId", "listProducts", "product", "geojson"]

  updateDate(event){
    event.preventDefault()
    const url = `/my_itineraries/${this.savedItineraryIdTarget.value}/update/date`
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.dateFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.dateTarget.outerHTML = data
      })
      this.dateFormTarget.classList.add("d-none")
      this.datePencilTarget.classList.remove("d-none")
  }

  updateName(event){
    event.preventDefault()
    const url = `/my_itineraries/${this.itineraryIdTarget.value}/update/name`
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.newNameFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.nameTarget.outerHTML = data
      })
      this.newNameFormTarget.classList.add("d-none")

  }

  displayNewNameForm(){
    this.nameTarget.classList.add("d-none")
    this.newNameFormTarget.classList.remove("d-none")
  }

  displayDateForm(){
    this.dateTarget.classList.add("d-none")
    this.datePencilTarget.classList.add("d-none")
    this.dateFormTarget.classList.remove("d-none")
  }

  sortable(){
    new Sortable(this.listProductsTarget, {
      animation: 150,
      ghostClass: 'blue-background-class'
  });
  }

  getItineraryCoordinates(){
    const liElements = []
    const coordinates = []
    this.listProductsTarget.childNodes.forEach((node) => {
      if (node.localName === "li"){
        liElements.push(node)
      }
    })
    liElements.forEach((element) => {
      const latitude = element.childNodes[1].childNodes[1].childNodes[7].defaultValue
      const longitude = element.childNodes[1].childNodes[1].childNodes[9].defaultValue
      coordinates.push([longitude, latitude])
    })
    return coordinates
  }

  getRoute(){
    const coordinates = this.getItineraryCoordinates()
    let query = ""
    for(let i=0; i<coordinates.length; i+=1){
      if (coordinates.length - 1 === i){
        query += `${coordinates[i][0]},${coordinates[i][1]}`
      }else{
        query += `${coordinates[i][0]},${coordinates[i][1]};`
      }
    }
    const url = `https://api.mapbox.com/directions/v5/mapbox/cycling/${query}?geometries=geojson&access_token=pk.eyJ1IjoiZXMyMDI1NDYiLCJhIjoiY2xhY3loaXBxMGVmejNwbWwzY3VoNGl3eSJ9.-GjBpqFJ0tTEry0EBCLNfQ`
    fetch(url)
    .then(response => response.json())
    .then((json) => {
      const data = json.routes[0]
      const route = data.geometry.coordinates
      const geojson = {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "LineString",
          "coordinates": route
        }
      }
      this.geojsonTarget.dataset["geojson"] = JSON.stringify(geojson)
      this.geojsonTarget.dataset["trigger"] = true
    })
  }
}
