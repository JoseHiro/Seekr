import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="itinerary-show"
export default class extends Controller {
  connect() {
    this.sortable()
  }
  static targets = ["newNameForm", "nameContainer", "name", "itineraryId", "date", "dateForm", "datePencil", "savedItineraryId", "listProducts"]

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
    const url = `/my_itineraries/${this.itineraryIdTarget.value}/get_itinerary`
    fetch(url,{
      method: "GET",
      headers: {"Accept": "application/json"}
    })
      .then(response => console.log(response))
      .then((data) => {
        console.log(data)
      })

  }

  getRoute(){
    this.getItineraryCoordinates
    const url = `https://api.mapbox.com/directions/v5/mapbox/cycling/?geometries=geojson&access_token=pk.eyJ1IjoiZXMyMDI1NDYiLCJhIjoiY2xhY3loaXBxMGVmejNwbWwzY3VoNGl3eSJ9.-GjBpqFJ0tTEry0EBCLNfQ`
  }
}
